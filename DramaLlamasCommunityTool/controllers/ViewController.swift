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

class ViewController: UIViewController, GIDSignInUIDelegate {

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

