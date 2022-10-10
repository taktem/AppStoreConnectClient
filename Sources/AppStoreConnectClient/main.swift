import Foundation

let apps = try await AppStoreConnectRepository.Apps().fetch()
let jsonData = try JSONEncoder().encode(apps)
let json = String(data: jsonData, encoding: .utf8)!
print(json)
