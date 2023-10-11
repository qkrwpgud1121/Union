//
//  ViewController.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/11.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btn_login(_ sender: Any) {
        
        let Email = email.text!
        let pwd = password.text!
        let param = ["email" : Email, "password" : pwd]
        let paramData = try! JSONSerialization.data(withJSONObject: param)

        let url = URL(string: "http://localhost:8080/union/api/user/login")

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                return
            }

            DispatchQueue.main.async {
                do{
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    guard let jsonObject = object else {return}
                    
                    print(jsonObject)
                    
                    let resultMessage = jsonObject["resultMessage"] as? String
                    let resultCode = jsonObject["resultCode"] as? String
                    let token = jsonObject["token"] as? String
                    
                    if resultMessage == "SUCCESS" {
                        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        let mainView = storyboard.instantiateViewController(identifier: "MainList")
                        mainView.modalPresentationStyle = .fullScreen
                        self.navigationController?.show(mainView, sender: nil)
                    }
                } catch let e as NSError {
                    print("An error has occured while parsing JSONObject: \(e.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
    
}

