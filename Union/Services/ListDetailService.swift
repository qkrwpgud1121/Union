//
//  ListDetailService.swift
//  Union
//
//  Created by JehyeongPark on 10/24/23.
//

import Foundation
import UIKit

class ListDetailService {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func setListDetail(url: URL, param: Data, completion: @escaping(MyPostResponse) -> ()) {
        
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
                let decoded = try decoder.decode(MyPostResponse.self, from: data!)
                
                completion(decoded)

            } catch let e as NSError {
                print(String(describing: e))
            }
        }.resume()
    }
}
