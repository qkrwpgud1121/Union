//
//  LoginService.swift
//  Union
//
//  Created by JehyeongPark on 10/26/23.
//

import Foundation

class LoginService {
    
    func getLog(url: URL, param: Data, completion: @escaping(loginResponse) -> ()) {
        
        let url = url
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = param

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(loginResponse.self, from: data!)
                
                completion(decoded)

            } catch let e as NSError {
                print(String(describing: e))
            }
        }.resume()
    }
}
