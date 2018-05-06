//
//  ViewController.swift
//  DramaLlamasCommunityTool
//
//  Created by Robin kamo on 2018-05-05.
//  Copyright © 2018 Robin kamo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
 

    
    
    @IBOutlet weak var LanguageChoose: UITextField!
    
    @IBOutlet weak var langpicker: UIPickerView!
    
    //create the list of languages

    
    //Codes for the list
    var listOfLangs : [String] = ["Swedish", "English", "Arabic", "Afghan", "Indian", "German"]
    
    
    //codes for the list ends here
    
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var GoogleButton: GIDSignInButton!
    var newUser : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        statusLabel.isHidden = true
        langpicker.delegate = self
        langpicker.dataSource = self
     
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfLangs.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listOfLangs[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        
        return NSAttributedString(string: listOfLangs[row], attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
  
    
    override func viewDidAppear(_ animated: Bool) {
        if GIDSignIn.sharedInstance().currentUser != nil {
            performSegue(withIdentifier: "gotomain", sender: self)
        }
    }

    
    @IBAction func GoogleSignINPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
   
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ..
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                // ...
                return
            }
        
        }
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: userNameField.text!, password: passwordField.text!) { (user, error) in
            if user != nil {
                if self.newUser {
                    self.performSegue(withIdentifier: "gotoprofile", sender: self)
                } else{
                    self.performSegue(withIdentifier: "gotomain", sender: nil)

                }
                
            }
        }
    }
    
    @IBAction func registerdPressed(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: userNameField.text!, password: passwordField.text!) { (user, error) in
            self.statusLabel.isHidden = false
            self.statusLabel.text = "Register Success"
            self.newUser = true
            
        }
    }
    
    func signout(){
        GIDSignIn.sharedInstance().signOut()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

