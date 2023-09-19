//
//  MyProfile.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/23.
//

import UIKit

class MyProfile: UIViewController {
    
    @IBOutlet var nickName: UITextField!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var imgSetting: UIButton!
    @IBOutlet weak var position: UIButton!
    @IBOutlet weak var career: UIButton!
    @IBOutlet weak var addLink: UIButton!
    @IBOutlet weak var potLabel: UILabel!
    @IBOutlet weak var test: UIButton!
    
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
        let frontend = UIAction(title: "프런드엔드", handler: {_ in print("all")})
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
    
    
    //var yPos: CGFloat = potLabel.frame.origin.y + 21.0 + 8.0
    
    var yPos: CGFloat = 739.0
    
    @IBAction func addLink(_ sender: UIButton) {
        
        print(potLabel.frame.origin.y + 21.0 + 8.0)
        
        let width = UIScreen.main.bounds.size.width - 32
        
        var xPos: CGFloat = 16.0
        //var yPos: CGFloat = potLabel.frame.origin.y + 21.0 + 8.0
        
        let textField = UITextField(frame: CGRect(x: xPos, y: yPos, width: width, height: 34))
        
        textField.text = "test"
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 5
        
        UIView.animate(withDuration: 0.5, animations: {
            self.addLink.transform = CGAffineTransform(translationX: 0 , y: 34)
            self.view.addSubview(textField)
        })
        
        yPos = yPos + 34.0 + 5.0
        
    }
    @IBAction func test(_ sender: UIButton) {
        print("click")
        self.test.transform = CGAffineTransform(translationX: 0 , y: 34)
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
