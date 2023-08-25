//
//  SideMenuViewController.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/21.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet var profile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profile.layer.cornerRadius = profile.frame.width / 2
        profile.layer.borderWidth = 2
        profile.layer.borderColor = UIColor.gray.cgColor
        profile.clipsToBounds = true
    }

    @IBAction func logOut(_ sender: UIButton) {
        
    }
}
