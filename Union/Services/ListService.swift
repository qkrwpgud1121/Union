//
//  ListService.swift
//  Union
//
//  Created by JehyeongPark on 10/16/23.
//

import Foundation
import UIKit

var listArray : [DetailList] = []

class ListService {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func getMainList(url: URL, param: Data, pagingNum: Int, completion: @escaping([DetailList]?) -> ()) {
        
        let url = url
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = param
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(appDelegate!.userToken, forHTTPHeaderField: "X-AUTH-TOKEN")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(ListMain.self, from: data!)
                
                if decoded.responseData.list!.isEmpty {
                    completion(nil)
                }

                if pagingNum == 0 {
                    listArray = decoded.responseData.list!
                } else {
                    listArray.append(contentsOf: decoded.responseData.list!)
                }
                
                completion(listArray)
                
            } catch let e as NSError {
                print(String(describing: e))
            }
        }.resume()
    }
}
