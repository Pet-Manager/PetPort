//
//  PostViewController.swift
//  PetManager
//
//  Created by Diane Nguyen on 11/28/20.
//

import UIKit
import Parse

class PostViewController: UIViewController {
    
    //pet dummy data
    func petData() -> PFObject {
        let pet = PFObject(className: "Pets")
        pet["name"] = "Douglas"
        pet["author"] = PFUser.current()!
        
        return pet
    }

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var uncheckedButton: UIButton!
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["caption"] = textView.text!
        post["isHealth"] = isHealth
        post["author"] = PFUser.current()!
        post["pet"] = petData() // after add pet, figure out how to select pet
        
        print("health status: \(isHealth)")
        
        post.saveInBackground{ (success, error) in
            if success {
                print("saved post")
                // do we want the page to refresh?
                // then switch tab control to home feed view
                self.tabBarController?.selectedIndex = 0
            } else {
                print("error saving post")
            }
            
        }
        
    }
    
    var unchecked:Bool = true
    var isHealth:Bool = false
    
    @IBAction func checkedBox(_ sender: Any) {
        if (unchecked) {
            uncheckedButton.setImage(UIImage(named:"checked"), for: UIControl.State.normal)
            unchecked = false
            isHealth = true
            print("checked")
        } else {
            uncheckedButton.setImage(UIImage(named:"unchecked"), for: UIControl.State.normal)
            unchecked = true
            isHealth = false
            print("unchecked")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.layer.cornerRadius = 10.0
        textView.layer.borderWidth = 1.0
        textView.clipsToBounds = true
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
