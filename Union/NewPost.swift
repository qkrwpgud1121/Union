//
//  NewPost.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/25.
//

import UIKit

class NewPost: UIViewController {

    @IBOutlet var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboar()
        self.setKeyboardObserver()
    }
    
    @IBAction func saveNewPost(_ sender: UIBarButtonItem) {
        
    }
}
