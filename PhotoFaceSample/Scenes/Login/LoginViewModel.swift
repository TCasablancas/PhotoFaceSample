import UIKit

protocol PhotoFaceNavigationDelegate: AnyObject {
  func openSDK()
  func openStatusView()
}

protocol LoginViewModelProtocol {
  func getData(_ completion: @escaping (_ response: Response<LoginModel?>) -> Void)
}

class LoginViewModel: LoginViewModelProtocol {
  
  private weak var navigationDelegate: PhotoFaceNavigationDelegate?
  
  init(navigationDelegate: PhotoFaceNavigationDelegate? = nil) {
    self.navigationDelegate = navigationDelegate
  }
  
  func getData(_ completion: @escaping (Response<LoginModel?>) -> Void) {
    guard let url = URL(string: "https://integracao-sodexo-homologacao.partner1.com.br/swagger/v1/swagger.json") else {
      return
    }
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let dataResponse = data,
            error == nil else {
        print(error?.localizedDescription ?? "Response Error")
        return }
      do {
        let decoder = JSONDecoder()
        let response = try? decoder.decode(LoginModel.self, from: dataResponse)
        
        if let response = response {
          completion(.success(model: response))
        } else {
          print("Not possible to parse...")
        }
        
      } catch let parsingError {
        print("Sorray... The data could not be parsed for some reason.", parsingError)
      }
    }
    task.resume()
  }
}

// MARK: - Navigation Delegate

extension LoginViewModel: PhotoFaceNavigationDelegate {
  func openSDK() {
    navigationDelegate?.openSDK()
  }
  
  func openStatusView() {
    navigationDelegate?.openStatusView()
  }
}
