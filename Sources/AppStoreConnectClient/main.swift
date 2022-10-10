import Foundation

let token = try AppStoreConnectTokenGenerator.generate()
let url = URL(string: "https://api.appstoreconnect.apple.com//v1/apps")!
var request = URLRequest(url: url)
request.allHTTPHeaderFields = [
    "Authorization": "Bearer \(token)"
]
let response = try await URLSession.shared.data(for: request)
let responseString = String(data: response.0, encoding: .utf8)
print(responseString as Any)
