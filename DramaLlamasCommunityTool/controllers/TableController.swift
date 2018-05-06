//
//  TableController.swift
//  DramaLlamasCommunityTool
//
//  Created by Robin kamo on 2018-05-05.
//  Copyright © 2018 Robin kamo. All rights reserved.
//

import UIKit
import Firebase

class TableController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
   
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var messageArray : [Message] = []
    
    var baseForumString : String = "General"

    @IBOutlet weak var chatField: UITextField!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    var questionToAnswerIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        chatField.delegate = self
        retrieveMessages()
    }

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! CustomMessageCell
        
      
        cell.messageBody.text! = messageArray[indexPath.row].messageBody
        cell.sender.text = messageArray[indexPath.row].sender
        
        if cell.sender.text == Auth.auth().currentUser!.email as String? {

            cell.viewWithTag(7)?.backgroundColor = UIColor.blue
            cell.layer.cornerRadius = 10
            
        }
            //Set background as grey if message is from another user
        else {
            cell.viewWithTag(7)?.backgroundColor = UIColor.lightGray
            cell.layer.cornerRadius = 10
        }
        
        return cell
 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        questionToAnswerIndex = indexPath.row
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        
        chatField.endEditing(true)
        chatField.isEnabled = false
        sendBtn.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Messages").child(baseForumString)
        
        let messageDictionary : NSDictionary = ["Sender" : Auth.auth().currentUser!.email as String!, "MessageBody" : chatField.text!]
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, ref) in
            if error != nil {
                print(error!)
            }
            else {
                print("Message saved successfully!")
            }
            DispatchQueue.main.async {
                self.chatField.isEnabled = true
                self.sendBtn.isEnabled = true
                self.chatField.text = ""
            }
        }
    }
    
    func retrieveMessages() {
        let messageDB = Database.database().reference().child("Messages").child(baseForumString)
        
        messageDB.observe(.childAdded, with: { snapshot in
            
            let snapshotValue = snapshot.value as! NSDictionary
            let text = snapshotValue["MessageBody"] as! String
            let sender = snapshotValue["Sender"] as! String
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messageArray.append(message)
            print("Messagearray \(self.messageArray[0].messageBody)")
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        })
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }


}
