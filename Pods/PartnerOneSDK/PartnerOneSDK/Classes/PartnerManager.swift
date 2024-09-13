import UIKit
import FaceTecSDK

open class PartnerManager {
  
  //MARK: - Public Properties
  
  private var processor: LivenessCheckProcessor?
  
  public var sendDocumentPicture: (() -> Void)?
  public var onNavigateToFaceCapture: (() -> Void)?
  public var waitingFaceTecResponse: (() -> Void)?
  public static var livenessCallBack: ((_ faceScan:String, _ auditTrailImage:String ,_ lowQualityAuditTrailImage:String) -> Void)?
        
    public static var livenessCancelCallBack: (()-> Void)?
    
  public var navigateToStatus: (() -> Void)?
  public var onSuccessFaceTec: (() -> Void)?
  
  public var currentViewController: UIViewController?
  
  public var transaction: String = ""
  public var sessionToken: String = ""
  public var faceTecDeviceKeyIdentifier: String = ""
  public var faceTecPublicFaceScanEncryptionKey: String = ""
  public var faceTecProductionKeyText: String = ""
    
    public var faceScan: String = ""
    public var auditTrailImage: String = ""
    public var lowQualityAuditTrailImage: String = ""
    
    private var documentImageTypeFront: String = ""
    private var documentImageTypeBack: String = ""
    
    
  
  public var documentsImages = [[String:Any]]()
  public var documentType: String = ""
  public var documentByte: String = ""
  
  public var getFaceScan: String = ""
  public var getAuditTrailImage: String = ""
  public var getLowQualityAuditTrailImage: String = ""
  
  public var wasProcessed: Bool = false
  public var faceScanResultCallback: FaceTecFaceScanResultCallback?
  
  //MARK: - init

  public init() {}
  
  //MARK: - Public Functions
  
  public func initializeSDK(_ viewController: UIViewController) {
    let mainViewModel = ScanViewModel(partnerManager: self)
    viewController.navigationController?.pushViewController(
        ScanViewController(viewModel: mainViewModel, partnerManager: self), animated: true
    )
  }
  
  public func startFaceCapture() -> UIViewController {
    let mainViewModel = ScanViewModel(partnerManager: self)
    let viewController = FacialScanViewController(viewModel: mainViewModel, partnerManager: self)
    processor?.partnerManager = self
    return viewController
  }
  
  public func startDocumentCapture() -> UIViewController {
    let mainViewModel = ScanViewModel(partnerManager: self)
    return ScanViewController(viewModel: mainViewModel, partnerManager: self, viewTitle: "Frente")
  }
  
  public func transactionId(_ id: String = "") -> String {
    return id
  }
  
  public func sessionToken(_ token: String = "") -> String {
    return token
  }
  
  public func createUserAgentForNewSession() -> String {
    return FaceTec.sdk.createFaceTecAPIUserAgentString("")
  }
  
  public func createUserAgentForSession(_ sessionToken: String = "") -> String {
    return FaceTec.sdk.createFaceTecAPIUserAgentString(sessionToken)
  }
  
  public func setDocumentType(_ type: String) {
    documentType = type
  }
  
  public func getDocumentImageType() -> String {
    return documentType
  }
    public func setDocumentImageTypeFront(_ type: String = "") -> Void {
    documentImageTypeFront = type
    }
    
    public func getDocumentImageTypeBack() -> String {
        return documentImageTypeBack
    }
    public func setDocumentImageTypeBack(_ type: String = "") -> Void {
      documentImageTypeBack = type
    }
  
  public func getDocumentImageSize(_ size: String = "") -> String {
    return size
  }
  
  public func lastViewController(_ viewController: UIViewController = UIViewController()) -> UIViewController {
    return viewController
  }
  
  public func faceScanBase64() -> String {
    let mainViewModel = ScanViewModel(partnerManager: self)
    let viewController = FacialScanViewController(viewModel: mainViewModel, partnerManager: self)
    return viewController.faceScanBase64
  }
}
