//
//  SignUpViewController.swift
//  PetManager
//
//  Created by Yihui Liao on 11/23/20.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSignUp(_ sender: Any) {
        
        let user = PFUser()
        
        user["firstName"] = firstNameField.text
        user["lastName"] = lastNameField.text
        user.username = usernameField.text
        user.password = passwordField.text
        
      
        user.signUpInBackground{(success, error) in
            if success {
                self.performSegue(withIdentifier: "tabBarSegue", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
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
