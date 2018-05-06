//
//  ForumViewController.swift
//  DramaLlamasCommunityTool
//
//  Created by Robin kamo on 2018-05-06.
//  Copyright © 2018 Robin kamo. All rights reserved.
//

import UIKit
import Firebase

class ForumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var posts: [ForumPost] = []
    var categoryPath: String = "Tools"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        getForumPost()
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        let cell = myTableView.dequeueReusableCell(withIdentifier: "forumCell") as! ForumTableCell
        cell.titleLabel.text = posts[i].title
        cell.descriptionField.text = posts[i].descriptionText
        cell.userNameLabel.text = posts[i].userName
        if posts[i].needHelp {
            cell.viewWithTag(3)?.backgroundColor = UIColor.green
            cell.backgroundColor = UIColor.green
//            UIColor.init(red: 77, green: 180, blue: 110, alpha: 1.0)
        } else if !posts[i].needHelp {
            cell.viewWithTag(3)?.backgroundColor = UIColor.blue
            cell.backgroundColor = UIColor.blue
            //UIColor.init(red: 66, green: 134, blue: 244, alpha: 1.0)
//            cell.backgroundColor = UIColor(red: 66, green: 134, blue: 244, alpha: 1.0)
            
        }
        return cell
        
    }
    
    func getForumPost(){
        let forumDB = Database.database().reference().child("Forum").child(categoryPath)
        forumDB.observe(.childAdded, with: { snapshot in
            
            let snapshotValue = snapshot.value as! NSDictionary
            let text = snapshotValue["Description"] as! String
            let sender = snapshotValue["User"] as! String
            let postTitle = snapshotValue["Title"] as! String
            let category = snapshotValue["Category"] as! String
            let needHelp = snapshotValue["Help"] as! Bool
            
            
            let post = ForumPost(title: postTitle, descriptionText: text, userName: sender, needHelp: needHelp, category: category)
            
            self.posts.append(post)
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        })
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
