//
//  listDetail.swift
//  Union
//
//  Created by JehyeongPark on 10/7/23.
//

import UIKit

class ListDetail: UIViewController {
    
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

}
