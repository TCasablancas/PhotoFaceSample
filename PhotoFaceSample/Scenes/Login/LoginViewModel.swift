import UIKit
import Alamofire
import PartnerOneSDK

//MARK: - Protocols

protocol LogiViewModelProtocol: AnyObject {
  var worker: PhotoFaceWorker { get }
}

/// Just for navigation Purposes
///
protocol PhotoFaceNavigationDelegate: AnyObject {
  func openSDK(_ viewController: UIViewController)
  func openStatusView()
}

//MARK: - Class

class LoginViewModel: LogiViewModelProtocol, AccessTokeProtocol {
  
  //MARK: - Properties
  
  weak var viewController: LoginViewController?
  private weak var navigationDelegate: PhotoFaceNavigationDelegate?
  private var decisionMatrix: DecisionMatrix?
  
  let helper = PartnerHelper()
  let worker: PhotoFaceWorker
  var transactionID: String = ""
  var accessToken: String = ""
  var statusDescription: String?
  
  ///FaceTec properties
  ///
  var certificate: String?
  var productionKeyText: String?
  var deviceKeyIdentifier: String?
  
  //MARK: - init
  
  init(worker: PhotoFaceWorker,
       navigationDelegate: PhotoFaceNavigationDelegate? = nil) {
    self.worker = worker
    self.navigationDelegate = navigationDelegate
  }
  
}

//MARK: - API Info Functions

extension LoginViewModel {
  
  func getInitialData() {
    print("@! >>> Begin main data fetch...")
    
    worker.parseMainData { [weak self] (response) in
      guard let self = self else { return }
      switch response {
      case .success(let model):
        /// Passes AccessToken to Worker Layer
        ///
        self.worker.accessToken = model.objectReturn[0].accessToken
        self.accessToken = model.objectReturn[0].accessToken
        
        print("@! >>> ACCESS_TOKEN: ", model.objectReturn[0].accessToken)
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
  
  /// Login Authentication
  /// 
  func sendCPFAuth(cpf: String, completion: @escaping (() -> Void)) {
    worker.getTransaction(cpf: cpf) { [weak self] (response) in
      guard let self = self else { return }
      
      switch response {
      case .success(let model):
        /// Get and passa TransactionID to SDK Helper
        ///
        self.helper.transactionID = String(model.objectReturn[0].transactionId!)
        self.transactionID = String(model.objectReturn[0].transactionId!)
        
        /// Navigate to SDK after API response 200
        ///
        if let viewController = self.viewController {
          self.openSDK(viewController)
        }
        
        self.setupTransactionID(self.transactionID)
        
        print("@! >>> TRANSACTION_ID: \(String(model.objectReturn[0].transactionId!))")
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
  
  /// First time getting TransactionID
  ///
  func setupTransactionID(_ transactionID: String) {
    
    worker.getTransactionID(transactionID: transactionID) { [weak self] (response) in
      guard let self = self else { return }
      
      switch response {
      case .success(let model):
        self.statusDescription = String(model.objectReturn[0].result[0].statusDescription!)
        
        /// Erase prints below
        ///
        print("@! >>> STATUS_ID: ", Int(model.objectReturn[0].result[0].status!))
        print("@! >>> STATUS_DESCRIPTION", String(model.objectReturn[0].result[0].statusDescription!))
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
  
  func getCredentials() {
    worker.getCredentials { [weak self] (response) in
      guard let self = self else { return }
      
      switch response {
      case .success(let model):
        self.certificate = String(model.objectReturn[0].certificate!)
        self.deviceKeyIdentifier = String(model.objectReturn[0].deviceKeyIdentifier!)
        self.productionKeyText = String(model.objectReturn[0].productionKeyText!)
        
        /// Erase prints below
        ///
        print("@! >>> CERTIFICATE: ", String(model.objectReturn[0].certificate!))
        print("@! >>> DEVICE_KEY_IDENTIFIER: ", String(model.objectReturn[0].deviceKeyIdentifier!))
        print("@! >>> PRODUCTION_KEY: ", String(model.objectReturn[0].productionKeyText!))
      
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

// MARK: - Navigation Delegate

extension LoginViewModel {
  func openSDK(_ viewController: UIViewController) {
    helper.initializeSDK(viewController)
  }
  
  func openStatusView(_ viewController: UIViewController) {
    let mainViewModel = StatusViewModel()
    mainViewModel.transactionID = transactionID
    mainViewModel.statusDescription = statusDescription
    let mainViewController = StatusViewController(viewModel: mainViewModel)
    viewController.navigationController?.pushViewController(mainViewController, animated: true)
  }
}
