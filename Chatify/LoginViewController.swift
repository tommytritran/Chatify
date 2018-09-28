//
//  LoginViewController.swift
//  Chatify
//
//  Created by Tommy Tran on 27/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func alertMsg(){
        let alertController = UIAlertController(title: "Input Error", message: "Please type in a username and/or password", preferredStyle: .alert)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        // create a cancel action


        self.present(alertController, animated: true,completion: nil)
        
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        if(username == "" || password == ""){
            self.alertMsg()
        }else{
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                    self.alertMsg()
                } else {
                    print("User logged in successfully")
                    // display view controller that needs to shown after successful login
                }
            }
        }
    }
    
    @IBAction func onSignup(_ sender: Any) {
        
        if(usernameField.text == "" || passwordField.text == ""){
            self.alertMsg()
        }else{
            // initialize a user object
            let newUser = PFUser()
            
            // set user properties
            newUser.username = usernameField.text
            newUser.password = passwordField.text
            
            // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                    self.alertMsg()
                } else {
                    print("User Registered successfully")
                    // manually segue to logged in view
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
