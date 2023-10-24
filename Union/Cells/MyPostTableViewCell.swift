//
//  MyPostTableViewCell.swift
//  Union
//
//  Created by JehyeongPark on 10/23/23.
//

import UIKit

class MyPostTableViewCell: UITableViewCell {

    @IBOutlet weak var myPostType: UILabel!
    @IBOutlet weak var myPostEndDate: UILabel!
    @IBOutlet weak var myPostTitle: UILabel!
    @IBOutlet weak var myPostStack: UILabel!
    @IBOutlet weak var myPostRegistrant: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
