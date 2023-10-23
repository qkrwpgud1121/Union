//
//  MainTableViewCell.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/31.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var stack: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var registrant: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
