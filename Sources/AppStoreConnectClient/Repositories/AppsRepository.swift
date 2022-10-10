//
//  Created by taktem on 2022/10/09
//

import Foundation
import APIClient

enum AppStoreConnectRepository {
    private static func AuthorizedHeader() async throws -> [String: String] {
        let token = try AppStoreConnectTokenGenerator.generate()
        return ["Authorization": "Bearer \(token)"]
    }

    struct Apps {
        func fetch() async throws -> [AppStoreConnect.App] {
            let header = try await AuthorizedHeader()
            let result = try await APIClient().connect(config: AppsRequest.Get(headers: header))
            return result.data.map { AppStoreConnect.App(
                identifier: .init(value: $0.id),
                name: $0.attributes.name
            )}
        }
    }
}


// Data Store
private let appStoreConnectAPIBase = "https://api.appstoreconnect.apple.com"

private enum AppsRequest {
    struct AppDTO: Decodable {
        struct ResponseData: Decodable {
            struct Attributes: Decodable {
                let name: String
            }
            let id: String
            let attributes: Attributes
        }
        let data: [ResponseData]
    }

    struct Get: DecodableRequestConfiguration {
        typealias Response = AppDTO

        let method = Method.get
        let endpoint = Endpoint(hostName: appStoreConnectAPIBase, path: "/v1/apps")
        let headers: [String : String]
        let parameters: [String : Any] = [:]
    }
}
