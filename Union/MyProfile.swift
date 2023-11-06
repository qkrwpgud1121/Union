//
//  MyProfile.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/23.
//

import UIKit
import Photos

class MyProfile: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var nickName: UITextField!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var imgSetting: UIButton!
    @IBOutlet weak var position: UIButton!
    @IBOutlet weak var career: UIButton!
    @IBOutlet weak var addLink: UIButton!
    @IBOutlet weak var potLabel: UILabel!
    @IBOutlet weak var introduction: UITextView!
    @IBOutlet weak var mainName: UILabel!
    
    var userHopeJob: String = ""
    var userCareer: String = ""
    var responseLink: String = ""
    var saveImageName: String = ""
    var saveImagePath: String = ""
    
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
        
        profileSetup()
        
    }
    
    func profileSetup() {
        
        let email = appDelegate?.userEmail
        
        let encoder = JSONEncoder()
        let param = ProfileRequest(email: email!)
        
        let paramData = try? encoder.encode(param)
        
        let url = URL(string: "http://localhost:8080/union/api/user/profile/getDetail")!
        
        ProfileService().getProfile(url: url, param: paramData!) { //1
            (decoded) in
            
            let responseData = decoded.responseData
            
            DispatchQueue.main.async {
                do {
                    self.nickName.text = responseData.name
                    self.mainName.text = responseData.name
                    self.introduction.text = responseData.introduction
                    self.userCareer = responseData.career ?? ""
                    self.userHopeJob = responseData.hopeJob ?? ""
                    self.responseLink = responseData.portfolioLink ?? ""
                    let links = self.responseLink.split(separator: ", ")
                    
                    if self.appDelegate?.userProfile != "" {
                        
                        self.saveImagePath = responseData.profileImagePath!
                        self.appDelegate?.userProfile = self.saveImagePath
                        let imgPath = self.appDelegate?.userProfile
                        self.imgView.imgLoad(url: imgPath ?? "")
                    }
                    
                    for link in links {
                        self.count += 1
                        self.linkArray.append(String(link))
                        self.addTextfield()
                    }
                } catch {
                    print(error)
                }
                
                self.setPosition()
                self.setCareer()
            }
        }
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
        
        let all = UIAction(title: "전체", handler: {_ in self.userHopeJob = "전체"})
        let frontend = UIAction(title: "프런트엔드", handler: {_ in self.userHopeJob = "프런트엔드"})
        let backend = UIAction(title: "백엔드", handler: {_ in self.userHopeJob = "백엔드"})
        let designer = UIAction(title: "디자이너", handler: {_ in self.userHopeJob = "디자이너"})
        let iOS = UIAction(title: "iOS", handler: {_ in self.userHopeJob = "iOS"})
        let AOS = UIAction(title: "AOS", handler: {_ in self.userHopeJob = "AOS"})
        let devops = UIAction(title: "DevOps", handler: {_ in self.userHopeJob = "DevOps"})
        let PM = UIAction(title: "PM", handler: {_ in self.userHopeJob = "PM"})
        let planner = UIAction(title: "기획자", handler: {_ in self.userHopeJob = "기획자"})
        
        switch userHopeJob {
        case "프런트엔드":
            let buttonMenu = UIMenu(title: "희망 분야", children: [frontend, all, backend, designer, iOS, AOS, devops, PM, planner])

            position.menu = buttonMenu
            position.changesSelectionAsPrimaryAction = true
        case "백엔드":
            let buttonMenu = UIMenu(title: "희망 분야", children: [backend, all, frontend, designer, iOS, AOS, devops, PM, planner])

            position.menu = buttonMenu
            position.changesSelectionAsPrimaryAction = true
        case "디자이너":
            let buttonMenu = UIMenu(title: "희망 분야", children: [designer, all, frontend, backend, iOS, AOS, devops, PM, planner])

            position.menu = buttonMenu
            position.changesSelectionAsPrimaryAction = true
        case "iOS":
            let buttonMenu = UIMenu(title: "희망 분야", children: [iOS, all, frontend, backend, designer, AOS, devops, PM, planner])
            
            position.menu = buttonMenu
            position.changesSelectionAsPrimaryAction = true
        case "AOS":
            let buttonMenu = UIMenu(title: "희망 분야", children: [AOS, all, frontend, backend, designer, iOS, devops, PM, planner])

            position.menu = buttonMenu
            position.changesSelectionAsPrimaryAction = true
        case "DevOps":
            let buttonMenu = UIMenu(title: "희망 분야", children: [devops, all, frontend, backend, designer, iOS, AOS, PM, planner])

            position.menu = buttonMenu
            position.changesSelectionAsPrimaryAction = true
        case "PM":
            let buttonMenu = UIMenu(title: "희망 분야", children: [PM, all, frontend, backend, designer, iOS, AOS, devops, planner])

            position.menu = buttonMenu
            position.changesSelectionAsPrimaryAction = true
        case "기획자":
            let buttonMenu = UIMenu(title: "희망 분야", children: [planner, all, frontend, backend, designer, iOS, AOS, devops, PM])

            position.menu = buttonMenu
            position.changesSelectionAsPrimaryAction = true
        default:
            let buttonMenu = UIMenu(title: "희망 분야", children: [all, frontend, backend, designer, iOS, AOS, devops, PM, planner])

            position.menu = buttonMenu
            position.changesSelectionAsPrimaryAction = true
        }
        
        
    }
    
    func setCareer() {
        
        let none = UIAction(title: "없음", state: .on , handler: {_ in self.userCareer = "없음"})
        let oneYear = UIAction(title: "1년", state: .on , handler: {_ in self.userCareer = "1년"})
        let twoYear = UIAction(title: "2년", state: .on , handler: {_ in self.userCareer = "2년"})
        let threeYear = UIAction(title: "3년", state: .on , handler: {_ in self.userCareer = "3년"})
        let fourYear = UIAction(title: "4년", state: .on , handler: {_ in self.userCareer = "4년"})
        let fiveYear = UIAction(title: "5년", state: .on , handler: {_ in self.userCareer = "5년"})
        let sixYear = UIAction(title: "6년", state: .on , handler: {_ in self.userCareer = "6년"})
        let sevenYear = UIAction(title: "7년", state: .on , handler: {_ in self.userCareer = "7년"})
        let eightYear = UIAction(title: "8년", state: .on , handler: {_ in self.userCareer = "8년"})
        let nineYear = UIAction(title: "9년", state: .on , handler: {_ in self.userCareer = "9년"})
        let tenYear = UIAction(title: "10년", state: .on , handler: {_ in self.userCareer = "10년"})
        
        switch userCareer {
        case "1년":
            let buttonMenu = UIMenu(title: "경력", children: [oneYear, none, twoYear, threeYear, fourYear, fiveYear, sixYear, sevenYear, eightYear, nineYear, tenYear])

            career.menu = buttonMenu
            career.changesSelectionAsPrimaryAction = true
        case "2년":
            let buttonMenu = UIMenu(title: "경력", children: [twoYear, none, oneYear, threeYear, fourYear, fiveYear, sixYear, sevenYear, eightYear, nineYear, tenYear])

            career.menu = buttonMenu
            career.changesSelectionAsPrimaryAction = true
        case "3년":
            let buttonMenu = UIMenu(title: "경력", children: [threeYear, none, oneYear, twoYear, fourYear, fiveYear, sixYear, sevenYear, eightYear, nineYear, tenYear])

            career.menu = buttonMenu
            career.changesSelectionAsPrimaryAction = true
        case "4년":
            let buttonMenu = UIMenu(title: "경력", children: [fourYear, none, oneYear, twoYear, threeYear, fiveYear, sixYear, sevenYear, eightYear, nineYear, tenYear])

            career.menu = buttonMenu
            career.changesSelectionAsPrimaryAction = true
        case "5년":
            let buttonMenu = UIMenu(title: "경력", children: [fiveYear, none, oneYear, twoYear, threeYear, fourYear, sixYear, sevenYear, eightYear, nineYear, tenYear])

            career.menu = buttonMenu
            career.changesSelectionAsPrimaryAction = true
        case "6년":
            let buttonMenu = UIMenu(title: "경력", children: [sixYear, none, oneYear, twoYear, threeYear, fourYear, fiveYear, sevenYear, eightYear, nineYear, tenYear])

            career.menu = buttonMenu
            career.changesSelectionAsPrimaryAction = true
        case "7년":
            let buttonMenu = UIMenu(title: "경력", children: [sevenYear, none, oneYear, twoYear, threeYear, fourYear, fiveYear, sixYear, eightYear, nineYear, tenYear])

            career.menu = buttonMenu
            career.changesSelectionAsPrimaryAction = true
        case "8년":
            let buttonMenu = UIMenu(title: "경력", children: [eightYear, none, oneYear, twoYear, threeYear, fourYear, fiveYear, sixYear, sevenYear, nineYear, tenYear])

            career.menu = buttonMenu
            career.changesSelectionAsPrimaryAction = true
        case "9년":
            let buttonMenu = UIMenu(title: "경력", children: [nineYear, none, oneYear, twoYear, threeYear, fourYear, fiveYear, sixYear, sevenYear, eightYear, tenYear])

            career.menu = buttonMenu
            career.changesSelectionAsPrimaryAction = true
        case "10년":
            let buttonMenu = UIMenu(title: "경력", children: [tenYear, none, oneYear, twoYear, threeYear, fourYear, fiveYear, sixYear, sevenYear, eightYear, nineYear])

            career.menu = buttonMenu
            career.changesSelectionAsPrimaryAction = true
        default:
            let buttonMenu = UIMenu(title: "경력", children: [none, oneYear, twoYear, threeYear, fourYear, fiveYear, sixYear, sevenYear, eightYear, nineYear, tenYear])

            career.menu = buttonMenu
            career.changesSelectionAsPrimaryAction = true
        }

        
    }
    
    @IBAction func addLink(_ sender: UIButton) {
        
        count += 1
        linkArray.append("")
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
            
            for link in linkArray {
                
                let width = UIScreen.main.bounds.size.width - 32.0
                
                let stackView = UIStackView(frame: CGRect(x: xPos, y: yPos, width: width, height: 34))
                
                stackView.tag = tag
                
                let textField = UITextField(frame: CGRect(x: xPos, y: yPos, width: width - 36.0, height: 34))
                textField.layer.borderWidth = 0.5
                textField.layer.borderColor = UIColor.lightGray.cgColor
                textField.layer.cornerRadius = 5
                textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
                textField.addLeftPadding()
//                textField.becomeFirstResponder()
                textField.tag = tag
                textField.text = link
                
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text == "" {
            removeLink(textField)
        } else {
            linkArray.remove(at: textField.tag-1)
            linkArray.append(textField.text!)
        }
    }
    
    @objc func removeLink(_ sender: AnyObject) {
        
        addLinkBtnTran = addLinkBtnTran - 34.0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.addLink.transform = CGAffineTransform(translationX: 0 , y: self.addLinkBtnTran)
        })
        
        count -= 1
        linkArray.remove(at: sender.tag-1)
        addTextfield()
    }
    
    @IBAction func profileSave(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "정보 수정", message: "저장 하시겠습니까?", preferredStyle: .alert)
        let sucess = UIAlertAction(title: "확인", style: .default) { _ in
            
            self.saveService()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(sucess)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    func saveService() {
        
        let requestPortfolioLink = linkArray.joined(separator: ", ")
        
        let encoder = JSONEncoder()
        let requestData = saveProfileRequest(email: appDelegate!.userEmail, name: nickName.text!, hopeJob: userHopeJob, career: userCareer, introduction: introduction.text, portfolioLink: requestPortfolioLink)
        let param = try? encoder.encode(requestData)
        
        let requestURL = "http://localhost:8080/union/api/user/profile/modify"
        
        let url = URL(string: requestURL)
        ProfileService().setProfile(with: requestData, url: url!, param: param!, image: imgView.image!, imageName: saveImageName) { //1
            (decoded) in
            
            let resultMessage = decoded.resultMessage
            
            if resultMessage == "SUCCESS" {
                
                self.profileSetup()
                
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let mainView = storyboard.instantiateViewController(identifier: "MainList")
                mainView.modalPresentationStyle = .fullScreen
                self.navigationController?.show(mainView, sender: nil)
            }
        }
    }
}

extension MyProfile : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{

            imgView.image = image
            
            if let imageUrl = info[UIImagePickerController.InfoKey.referenceURL] as? URL{
                let imageName = PHAsset.fetchAssets(withALAssetURLs: [imageUrl], options: nil).firstObject?.value(forKey: "filename")
                if let imageName = imageName{
                    saveImageName = imageName as! String
                }
            }
        }

        dismiss(animated: true, completion: nil)
    }
}
