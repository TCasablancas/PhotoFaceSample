import Foundation

struct CredentialsModel: Codable {
  var certificate: String?
  var deviceKeyIdentifier: String?
  var productionKeyText: String?
}
