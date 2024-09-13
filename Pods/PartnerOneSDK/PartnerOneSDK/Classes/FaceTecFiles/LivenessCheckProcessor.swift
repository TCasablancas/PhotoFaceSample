import UIKit
import Foundation
import FaceTecSDK

open class LivenessCheckProcessor: NSObject, Processor, FaceTecFaceScanProcessorDelegate, URLSessionTaskDelegate {
//  var latestNetworkRequest: URLSessionTask!
    var success = false
    var fromViewController: FacialScanViewController
    var sessionToken: String
    var faceScanResultCallback: FaceTecFaceScanResultCallback!

    public var faceScan: String = ""
    var partnerManager = PartnerManager()
    
    private var userCanceled = false

    init(sessionToken: String, fromViewController: FacialScanViewController) {
        self.sessionToken = sessionToken
        self.fromViewController = fromViewController
        super.init()
    }
    
    func start() {
        let livenessCheckViewController = FaceTec.sdk.createSessionVC(faceScanProcessorDelegate: self, sessionToken: sessionToken)
        fromViewController.present(livenessCheckViewController, animated: true, completion: nil)
    }
    
  
    public func processSessionWhileFaceTecSDKWaits(sessionResult: FaceTecSessionResult, faceScanResultCallback: FaceTecFaceScanResultCallback) {
      
        guard sessionResult.status == .sessionCompletedSuccessfully else {
          
            if sessionResult.status == .userCancelled {
                print("Usuáio cancelou")
                faceScanResultCallback.onFaceScanResultCancel()
                PartnerManager.livenessCancelCallBack?()
                return
            }

            if sessionResult.status != .sessionCompletedSuccessfully {
                faceScanResultCallback.onFaceScanResultCancel()
                return
            }
          
            return
        }

        self.partnerManager.faceScan=(sessionResult.faceScanBase64 ?? "")
        self.partnerManager.auditTrailImage=(sessionResult.auditTrailCompressedBase64?[0] ?? "")
        self.partnerManager.lowQualityAuditTrailImage=(sessionResult.lowQualityAuditTrailCompressedBase64?[0] ?? "")

        //fromViewController.setLatestSessionResult(sessionResult: sessionResult)

        self.faceScanResultCallback = faceScanResultCallback
        self.fromViewController.processorResponse?()

        print("@! >>> Escaneamento facial feito. Fazendo checagem...")
    
        PartnerManager.livenessCallBack!(sessionResult.faceScanBase64 ?? "", sessionResult.auditTrailCompressedBase64?[0] ?? "", sessionResult.lowQualityAuditTrailCompressedBase64?[0] ?? "")
      faceScanResultCallback.onFaceScanResultCancel()
  }
  
  public func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
    let uploadProgress: Float = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
    faceScanResultCallback.onFaceScanUploadProgress(uploadedPercent: uploadProgress)
  }
  
  public func onFaceTecSDKCompletelyDone() {
      if !userCanceled {
          self.fromViewController.onComplete();
      }
  }
  
  func isSuccess() -> Bool {
    return success
  }
}
