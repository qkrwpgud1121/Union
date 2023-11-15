//
//  PwdChangeService.swift
//  Union
//
//  Created by JehyeongPark on 11/14/23.
//

import Foundation
import Alamofire

class PwdChangeService {
    
    func setPassword(with model: pwdChangeRequest,url: URL, param: Data, completion: @escaping(pwdChangeResponse) -> ()) {
        
        let url = url
        
        let parameters = [
            "email" : model.email,
            "password" : model.password,
            "newPassword" : model.newPassword
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in

            switch response.result{
            case .success :
                if let jsonData = response.data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let decoded = try jsonDecoder.decode(pwdChangeResponse.self, from: jsonData)
                        completion(decoded)
                    }catch let error{
                        print(error.localizedDescription)
                    }
                }
            case .failure:
                print("error")
            }
        }
    }
}
