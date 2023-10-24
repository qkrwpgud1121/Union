//
//  ViewController.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/11.

import UIKit

class ViewController: UIViewController {
    
    private var rememberMeFlag = false
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btnSession: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    private var eyeButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        email.layer.borderColor = CGColor(red: 211/255, green: 72/255, blue: 89/255, alpha: 1)
        email.layer.borderWidth = 1
        email.layer.cornerRadius = 15
        
        password.layer.borderColor = CGColor(red: 211/255, green: 72/255, blue: 89/255, alpha: 1)
        password.layer.borderWidth = 1
        password.layer.cornerRadius = 15
        
        btnLogin.layer.cornerRadius = 18
        
        rememberMeFlag = UserDefaults.standard.bool(forKey: "REMEMBER_USER")
        
        if rememberMeFlag {
            email.text = UserDefaults.standard.string(forKey: "USER_EMAIL")
            password.text = UserDefaults.standard.string(forKey: "USER_PASSWORD")
            btnSession.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
        
        setPasswordShownButtonImage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func session(_ sender: UIButton) {
        
        rememberMeFlag = !rememberMeFlag
        
        if rememberMeFlag {
            btnSession.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            UserDefaults.standard.set(rememberMeFlag, forKey: "REMEMBER_USER")
        } else {
            btnSession.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            UserDefaults.standard.removeObject(forKey: "REMEMBER_USER")
            rememberMeFlag = false
        }
    }
    
    @IBAction func btn_login(_ sender: Any) {
    
        if email.text!.isEmpty || password.text!.isEmpty {
            
            self.loginAlert(message: "이메일, 비밀번호를 입력해주세요.")
            
        } else {
            
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
                        let name = responseData!["name"] as? String
                        
                        if resultMessage == "SUCCESS" {
                            
                            let appDelegate = UIApplication.shared.delegate as? AppDelegate
                            
                            appDelegate?.userEmail = Email
                            appDelegate?.userToken = token!
                            appDelegate?.userName = name!
                            
                            UserDefaults.standard.set(Email, forKey: "USER_EMAIL")
                            UserDefaults.standard.set(pwd, forKey: "USER_PASSWORD")
                            
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
    }
    
    func loginAlert(message: String) {
        
        let message: String = message
        
        let alert = UIAlertController(title: "로그인", message: message, preferredStyle: .alert)
        let sucess = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(sucess)
        self.present(alert, animated: true)
    }
    
    func setPasswordShownButtonImage() {
        eyeButton = UIButton.init(primaryAction: UIAction(handler: { [self]_ in
            password.isSecureTextEntry.toggle()
            self.eyeButton.isSelected.toggle()
        }))
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10.0)
        
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.imagePadding = 10
        buttonConfiguration.baseBackgroundColor = .clear
        buttonConfiguration.preferredSymbolConfigurationForImage = imageConfig
        
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        self.eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        self.eyeButton.configuration = buttonConfiguration
        
        self.password.rightView = eyeButton
        self.password.rightViewMode = .always
    }
    
}

