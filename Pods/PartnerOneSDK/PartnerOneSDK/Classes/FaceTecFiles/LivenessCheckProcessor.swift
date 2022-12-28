import UIKit
import Foundation
import FaceTecSDK

open class LivenessCheckProcessor: NSObject, Processor, FaceTecFaceScanProcessorDelegate, URLSessionTaskDelegate {
  var latestNetworkRequest: URLSessionTask!
  var success = false
  var fromViewController: FacialScanViewController!
  var faceScanResultCallback: FaceTecFaceScanResultCallback!
  
  public var faceScan: String = ""
  var helper = PartnerHelper()
  
  init(sessionToken: String, fromViewController: FacialScanViewController) {
    self.fromViewController = fromViewController
    super.init()
    
    let livenessCheckViewController = FaceTec.sdk.createSessionVC(faceScanProcessorDelegate: self, sessionToken: sessionToken)
    fromViewController.present(livenessCheckViewController, animated: true, completion: nil)
  }
  
  public func processSessionWhileFaceTecSDKWaits(sessionResult: FaceTecSessionResult, faceScanResultCallback: FaceTecFaceScanResultCallback) {
    
    if sessionResult.status != FaceTecSessionStatus.sessionCompletedSuccessfully {
      if latestNetworkRequest != nil {
        latestNetworkRequest.cancel()
      }
      
      faceScanResultCallback.onFaceScanResultCancel()
      return
    }
    
    fromViewController.setLatestSessionResult(sessionResult: sessionResult)
    
    self.faceScanResultCallback = faceScanResultCallback
    self.fromViewController.processorResponse?()
    
    print("@! >>> Escaneamento facial finalizado. Fazendo checagem...")
    
    fromViewController.faceTecLivenessData(faceScanBase: sessionResult.faceScanBase64 ?? "",
                                           auditTrailImage: sessionResult.auditTrailCompressedBase64?[0] ?? "",
                                           lowQualityAuditTrailImage: sessionResult.lowQualityAuditTrailCompressedBase64?[0] ?? "",
                                           completion: {
      PartnerHelper.livenessCallBack?(sessionResult.faceScanBase64 ?? "",
                                      sessionResult.auditTrailCompressedBase64?[0] ?? "",
                                      sessionResult.lowQualityAuditTrailCompressedBase64?[0] ?? "")
    })
    
    faceScanResultCallback.onFaceScanResultCancel()
  }
  
  public func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
    let uploadProgress: Float = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
    faceScanResultCallback.onFaceScanUploadProgress(uploadedPercent: uploadProgress)
  }
  
  public func onFaceTecSDKCompletelyDone() {
    self.fromViewController.onComplete();
  }
  
  func isSuccess() -> Bool {
    return success
  }
}
