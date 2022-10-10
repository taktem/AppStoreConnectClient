//
//  Created by taktem on 2022/10/04
//

import Foundation
import JWTKit

final class AppStoreConnectTokenGenerator {
    struct Error: Swift.Error {
        let value: String
    }

    private struct AppStoreConectPayload: JWTPayload {
        private enum CodingKeys: String, CodingKey {
            case issueID = "iss"
            case issuedAtTime = "iat"
            case expiration = "exp"
            case audience = "aud"
        }
        
        let issueID: IssuerClaim
        let issuedAtTime: Date
        let expiration: ExpirationClaim
        let audience: AudienceClaim = "appstoreconnect-v1"
        
        func verify(using signer: JWTSigner) throws {
            try self.expiration.verifyNotExpired()
        }
    }

    static func generate() throws -> String {
        guard
            let issueID = ProcessInfo.processInfo.environment["APPLE_API_ISSURE_ID"],
            let keyContent = ProcessInfo.processInfo.environment["APPLE_API_KEY_CONTENT"],
            let keyID = ProcessInfo.processInfo.environment["APPLE_API_KEY_ID"],
            let signer = try? JWTSigner.es256(key: ECDSAKey.private(pem: keyContent)) else {
            throw Error(value: "App Store Connect settings API Key required.")
        }

        let startAt = Date()
        let payload = AppStoreConectPayload(
            issueID: .init(value: issueID),
            issuedAtTime: startAt,
            expiration: .init(value: .init(timeInterval: 2 * 60, since: startAt))
        )

        return try! signer.sign(payload, kid: JWKIdentifier(string: keyID))
    }
}
