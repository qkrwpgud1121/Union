//
//  Temp.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/15.
//

import UIKit

class Temp: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboar()
    }

    @IBAction func temp(_ sender: UIButton) {
        
        let email = email.text!
        let param = ["email" : email]
        let paramData = try! JSONSerialization.data(withJSONObject: param)
        
        print(param)
        
        let url = URL(string: "http://localhost:8080/union/api/user/issue/temporary-password")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let tempTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                do{
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    guard let jsonObject = object else {return}
                    
                    let tempResultCode = jsonObject["resultCode"] as? String
                    let tempResultMessage = jsonObject["resultMessage"] as? String
                    let responseData = jsonObject["responseData"] as? [String : Any]
                    
                    let tempPwd = responseData!["password"] as? String
                    
                    if tempResultMessage == "SUCCESS" {
                        self.tempAlert(message: tempPwd!)
                    } else {
                        self.tempAlert(message: tempResultMessage!)
                    }
                    
                } catch let e as NSError {
                    print("An error has occured while parsing JSONObject: \(e.localizedDescription)")
                }
            }
        }
        tempTask.resume()
    }
    
    func tempAlert(message: String) {
        
        var message: String = message
        
        let alert = UIAlertController(title: "임시 비밀번호", message: message, preferredStyle: .alert)
        let sucess = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(sucess)
        self.present(alert, animated: true)
    }
}
