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
        
        if pwd == chkPwd {
            let param = ["email" : email, "password" : pwd, "name" : userName]
            let paramData = try! JSONSerialization.data(withJSONObject: param)
            
            let url = URL(string: "http://localhost:8080/union/api/user/register")
            
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
                        
                        let resultMessage = jsonObject["resultMessage"] as? String
                        
                        if resultMessage == "SUCCESS" {
                            self.registerAlert(type: true, message: resultMessage!)
                        }
                        
                    } catch let e as NSError {
                        print("An error has occured while parsing JSONObject: \(e.localizedDescription)")
                    }
                }
            }
            task.resume()
        } else {
            self.registerAlert(type: false,message: "비밀번호를 확인해 주세요.")
        }
        
    }
    
    func registerAlert(type: Bool, message: String) {
        
        let message: String = message
        
        let alert = UIAlertController(title: "회원 가입", message: message, preferredStyle: .alert)
        
        let sucess = UIAlertAction(title: "확인", style: .default) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let mainView = storyboard.instantiateViewController(identifier: "ViewController")
            mainView.modalPresentationStyle = .fullScreen
            self.navigationController?.show(mainView, sender: nil)
        }
        
        let failed = UIAlertAction(title: "확인", style: .default)
        
        if type {
            alert.addAction(sucess)
        } else {
            alert.addAction(failed)
        }
        
        self.present(alert, animated: true)
        
        
    }
}
