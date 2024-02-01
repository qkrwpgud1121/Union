//
//  PasswordChange.swift
//  Union
//
//  Created by JehyeongPark on 11/14/23.
//

import UIKit

class PasswordChange: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var currentPwd: UITextField!
    @IBOutlet weak var changePwd: UITextField!
    @IBOutlet weak var changePwdChk: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func changePwd(_ sender: Any) {
        
        if currentPwd.text!.isEmpty || changePwd.text!.isEmpty || changePwdChk.text!.isEmpty {
            pwdChangeAlert(type: false, message: "비밀번호를 입력해주세요.")
        } else {
            if changePwd.text != changePwdChk.text {
                pwdChangeAlert(type: false, message: "변경할 비밀번호를 확인해 주세요.")
            } else {
                if currentPwd.text == changePwd.text {
                    pwdChangeAlert(type: false, message: "현재 비밀번호와 변경할 비밀번호가 같습니다.")
                } else {
                    let encoder = JSONEncoder()
                    let requestData = pwdChangeRequest(email: appDelegate!.userEmail, password: currentPwd.text!, newPassword: changePwd.text!)
                    let param = try? encoder.encode(requestData)
                    
                    let requestURL = "http://43.201.53.148:8080/union/api/user/change/password"
                    
                    let url = URL(string: requestURL)
                    
                    PwdChangeService().setPassword(with: requestData, url: url!, param: param!) {
                        (decoded) in
                        
                        let resultMessage = decoded.resultMessage

                        DispatchQueue.main.async {
                            if resultMessage == "SUCCESS" {
                                self.pwdChangeAlert(type: true, message: "비밀번호 변경 완료.\n로그인 화면으로 돌아갑니다.")
                            } else {
                                self.pwdChangeAlert(type: false, message: resultMessage)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func pwdChangeAlert(type: Bool, message: String) {
        
        let message: String = message
        
        let alert = UIAlertController(title: "비밀번호 변경", message: message, preferredStyle: .alert)
        
        let success = UIAlertAction(title: "성공", style: .default) {_ in
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let mainView = storyboard.instantiateViewController(identifier: "ViewController")
            mainView.modalPresentationStyle = .fullScreen
            self.navigationController?.show(mainView, sender: nil)
        }
        
        let failed = UIAlertAction(title: "실패", style: .default)
        
        if type {
            alert.addAction(success)
        } else {
            alert.addAction(failed)
        }
        
        self.present(alert, animated: true)
    }

}
