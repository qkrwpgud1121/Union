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

        // Do any additional setup after loading the view.
    }

    @IBAction func temp(_ sender: UIButton) {
        
        let email = email.text!
        let param = ["email" : email]
        let paramData = try! JSONSerialization.data(withJSONObject: param)
        
        print(param)
        
        let url = URL(string: "http://211.204.106.46/union/api/user/issue/temporary-password")
        
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
                    let Pwd = jsonObject["password"] as? String
                    
                    if tempResultMessage == "SUCCESS" {
                        NSLog("result", jsonObject)
                    }
                    
                } catch let e as NSError {
                    print("An error has occured while parsing JSONObject: \(e.localizedDescription)")
                }
            }
        }
        
    }
}
