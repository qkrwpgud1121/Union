//
//  Register.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/15.
//

import UIKit

class Register: UIViewController {

    @IBOutlet weak var chkPwd: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboar()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        
        let userName = userName.text
        let email = email.text
        let pwd = pwd.text
        let chkPwd = chkPwd.text
        
        let param = ["email" : email, "password" : pwd, "name" : userName]
        let paramData = try! JSONSerialization.data(withJSONObject: param)
        
        print(param)
        
        let url = URL(string: "http://211.204.106.46/union/api/user/register")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                do{
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    guard let jsonObject = object else {return}
                    
                    let resultCode = jsonObject["resultCode"] as? String
                    let resultMessage = jsonObject["resultMessage"] as? String
                    let token = jsonObject["token"] as? String
                    
                    if resultMessage == "SUCCESS" {
                        NSLog("result", jsonObject)
                    }
                    
                } catch let e as NSError {
                    print("An error has occured while parsing JSONObject: \(e.localizedDescription)")
                }
            }
        }
    }
}
