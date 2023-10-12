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
        email.layer.borderColor = CGColor(red: 211/255, green: 72/255, blue: 89/255, alpha: 1)
        email.layer.borderWidth = 1
        email.layer.cornerRadius = 15
        
        password.layer.borderColor = CGColor(red: 211/255, green: 72/255, blue: 89/255, alpha: 1)
        password.layer.borderWidth = 1
        password.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
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
                    
                    let resultMessage = jsonObject["resultMessage"] as? String
                    let responseData = jsonObject["responseData"] as? [String : Any]
                    
                    let token = responseData!["token"] as? String
                    
                    if resultMessage == "SUCCESS" {
                        
                        let appDelegate = UIApplication.shared.delegate as? AppDelegate

                        appDelegate?.userEmail = Email
                        appDelegate?.userToken = token!
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        let mainView = storyboard.instantiateViewController(identifier: "MainList")
                        mainView.modalPresentationStyle = .fullScreen
                        self.navigationController?.show(mainView, sender: nil)
                    } else {
                        self.loginAlert(message: resultMessage!)
                    }
                } catch let e as NSError {
                    print("An error has occured while parsing JSONObject: \(e.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    func loginAlert(message: String) {
        
        let message: String = message
        
        let alert = UIAlertController(title: "로그인", message: message, preferredStyle: .alert)
        let sucess = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(sucess)
        self.present(alert, animated: true)
    }
    
}

