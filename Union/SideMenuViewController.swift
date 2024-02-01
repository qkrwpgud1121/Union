//
//  SideMenuViewController.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/21.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet var profile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profile.layer.cornerRadius = profile.frame.width / 2
        profile.layer.borderWidth = 2
        profile.layer.borderColor = UIColor.gray.cgColor
        profile.clipsToBounds = true
        profile.imgLoad(url: appDelegate?.userProfile ?? "")
        
        userName.text = appDelegate?.userName
        
    }

    @IBAction func logOut(_ sender: UIButton) {
        
        let email = appDelegate?.userEmail
        let token = appDelegate?.userToken
        
        let alert = UIAlertController(title: "로그 아웃", message: "로그 아웃 하시겠습니까?", preferredStyle: .alert)
        let sucess = UIAlertAction(title: "확인", style: .default) { _ in
            
            self.logOut(email: email!, token: token!)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(sucess)
        alert.addAction(cancel)
        self.present(alert, animated: true)
        
    }
        
    func logOut(email: String, token: String) {
        
        let param = ["email" : email]
        let paramData = try! JSONSerialization.data(withJSONObject: param)
            
        let url = URL(string: "http://43.201.53.148:8080/union/api/user/logout")
            
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
            
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "X-AUTH-TOKEN")
            
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
            
                    DispatchQueue.main.async {
                        if resultMessage == "SUCCESS" {
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                            let mainView = storyboard.instantiateViewController(identifier: "ViewController")
                            mainView.modalPresentationStyle = .fullScreen
                            self.navigationController?.show(mainView, sender: nil)
                        }
                    }
            
                } catch let e as NSError {
                            print("An error has occured while parsing JSONObject: \(e.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
