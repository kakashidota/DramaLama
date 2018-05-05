//
//  ForumGeneralControllerViewController.swift
//  DramaLlamasCommunityTool
//
//  Created by Robin kamo on 2018-05-05.
//  Copyright © 2018 Robin kamo. All rights reserved.
//

import UIKit
import Firebase

class ForumGeneralControllerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    @IBOutlet weak var chatBtn: UIButton!
    
    
    let messagesDB = Database.database().reference()
    let arrayOfSubjects = ["Language", "Housing", "Education", "BankId", "General"]

    @IBOutlet weak var subjectPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectPicker.delegate = self
        subjectPicker.dataSource = self
        chatBtn.layer.cornerRadius = 10
        
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfSubjects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfSubjects[row]
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! TableController
        
        controller.baseForumString = arrayOfSubjects[subjectPicker.selectedRow(inComponent: 0)]
            
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
