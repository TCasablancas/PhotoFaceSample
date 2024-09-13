import UIKit

enum PictureView {
  case frontView
  case backView
}

enum TakePictureState  {
    case takePicture
    case confirmation
}

open class ScanViewModel {
  
    var partnerManager: PartnerManager
    var sideTitle: String = ""
    var transactionID: String = ""
    var documents = [AnyObject]()
    var takePictureState: TakePictureState = .takePicture
  
  init(partnerManager: PartnerManager) {
    self.partnerManager = partnerManager
  }
  
  func setPhotoSide(_ cases: PictureView) -> String {
    switch cases {
    case .backView:  return "Verso"
    case .frontView: return "Frente"
    }
  }
  
  func navigateToNextView(_ viewController: UIViewController) {
    if sideTitle == setPhotoSide(.frontView) {
        takePictureState = .takePicture
      let nextViewController = ScanViewController(viewModel: self, partnerManager: self.partnerManager, viewTitle: "Verso")
      viewController.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    if sideTitle == setPhotoSide(.backView) {
        self.sendPicture()
    }
  }
  
  func appendDocumentPicture(type: String, byte: String) {
    let documentImage: [String:Any] = [
      "type": type,
      "byte": byte
    ]
      if(type=="FRENTE"){
          partnerManager.documentsImages.removeAll()
      } else if (partnerManager.documentsImages.count>1) {
          for index in 1...partnerManager.documentsImages.count-1 {
              partnerManager.documentsImages.remove(at: index)
          }
      }
      
      partnerManager.documentsImages.append(documentImage)
  }
  
  func navigateToPreviewView(_ viewController: UIViewController) {
    if sideTitle == setPhotoSide(.backView) {
      viewController.navigationController?.popViewController(animated: true)
    }
  }
  
  func sendPicture() {
    if partnerManager.documentsImages.count == 2 {
        partnerManager.sendDocumentPicture?()
        print(partnerManager.documentsImages.count)
        print("@! >>> Enviando imagens dos documentos...")
        print("@! >>> Numero final de itens: \(partnerManager.documentsImages.count)")
    }
  }
}
