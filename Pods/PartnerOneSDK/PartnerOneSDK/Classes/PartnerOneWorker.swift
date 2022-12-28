import UIKit

//MARK: - Protocol

protocol PartnerOneWorkerProtocol: AnyObject {
  func sendPictures(transactionId: String,
                    typeFront: String,
                    byteFront: String,
                    typeBack: String,
                    byteBack: String,
                    completion: @escaping (_ response: Response<DocumentModel>) -> Void)
  func getSession(completion: @escaping ((Response<SessionModel>) -> Void))
}


