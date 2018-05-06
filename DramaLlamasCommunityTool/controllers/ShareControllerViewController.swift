//
//  ShareControllerViewController.swift
//  DramaLlamasCommunityTool
//
//  Created by Robin kamo on 2018-05-06.
//  Copyright © 2018 Robin kamo. All rights reserved.
//

import UIKit
import Firebase

struct ShareCategory {
    let name: String
    let subCategories: [String]
}

class ShareControllerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var askSwitch: UISwitch!
    @IBOutlet weak var solutionSwitch: UISwitch!
    
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var myPickerView: UIPickerView!
    var categories: [ShareCategory] = []
    var subCategories: [String] = []
    var pickerIndex = 0
    var needHelp: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        solutionSwitch.isOn = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myPickerView.dataSource = self
        myPickerView.delegate = self
        let tools: ShareCategory = ShareCategory(name: "Tools", subCategories: ["All", "Powertools", "Handtools"])
        let fruit: ShareCategory = ShareCategory(name: "Fruit", subCategories: ["All" ,"Banana", "Apple", "Kiwi"])
        categories.append(tools)
        categories.append(ShareCategory(name: "Lessons", subCategories: ["All" ,"Swedish", "Math", "Bio"]))
        categories.append(fruit)
        myPickerView.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return categories.count
        } else if component == 1 {
            return categories[pickerIndex].subCategories.count
        } else {return 0}
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return categories[row].name
//            return categories[row].name
        } else if component == 1 {
            return categories[pickerIndex].subCategories[row]
        } else {
            return "Wrong"
        }
    }
    
    @IBAction func helpSwitch(_ sender: Any) {
        if askSwitch.isOn {
            solutionSwitch.isOn = false
            needHelp = true
        } else {
            solutionSwitch.isOn = true
            needHelp = false
        }
    }
    
    @IBAction func solutionSwitchpressed(_ sender: Any) {
        if solutionSwitch.isOn {
            askSwitch.isOn = false
            needHelp = false
        } else {
            askSwitch.isOn = true
            needHelp = true
        }
    }
    
    @IBAction func postOnForum(_ sender: Any) {
        guard let title = titleField.text else {return}
        guard let description = descriptionField.text else {return}
        let username = Auth.auth().currentUser?.uid
        
        let database = Database.database().reference().child("Users").child(username!).observe(.value) { (snapshot) in
            let snapshotValue = snapshot.value as? NSDictionary
            
            let name = snapshotValue!["Name"] as! String ?? ""
            let post = ForumPost(title: title, descriptionText: description, userName: name, needHelp: self.needHelp, category: self.categories[self.pickerIndex].name)
            
            print(snapshotValue)
            postToForum(post: post)
            self.performSegue(withIdentifier: "seeposts", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeposts" {
            let controller = segue.destination as! ForumViewController
            controller.categoryPath = categories[pickerIndex].name
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            pickerIndex = row
            myPickerView.reloadAllComponents()
        }
 
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    

}
