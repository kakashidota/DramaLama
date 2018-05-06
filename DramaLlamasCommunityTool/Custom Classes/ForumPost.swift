//
//  ForumPost.swift
//  DramaLlamasCommunityTool
//
//  Created by Robin kamo on 2018-05-06.
//  Copyright © 2018 Robin kamo. All rights reserved.
//

import UIKit

class ForumPost: NSObject {
    let title: String
    let descriptionText: String
    let userName: String
    let needHelp: Bool
    let category: String
    
    init(title: String, descriptionText: String, userName: String, needHelp: Bool, category: String) {
        self.title = title
        self.descriptionText = descriptionText
        self.userName = userName
        self.needHelp = needHelp
        self.category = category
        super.init()
    }
    
}
