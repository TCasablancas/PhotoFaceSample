import UIKit

struct ErrorResponse: Codable {
  
  var logref: String?
  var message: String?
  
  enum CodingKeys: String, CodingKey {
    case logref
    case message
  }
  
  init(from decoder: Decoder) throws {
    let data = try decoder.container(keyedBy: CodingKeys.self)
    self.logref = try data.decodeIfPresent(String.self, forKey: .logref)
    self.message = try data.decodeIfPresent(String.self, forKey: .message)
  }
}
