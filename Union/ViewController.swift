//
//  ViewController.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/11.

import UIKit

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    private var rememberMeFlag = false
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btnSession: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    private var eyeButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.layer.borderColor = CGColor(red: 211/255, green: 72/255, blue: 89/255, alpha: 1)
        email.layer.borderWidth = 1
        email.layer.cornerRadius = 15
        email.addLeftPadding()
        
        password.layer.borderColor = CGColor(red: 211/255, green: 72/255, blue: 89/255, alpha: 1)
        password.layer.borderWidth = 1
        password.layer.cornerRadius = 15
        password.addLeftPadding()
        
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
            
            let email = email.text!
            let pwd = password.text!
            
            let encoder = JSONEncoder()
            let requestData = loginRequest(email: email, password: pwd)
            
            let param = try? encoder.encode(requestData)
            
            let url = URL(string: "http://localhost:8080/union/api/user/login")
            
            LoginService().getLog(url: url!, param: param!) { //1
                (decoded) in
                
                let resultMessage = decoded.resultMessage
                
                DispatchQueue.main.async {
                    if resultMessage == "SUCCESS" {
                        
                        do {
                            
                            let responseData = decoded.responseData
                            
                            self.appDelegate?.userToken = responseData.token ?? ""
                            self.appDelegate?.userEmail = responseData.email
                            self.appDelegate?.userName = responseData.name ?? ""
                            
                            if responseData.profileImagePath != nil {
                                self.appDelegate?.userProfile = responseData.profileImagePath!
                            } else {
                                self.appDelegate?.userProfile = ""
                            }
                            
                            UserDefaults.standard.set(email, forKey: "USER_EMAIL")
                            UserDefaults.standard.set(pwd, forKey: "USER_PASSWORD")
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                            let mainView = storyboard.instantiateViewController(identifier: "MainList")
                            mainView.modalPresentationStyle = .fullScreen
                            self.navigationController?.show(mainView, sender: nil)
                        }
                        
                    } else {
                        self.loginAlert(message: resultMessage)
                    }
                }
            }
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

