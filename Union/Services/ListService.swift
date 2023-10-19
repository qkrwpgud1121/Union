//
//  ListService.swift
//  Union
//
//  Created by JehyeongPark on 10/16/23.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as? AppDelegate
let userToken = appDelegate!.userToken

var listArray : [String] = []

class ListService {
    
    func getMainList(url: URL, completion: @escaping([DetailList]?) -> ()) {
        
        let param = ["requestData" : ["unionBoardSubject" : ""], "paging" : ["number" : 0, "size" : 20]]
        let paramData = try! JSONSerialization.data(withJSONObject: param)

        let url = url
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = paramData

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(userToken, forHTTPHeaderField: "X-AUTH-TOKEN")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil) // if any error occurs, article can be nil
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(ListMain.self, from: data!)
                
                let listArray = decoded.responseData.list
                
                completion(listArray)

            } catch let e as NSError {
                print(String(describing: e))
            }
//            else if let data = data {
//                
//                let listMain = try? JSONDecoder().decode(ListMain.self, from: data)
//                print(listMain?.responseData)
//                if let listMain = listMain {
//                    //completion(listMain.responseList)
//                }
//                //print("1 \(listMain?.responseList)")
//            }
        }.resume()
    }
}
