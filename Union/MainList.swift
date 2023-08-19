//
//  MainListViewController.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/19.
//

import UIKit

class MainList: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }

}
