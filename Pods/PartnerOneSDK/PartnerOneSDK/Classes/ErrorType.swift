import Foundation

enum ErrorType: Error {
  case connectedToInternet
  case errorDefault
  case errorAPI(error: String)
  
  var description: String {
    switch self {
    case .connectedToInternet:
      return "O dispositivo está sem conexão com a internet neste momento."
    case .errorDefault:
      return "Não foi possível completar a requisição no momento."
    case .errorAPI(let error):
      return error
    }
  }
}
