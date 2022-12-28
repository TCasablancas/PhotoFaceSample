import UIKit

enum PictureView {
  case frontView
  case backView
}

open class ScanViewModel {
  
  var helper: PartnerHelper
  var sideTitle: String = ""
  var transactionID: String = ""
  var documents = [AnyObject]()
  
  init(helper: PartnerHelper) {
    self.helper = helper
  }
  
  func setPhotoSide(_ cases: PictureView) -> String {
    switch cases {
    case .backView:  return "Verso"
    case .frontView: return "Frente"
    }
  }
  
  func navigateToNextView(_ viewController: UIViewController) {
    if sideTitle == setPhotoSide(.frontView) {
      let nextViewController = ScanViewController(viewModel: self, helper: self.helper, viewTitle: "Verso")
      viewController.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    if sideTitle == setPhotoSide(.backView) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.sendPicture()
      }
    }
  }
  
  func appendDocumentPicture(type: String, byte: String) {
    let documentImage: [String:Any] = [
      "type": type,
      "byte": byte
    ]
    helper.documentsImages.append(documentImage)
  }
  
  func navigateToPreviewView(_ viewController: UIViewController) {
    if sideTitle == setPhotoSide(.backView) {
      viewController.navigationController?.popViewController(animated: true)
    }
  }
  
  func setImageType(_ type: String) {
      if sideTitle == setPhotoSide(.frontView) {
          helper.setDocumentImageTypeFront(type)
      } else {
          helper.setDocumentImageTypeBack(type)
      }
  }
  
  func setImageSize(_ size: String) {
    helper.getDocumentImageSize(size)
  }
  
  func sendPicture() {
    if helper.documentsImages.count == 2 {
      helper.sendDocumentPicture?()
      print("@! >>> Numero final de itens: \(helper.documentsImages.count)")
      print("@! >>> Enviando imagens dos documentos...")
    }
  }
}
