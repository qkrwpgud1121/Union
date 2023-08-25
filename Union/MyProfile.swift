//
//  MyProfile.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/23.
//

import UIKit

class MyProfile: UIViewController {

    @IBOutlet var profileImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.layer.borderWidth = 2
        profileImg.layer.borderColor = UIColor.gray.cgColor
        profileImg.clipsToBounds = true
    }

}
