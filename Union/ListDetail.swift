//
//  listDetail.swift
//  Union
//
//  Created by JehyeongPark on 10/7/23.
//

import UIKit

class ListDetail: UIViewController {
    
    var prepareSegue: String?
    
    var prepareBoardId: String?
    var prepareType: String?
    var preparePeople: String?
    var prepareProceedType: String?
    var prepareProceedPeriod: String?
    var prepareStack: String?
    var prepareEndDate: String?
    var preparePosition: String?
    var prepareContact: String?
    var prepareTitle: String?
    var prepareDetail: String?
    var prepareRegistrant: String?

    @IBOutlet weak var detailMenu: UIBarButtonItem!
    
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var detailType: UILabel!
    @IBOutlet weak var detailPeople: UILabel!
    @IBOutlet weak var detailProceedType: UILabel!
    @IBOutlet weak var detailProceedPeriod: UILabel!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailEndDate: UILabel!
    @IBOutlet weak var detailPosition: UILabel!
    @IBOutlet weak var detailContact: UILabel!
    @IBOutlet weak var detailStack: UILabel!
    @IBOutlet weak var detailRegistrant: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.layer.borderColor = UIColor.lightGray.cgColor
        detailView.layer.borderWidth = 1
        detailView.layer.cornerRadius = 15
        
        detail.sizeToFit()
        
        if prepareSegue == "MyPostDetail" {
            detailMenu.isHidden = false
            setMenu()
        }

        detailType.text = prepareType
        detailPeople.text = preparePeople
        detailProceedType.text = prepareProceedType
        detailProceedPeriod.text = prepareProceedPeriod
        detailTitle.text = prepareTitle
        detailEndDate.text = prepareEndDate
        detailPosition.text = preparePosition
        detailContact.text = prepareContact
        detailStack.text = prepareStack
        detailRegistrant.text = prepareRegistrant
        detail.text = prepareDetail
    }
    
    func setMenu() {
        
        let modify = UIAction(title: "수정", image: UIImage(systemName: "square.and.pencil"), handler: {_ in self.modify()})
        let delete = UIAction(title: "삭제", image: UIImage(systemName: "trash"),attributes: .destructive, handler: {_ in self.postDelete()})

        let buttonMenu = UIMenu(title: "", children: [modify, delete])

        detailMenu.menu = buttonMenu
    }
    
    func postDelete() {
        
        let encoder = JSONEncoder()
        let requestData = MyPostDelete(unionBoardId: prepareBoardId!, email: userEmail, token: userToken)
        
        let param = try? encoder.encode(requestData)
        
        let url = URL(string: "http://localhost:8080/union/api/union/board/delete")
        
        ListDetailService().setListDetail(url: url!, param: param!) { //1
            (decoded) in
            
            let resultMessage = decoded.resultMessage
            
            if resultMessage == "SUCCESS" {
                DispatchQueue.main.async {
                    do {
                        let alert = UIAlertController(title: "", message: "삭제 되었습니다.", preferredStyle: .alert)
                        
                        let sucess = UIAlertAction(title: "확인", style: .default){_ in
                            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                            let mainView = storyboard.instantiateViewController(identifier: "MyPost")
                            mainView.modalPresentationStyle = .fullScreen
                            self.navigationController?.show(mainView, sender: nil)
                        }
                        
                        alert.addAction(sucess)
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    func modify() {
        
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let mainView = storyboard.instantiateViewController(identifier: "NewPost")
        guard let mainView = self.storyboard?.instantiateViewController(withIdentifier: "NewPost") as? NewPost else {return}
        
        mainView.segueType = "modify"
        mainView.segueBoardId = prepareBoardId!
        mainView.type = prepareType!
        mainView.person = Int(preparePeople!.prefix(1))!
        mainView.method = prepareProceedType!
        mainView.period = prepareProceedPeriod!
        mainView.endDate = prepareEndDate!
        mainView.segueContect = prepareContact!
        mainView.segueTitle = prepareTitle!
        mainView.segueDetail = prepareDetail!
        
        mainView.segueStack = prepareStack!
        mainView.seguePosition = preparePosition!

        mainView.modalPresentationStyle = .fullScreen
        self.navigationController?.show(mainView, sender: nil)
    }
}
