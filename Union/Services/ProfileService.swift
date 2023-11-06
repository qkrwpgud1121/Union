//
//  ProfileService.swift
//  Union
//
//  Created by JehyeongPark on 10/27/23.
//

import Foundation
import Alamofire
import UIKit

class ProfileService {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getProfile(url: URL, param: Data, completion: @escaping(profileResponse) -> ()) {
        
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
                
                let decoded = try decoder.decode(profileResponse.self, from: data!)
                completion(decoded)
                
            } catch let e as NSError {
                print(String(describing: e))
            }
        }.resume()
    }
    
    func setProfile(with model: saveProfileRequest, url: URL, param: Data, image: UIImage, imageName: String, completion: @escaping(saveProfileResponse) -> ()) {
        
        let url = url
        
        let header: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "X-AUTH-TOKEN" : appDelegate.userToken
        ]
        let parameters = [
            "email" : model.email,
            "name" : model.name,
            "hopeJob" : model.hopeJob,
            "career" : model.career,
            "introduction" : model.introduction,
            "portfolioLink" : model.portfolioLink,
            
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            
            let image1: Data = image.jpegData(compressionQuality: 1.0)!
            multipartFormData.append(image1, withName: "file", fileName: imageName, mimeType: "image/jpeg")
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
            }
            
        }, to: url, method: .post, headers: header).responseJSON { (response) in
            
            switch response.result{
            case .success :
                if let jsonData = response.data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let decoded = try jsonDecoder.decode(saveProfileResponse.self, from: jsonData)
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
