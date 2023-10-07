//
//  MyProfile.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/23.
//

import UIKit

class MyProfile: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var nickName: UITextField!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var imgSetting: UIButton!
    @IBOutlet weak var position: UIButton!
    @IBOutlet weak var career: UIButton!
    @IBOutlet weak var addLink: UIButton!
    @IBOutlet weak var potLabel: UILabel!
    
    var linkArrayTag: [Int] = []
    var linkArray: [String] = []
    
    var addLinkBtnTran: CGFloat = 0.0
    
    var count: Int = 0
    
    let imgPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgPicker.delegate = self
        
        imgView.layer.cornerRadius = imgView.frame.width / 2
        imgView.layer.borderWidth = 2
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.clipsToBounds = true 

        imgSetting.layer.cornerRadius = imgSetting.frame.width / 2
        imgSetting.layer.borderWidth = 2
        imgSetting.layer.borderColor = UIColor.white.cgColor
        
        self.hideKeyboar()
        self.setKeyboardObserver()
        
        setPosition()

        setCareer()
    
    }
    
    @IBAction func addBtnClick(_ sender: UIButton) {
        
        let alert =  UIAlertController(title: "Title", message: "message", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "앨범에서 가져오기", style: .default) { (action) in self.openLibrary() }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in self.openCamera() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func openLibrary(){
        imgPicker.sourceType = .photoLibrary
        present(imgPicker, animated: false, completion: nil)
    }
    
    func openCamera(){
        imgPicker.sourceType = .camera
        present(imgPicker, animated: false, completion: nil)
    }
    
    func setPosition() {
        
        let all = UIAction(title: "전체", handler: {_ in print("all")})
        let frontend = UIAction(title: "프런트엔드", handler: {_ in print("all")})
        let backend = UIAction(title: "백엔드", handler: {_ in print("all")})
        let designer = UIAction(title: "디자이너", handler: {_ in print("all")})
        let iOS = UIAction(title: "iOS", handler: {_ in print("all")})
        let AOS = UIAction(title: "안드로이드", handler: {_ in print("all")})
        let devops = UIAction(title: "DevOps", handler: {_ in print("all")})
        let PM = UIAction(title: "PM", handler: {_ in print("all")})
        let planner = UIAction(title: "기획자", handler: {_ in print("all")})
        
        let buttonMenu = UIMenu(title: "희망 분야", children: [all, frontend, backend, designer, iOS, AOS, devops, PM, planner])

        position.menu = buttonMenu
        position.changesSelectionAsPrimaryAction = true
    }
    
    func setCareer() {
        
        let none = UIAction(title: "없음", state: .on , handler: {_ in print("project")})
        let oneYear = UIAction(title: "1년", state: .on , handler: {_ in print("project")})
        let twoYear = UIAction(title: "2년", state: .on , handler: {_ in print("project")})
        let threeYear = UIAction(title: "3년", state: .on , handler: {_ in print("project")})
        let fourYear = UIAction(title: "4년", state: .on , handler: {_ in print("project")})
        let fiveYear = UIAction(title: "5년", state: .on , handler: {_ in print("project")})
        let sixYear = UIAction(title: "6년", state: .on , handler: {_ in print("project")})
        let sevenYear = UIAction(title: "7년", state: .on , handler: {_ in print("project")})
        let eightYear = UIAction(title: "8년", state: .on , handler: {_ in print("project")})
        let nineYear = UIAction(title: "9년", state: .on , handler: {_ in print("project")})
        let tenYear = UIAction(title: "10년", state: .on , handler: {_ in print("project")})

        let buttonMenu = UIMenu(title: "경력", children: [none, oneYear, twoYear, threeYear, fourYear, fiveYear, sixYear, sevenYear, eightYear, nineYear, tenYear])

        career.menu = buttonMenu
        career.changesSelectionAsPrimaryAction = true
    }
    
    @IBAction func addLink(_ sender: UIButton) {
        
        count += 1
        addTextfield()
    }
    
    func addTextfield() {
        
        for tempView in scrollView.subviews {
            if tempView.tag != 0 {
                tempView.removeFromSuperview()
            }
        }
        
        let xPos: CGFloat = 16.0
        var yPos: CGFloat = potLabel.frame.origin.y + 22.0 + 5.0
        var tag: Int = 1
        
        self.addLinkBtnTran = 0.0
        
        if count != 0 {
            
            for i in 1...count {
                
                let width = UIScreen.main.bounds.size.width - 32.0
                
                let stackView = UIStackView(frame: CGRect(x: xPos, y: yPos, width: width, height: 34))
                
                stackView.tag = tag
                
                let textField = UITextField(frame: CGRect(x: xPos, y: yPos, width: width - 36.0, height: 34))
                textField.layer.borderWidth = 0.5
                textField.layer.borderColor = UIColor.lightGray.cgColor
                textField.layer.cornerRadius = 5
                
                let button = UIButton(frame: CGRect(x: width+20.0, y: yPos, width: 34, height: 34))
                button.setImage(UIImage(systemName: "trash"), for: .normal)
                button.addTarget(self, action: #selector(removeLink(_:)), for: .touchUpInside)
                button.tag = tag
                
                stackView.addArrangedSubview(textField)
                stackView.addArrangedSubview(button)
                
                addLinkBtnTran = addLinkBtnTran + 34.0 + 5.0
                
                yPos = yPos + 34.0 + 5.0
                UIView.animate(withDuration: 0.5, animations: {
                    self.addLink.transform = CGAffineTransform(translationX: 0 , y: self.addLinkBtnTran)
                    self.scrollView.addSubview(stackView)
                })
                tag = tag + 1
            }
        }
        
    }
    
    @objc func removeLink(_ sender: AnyObject) {
        
        addLinkBtnTran = addLinkBtnTran - 34.0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.addLink.transform = CGAffineTransform(translationX: 0 , y: self.addLinkBtnTran)
        })
        
        count -= 1
        
        addTextfield()
    }
    
    @IBAction func profileSave(_ sender: UIBarButtonItem) {
        
    }
}

extension MyProfile : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            imgView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
}
