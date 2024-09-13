import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case set = "SET"
  case delete = "DELETE"
}

struct DataParser {
  func mainParser<T: Codable>(url: URL,
                              body: [String:Any] = [:],
                              method: HTTPMethod,
                              completion: @escaping ((Response<T>) -> Void)) {
    
    let jsonData = try? JSONSerialization.data(withJSONObject: body)
    
    var request = URLRequest(url: url)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "\(method)"
    request.httpBody = jsonData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        return
      }
      
      let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
      
      if let responseJSON = responseJSON as? [String: Any] {
        print(responseJSON)
        
      }
      
      
      //      Alamofire.request(request).response { (response) in
      //        guard let statusCode = response.response?.statusCode,
      //              let data = response.data else {
      //          return
      //        }
      //
      //        print("@! >>> STATUS_CODE: ", statusCode)
      //
      //        if statusCode == 200 {
      //          let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
      //
      //          guard let item = responseJSON as? [String:Any] else {
      //            return
      //          }
      //
      //          let model = Mapper<T>().map(JSON: item)
      //          completion(.success(model: model!))
      //        } else {
      //          print(error?.localizedDescription ?? "Não conseguimos receber os dados da API...")
      //        }
      //      }
    }
    task.resume()
  }
  
  func sessionParser<T: Codable>(url: URL,
                                 body: [String:Any] = [:],
                                 headers: [String:String] = [:],
                                 method: HTTPMethod,
                                 completion: @escaping ((Response<T>) -> Void)) {
    
    let jsonData = try? JSONSerialization.data(withJSONObject: body)
    
    var request = URLRequest(url: url)
    //    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "User-Agent")
    request.addValue("application/json", forHTTPHeaderField: "X-Device-Key")
    request.httpMethod = "\(method)"
    request.httpBody = jsonData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        return
      }
      let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
      
      if let responseJSON = responseJSON as? [String: Any] {
        print(responseJSON)
      }
      
      //      Alamofire.request(url, method: method, encoding: URLEncoding.default, headers: headers)
      //        .responseJSON { (response) in
      //          guard let statusCode = response.response?.statusCode,
      //                let data = response.data else {
      //            return
      //          }
      //
      //          print("@! >>> STATUS_CODE: ", statusCode)
      //
      //          if statusCode == 200 {
      //            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
      //
      //            guard let item = responseJSON as? [String:Any] else {
      //              return
      //            }
      //
      //            let model = Mapper<T>().map(JSON: item)
      //            completion(.success(model: model!))
      //          } else {
      //            print(error?.localizedDescription ?? "Não conseguimos receber os dados da API...")
      //          }
      //        }
    }
    task.resume()
  }
}

