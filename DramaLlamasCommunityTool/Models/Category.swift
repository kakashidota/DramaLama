//
//  Category.swift
//  DramaLlamasCommunityTool
//
//  Created by Robin kamo on 2018-05-06.
//  Copyright © 2018 Robin kamo. All rights reserved.
//

import UIKit

struct SubCategory {
    let name: String
}

class Category: NSObject {
    let name: String
    var subCategories: [SubCategory] = []
    
    init(name : String, subCats : [SubCategory]) {
        self.name = name
        self.subCategories = subCats
        super.init()
    }
}
