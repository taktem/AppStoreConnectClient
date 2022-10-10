//
//  Created by taktem on 2022/10/09
//

import Foundation

enum AppStoreConnect {}

extension AppStoreConnect {
    struct App: Encodable {
        struct Identifier: Encodable {
            let value: String
        }
        
        let identifier: Identifier
        let name: String
    }
}
