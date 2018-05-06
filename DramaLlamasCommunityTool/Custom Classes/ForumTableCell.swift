//
//  ForumTableCell.swift
//  DramaLlamasCommunityTool
//
//  Created by Robin kamo on 2018-05-06.
//  Copyright © 2018 Robin kamo. All rights reserved.
//

import UIKit

class ForumTableCell: UITableViewCell {
    
    

    

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
