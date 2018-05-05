//
//  TableViewCell.swift
//  
//
//  Created by Robin kamo on 2018-05-05.
//

import UIKit

class CustomMessageCell: UITableViewCell {

    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
