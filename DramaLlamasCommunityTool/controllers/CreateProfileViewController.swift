//
//  CreateProfileViewController.swift
//  DramaLlamasCommunityTool
//
//  Created by Robin kamo on 2018-05-05.
//  Copyright © 2018 Robin kamo. All rights reserved.
//

import UIKit
import Firebase

class CreateProfileViewController: UIViewController {

    
    @IBOutlet weak var cityFeild: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var saveProfileBtn: UIButton!
    
    @IBOutlet weak var apartmentNrField: UITextField!
    @IBOutlet weak var zipField: UITextField!
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    var myDatabase = Database.database().reference()
    
    var user: User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfile()
        
    }
    func setupProfile(){
        nameField.text = Auth.auth().currentUser?.displayName
        surnameField.text = Auth.auth().currentUser?.displayName
        emailField.text = Auth.auth().currentUser?.email
    }

    @IBAction func saveProfilePressed(_ sender: Any) {
        if let name = nameField.text{
            user.name = nameField.text!
        } else {
            nameField.placeholder = "Enter name"
        }
            
        
        user.email = emailField.text!
        user.city = cityFeild.text!
        user.street = streetField.text!
        user.zipCode = Int(zipField.text!)!
        user.descriptionText = descriptionView.text!
        user.apartmentNo = Int(apartmentNrField.text!)!
        user.surname = surnameField.text!
        user.uid = Auth.auth().currentUser!.uid
        
        var dic : [String : AnyObject] = ["Name" : user.name as AnyObject,"uid" : user.uid as AnyObject, "Email" : user.email as AnyObject, "City" : user.city as AnyObject, "Street" : user.street as AnyObject as AnyObject, "ZipCode" : user.zipCode as AnyObject, "Description" : user.descriptionText as AnyObject as AnyObject, "AprtNo" : user.apartmentNo as AnyObject, "Surname" : user.surname as AnyObject]
        
        myDatabase.child("Users").child(Auth.auth().currentUser!.uid).setValue(dic)
        
        performSegue(withIdentifier: "profiletomain", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
