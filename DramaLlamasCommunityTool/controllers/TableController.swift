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
    var messageArray : [Message] = [Message]()

    @IBOutlet weak var chatField: UITextField!
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        chatField.delegate = self
        
        
        
        // Do any additional setup after loading the view.
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
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
  
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        chatField.endEditing(true)
        chatField.isEnabled = false
        sendBtn.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Messages")
        
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
