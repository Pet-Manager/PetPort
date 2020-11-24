//
//  HomeFeedViewController.swift
//  PetManager
//
//  Created by Yihui Liao on 11/23/20.
//

import UIKit
import Parse

class HomeFeedViewController: UIViewController {

    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        //let currentUser = PFUser.current()

        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate

        delegate.window?.rootViewController = loginViewController
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
