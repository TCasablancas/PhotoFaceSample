import Foundation

struct DocumentModel: Codable {
  var transactionId: String?
  var documents: [DocumentDataModel]
}
