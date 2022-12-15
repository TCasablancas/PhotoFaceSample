import UIKit
import PartnerOneSDK

struct Status {
  var message: String
  
  mutating func set(msg: String) {
    message = msg
  }
}

class StatusViewModel {
  
  //MARK: - Properties
  
  var viewController: StatusViewController?
  let worker: PhotoFaceWorker
  var helper: PartnerHelper
  
  var didChangeStatus: (() -> Void)?
  var dismissStatus: (() -> Void)?
  
  var session: String?
  var livenessCode: Int?
  var livenessMessage: String?
  var deviceKeyIdentifier: String = ""
  var transactionID: String
  var status: Int?
  var statusDescription: String?
  var timer: Timer?
  
  //MARK: - init
  
  init(worker: PhotoFaceWorker = PhotoFaceWorker(),
       helper: PartnerHelper = PartnerHelper(),
       transactionID: String = "") {
    self.worker = worker
    self.helper = helper
    self.transactionID = transactionID
  }
  
  
  /// TransactionID getter
  ///
  func setupTransactionID() {
    worker.getTransactionID(transactionID: transactionID) { [weak self] (response) in
      guard let self = self else { return }
      
      switch response {
      case .success(let model):
        self.status = model.objectReturn[0].result[0].status
        self.statusDescription = String(model.objectReturn[0].result[0].statusDescription)
        
        self.didChangeStatus?()
        
        self.navigateToView(self.status!)
        
        print("@! >>> Status: ", model.objectReturn[0].result[0].statusDescription)
      case .noConnection(let description):
        print("Server error timeOut: \(description) \n")
      case .serverError(let error):
        let errorData = "\(error.statusCode), -, \(error.msgError)"
        print("Server error: \(errorData) \n")
        break
      case .timeOut(let description):
        print("Server error noConnection: \(description) \n")
      }
    }
  }
  
  func createSession() {
    worker.getSession(userAgent: helper.createUserAgentForNewSession(),
                      deviceKey: helper.faceTecDeviceKeyIdentifier) { [weak self] (response) in
      guard let self = self else { return }
      
      switch response {
      case .success(let model):
        self.session = model.objectReturn[0].session
        self.helper.sessionToken = model.objectReturn[0].session
        
        print("@! >>> Session: ", String(self.session!))
          
        self.helper.waitingFaceTecResponse = {
          
          print("@! >>> Processamento finalizado.")
          print("@! >>> Enviando foto para FaceTec...")
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.setupLiveness(faceScan: self.helper.getFaceScan,
                               auditTrailImage: self.helper.getAuditTrailImage,
                               lowQualityAuditTrailImage: self.helper.getLowQualityAuditTrailImage)
          }
        }
        
        
      case .noConnection(let description):
        print("Server error timeOut: \(description) \n")
      case .serverError(let error):
        let errorData = "\(error.statusCode), -, \(error.msgError)"
        print("Server error: \(errorData) \n")
        break
      case .timeOut(let description):
        print("Server error noConnection: \(description) \n")
      }
    }
  }
  
  func setupLiveness(faceScan: String, auditTrailImage: String, lowQualityAuditTrailImage: String) {
    worker.getLiveness(transactionID: self.transactionID,
                       faceScan: faceScan,
                       auditTrailImage: auditTrailImage,
                       lowQualityAuditTrailImage: lowQualityAuditTrailImage,
                       sessionId: helper.createUserAgentForSession(self.session ?? ""),
                       deviceKey: helper.faceTecDeviceKeyIdentifier) { [weak self] (response) in
      guard let self = self else { return }
      
      switch response {
      case .success(let model):
        self.livenessCode = model.objectReturn[0].code
        self.livenessMessage = model.objectReturn[0].description
        
        guard let code = self.livenessCode,
              let message = self.livenessMessage else {
          return
        }
        
        print("@! >>> Liveness Code: \(code)")
        print("@! >>> Liveness Message: \(message)")
        
        DispatchQueue.main.async {
          let statusVC = StatusViewController(viewModel: self)
          self.viewController?.navigationController?.pushViewController(statusVC, animated: true)
        }
      case .noConnection(let description):
        print("Server error timeOut: \(description) \n")
      case .serverError(let error):
        let errorData = "\(error.statusCode), -, \(error.msgError)"
        print("Server error: \(errorData) \n")
        break
      case .timeOut(let description):
        print("Server error noConnection: \(description) \n")
      }
    }
  }

}

//MARK: - Functions

extension StatusViewModel {
  
  /// Navigation Matrix Decision
  /// 
  func navigateToView(_ status: Int = 0) {
    switch status {
    case 0:
      break
    case 1:
      self.timer?.invalidate()
      setApproved()
    case 2:
      self.timer?.invalidate()
      setReproved()
    case 3:
      self.timer?.invalidate()
      dismissStatus?()
      break
    case 4:
      self.timer?.invalidate()
      openDocumentCapture()
    default:
      break
    }
  }
  
  /// Trigger to refresh status
  ///
  func triggerGetStatus() {
    self.timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true, block: { (timer) in
      self.setupTransactionID()
    })
  }
  
  func setApproved(_ label: UILabel = UILabel()) {
    label.text = self.statusDescription
    label.textColor = .systemGreen
  }
  
  func setReproved(_ label: UILabel = UILabel()) {
    label.text = self.statusDescription
    label.textColor = .systemRed
  }
  
  func openFaceCapture(_ viewController: UIViewController) {
    createSession()
    let faceCaptureViewController = helper.startFaceCapture()
    faceCaptureViewController.navigationController?.hidesBottomBarWhenPushed = true
    viewController.navigationController?.pushViewController(faceCaptureViewController, animated: true)
    print("@! >>> Abrindo face scan...")
  }
  
  private
  func openDocumentCapture() {
    let documentViewController = helper.startDocumentCapture()
    viewController?.navigationController?.pushViewController(documentViewController, animated: true)
    print("@! >>> Abrindo captura de documento...")
  }
}
