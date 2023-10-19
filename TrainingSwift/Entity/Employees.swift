//
//  Employees.swift
//  TrainingSwift
//
//  Created by ITBCA on 18/10/23.
//

import Foundation
import Alamofire

struct Wrapper: Decodable {
    let data: [dataForm]
}

struct dataForm: Decodable {
    let id: Int
    let employee_name: String
    let employee_salary: Int
    let employee_age: Int
    let profile_image: String

    enum UserCodingKeys: String, CodingKey {
        case id = "id"
        case employee_name = "employee_name"
        case employee_salary = "employee_salary"
        case employee_age = "employee_age"
        case profile_image = "profile_image"

    }
}

class APIFetchHandler {
    static let sharedInstance = APIFetchHandler()
    
    var fourthViewController: FourthViewController?
    
    func fetchAPIData(handler: @escaping (_ apiData: Wrapper) -> (Void) ) {
      let url = "https://dummy.restapiexample.com/api/v1/employees";
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
            guard let data = resp.data else { return }
            do {
                let jsonData = try JSONDecoder().decode(Wrapper.self, from: data)
                handler(jsonData)
                self.fourthViewController?.success(apiResult: jsonData)
                
            } catch let jsonErr {
                print("JSON ERR : ", jsonErr);
            }
            debugPrint(resp)
        }
   }
}
