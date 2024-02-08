//
//  SecessionService.swift
//  Union
//
//  Created by JehyeongPark on 2/8/24.
//

import Foundation
import UIKit

class SecessionService {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func secession(url: URL, param: Data, completion: @escaping(secessionResponse) -> ()) {
        
        let url = url
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = param

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(appDelegate.userToken, forHTTPHeaderField: "X-AUTH-TOKEN")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(secessionResponse.self, from: data!)
                
                completion(decoded)

            } catch let e as NSError {
                print(String(describing: e))
            }
        }.resume()
    }
}
