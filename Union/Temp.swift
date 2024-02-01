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
        
        if email.text!.isEmpty {
            self.tempAlert(type: true, message: "이메일을 입력해주세요.")
        } else {
            
            let email = email.text!
            let param = ["email" : email]
            let paramData = try! JSONSerialization.data(withJSONObject: param)
            
            print(param)
            
            let url = URL(string: "http://43.201.53.148:8080/union/api/user/issue/temporary-password")
            
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
                        
                        let tempResultMessage = jsonObject["resultMessage"] as? String
                        let responseData = jsonObject["responseData"] as? [String : Any]
                        
                        let tempPwd = responseData!["password"] as? String
                        
                        if tempResultMessage == "SUCCESS" {
                            self.tempAlert(type: true, message: tempPwd!)
                        } else {
                            self.tempAlert(type: false, message: tempResultMessage!)
                        }
                        
                    } catch let e as NSError {
                        print("An error has occured while parsing JSONObject: \(e.localizedDescription)")
                    }
                }
            }
            tempTask.resume()
        }
    }
    
    func tempAlert(type:Bool ,message: String) {
        
        let message: String = message
        
        let alert = UIAlertController(title: "임시 비밀번호", message: message, preferredStyle: .alert)
        
        let sucess = UIAlertAction(title: "확인", style: .default, handler: nil)
        let copy = UIAlertAction(title: "복사", style: .default) {_ in
            
            UIPasteboard.general.string = message
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let mainView = storyboard.instantiateViewController(identifier: "ViewController")
            mainView.modalPresentationStyle = .fullScreen
            self.navigationController?.show(mainView, sender: nil)
        }
        
        if type {
            alert.addAction(copy)
        } else {
            alert.addAction(sucess)
            
        }
        self.present(alert, animated: true)
    }
}
