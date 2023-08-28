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
