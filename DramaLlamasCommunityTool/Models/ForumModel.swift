//
//  ForumModel.swift
//  DramaLlamasCommunityTool
//
//  Created by Robin kamo on 2018-05-06.
//  Copyright © 2018 Robin kamo. All rights reserved.
//

import UIKit
import Firebase

func postToForum(post: ForumPost){
    let forumDB = Database.database().reference().child("Forum").child(post.category)
    
    let postDictionary : NSDictionary = ["User": post.userName , "Title" : post.title, "Description" : post.descriptionText, "Category" : post.category, "Help" : post.needHelp]
    
    forumDB.childByAutoId().setValue(postDictionary) {
        (error, ref) in
        if error != nil {
            print(error!)
        }
        else {
            print("Message saved successfully!")
        }
    }
}



