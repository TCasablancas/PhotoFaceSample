import UIKit
import Alamofire
import ObjectMapper

protocol AccessTokeProtocol: AnyObject {
  var accessToken: String { get set }
}

protocol PhotoFaceWorkerProtocol: AnyObject {
  func parseMainData(_ completion: @escaping (Response<ResponseModel<ObjectReturnModel>>) -> Void)
  func getTransaction(cpf: String, completion: @escaping (Response<ResponseModel<TransactionModel>>) -> Void)
  func getTransactionID(transactionID: String, completion: @escaping ((Response<ResponseModel<TransactionIDModel>>) -> Void))
  func getCredentials(completion: @escaping (Response<ResponseModel<FaceTecDataModel>>) -> Void)
  func sendDocumentPictures(transactionId: String, documents: [String:Any], completion: @escaping ((Response<ResponseModel<DocumentDataModel>>) -> Void))
  func getSession(userAgent: String, deviceKey: String, completion: @escaping ((Response<ResponseModel<SessionIDModel>>) -> Void))
  func getLiveness(transactionID: String,
                   faceScan: String,
                   auditTrailImage: String,
                   lowQualityAuditTrailImage: String,
                   sessionId: String,
                   deviceKey: String,completion: @escaping ((Response<ResponseModel<LivenessModel>>) -> Void))
}

class PhotoFaceWorker: Request, PhotoFaceWorkerProtocol, AccessTokeProtocol {
  
  let network = DataParser()
  var apiURL: String = "https://integracao-sodexo-homologacao.partner1.com.br/api"
//  var apiURL: String = "https://integracao-sodexo.partner1.com.br/api"
  let webhookURL: String = "https://webhook.site/a06873e0-57ff-49b2-8205-59fb18b5ca4c"
  
  var accessToken: String
  
  init(accessToken: String = "") {
    self.accessToken = accessToken
      
  }
  
  func parseMainData(_ completion: @escaping (Response<ResponseModel<ObjectReturnModel>>) -> Void) {
    guard let url = URL(string: "\(apiURL)/authentication") else {
      return
    }
       
      

//    let body: [String:Any] = [
//      "username": "SODEXO.HMG",
//      "password": "ifnEQrBy",
//      "grant_type": "password"
//    ]
      
      let body: [String:Any] = [
        "username": "SODEXO.B2M",
        "password": "MI0tQfQt",
        "grant_type": "password"
      ]
    
//      let body: [String:Any] = [
//        "username": "SODEXO",
//        "password": "8VXow3ocmY8D17Cd",
//        "grant_type": "password"
//      ]
    
    network.mainParser(url: url, body: body, method: .post, completion: completion)
  }
  
  func getTransaction(cpf: String,
                      completion: @escaping (Response<ResponseModel<TransactionModel>>) -> Void) {
    guard let url = URL(string: "\(apiURL)/transaction") else {
      return
    }
    
    let body: [String:Any] = [
      "cpf": cpf
    ]
    
    network.loginParser(url: url, body: body, header: accessToken, method: .post, completion: completion)
  }
  
  func getTransactionID(transactionID: String, completion: @escaping ((Response<ResponseModel<TransactionIDModel>>) -> Void)) {
    guard let url = URL(string: "\(apiURL)/transaction/\(transactionID)") else {
      return
    }
    
    network.getParser(url: url, header: accessToken, method: .get, completion: completion)
  }
  
  func getCredentials(completion: @escaping (Response<ResponseModel<FaceTecDataModel>>) -> Void) {
    guard let url = URL(string: "\(apiURL)/credentials") else {
      return
    }
    
    network.getParser(url: url, header: accessToken, method: .get, completion: completion)
  }
  
  func sendDocumentPictures(transactionId: String,
                            documents: [String:Any],
                            completion: @escaping ((Response<ResponseModel<DocumentDataModel>>) -> Void)) {
    guard let url = URL(string: "\(apiURL )/document") else {
//      guard let url = URL(string: "https://webhook.site/6ba2afac-f729-4e69-b3d8-056143dd1891/document") else {
      return
    }
    
    network.loginParser(url: url, body: documents, header: accessToken, method: .post, completion: completion)
  }
  
  func getSession(userAgent: String,
                  deviceKey: String,
                  completion: @escaping ((Response<ResponseModel<SessionIDModel>>) -> Void)) {
    guard let url = URL(string: "\(apiURL)/session") else {
      return
    }
    
    network.getParser(url: url, header: accessToken, method: .get, isSession: true, userAgent: userAgent, xDeviceKey: deviceKey, completion: completion)
  }
    

  
  func getLiveness(transactionID: String,
                   faceScan: String,
                   auditTrailImage: String,
                   lowQualityAuditTrailImage: String,
                   sessionId: String,
                   deviceKey: String,
                   completion: @escaping ((Response<ResponseModel<LivenessModel>>) -> Void)) {
    guard let url = URL(string: "\(apiURL)/liveness") else {
      return
    }
    
    let body: [String:Any] = [
      "transactionId": transactionID,
      "faceScan": faceScan,
      "auditTrailImage": auditTrailImage,
      "lowQualityAuditTrailImage": lowQualityAuditTrailImage,
      "sessionId": sessionId,
      "deviceKey": deviceKey
    ]
    
    network.loginParser(url: url, body: body, header: accessToken, method: .post, completion: completion)
  }
}
