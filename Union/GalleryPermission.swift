//
//  GalleryPermission.swift
//  Union
//
//  Created by JehyeongPark on 2/12/24.
//

import UIKit

class GalleryPermission: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func goSetting(_ sender: UIButton) {
        DispatchQueue.main.async {
            guard let settingURL = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingURL) else { return }
            UIApplication.shared.open(settingURL, options: [:])
        }
    }

}
