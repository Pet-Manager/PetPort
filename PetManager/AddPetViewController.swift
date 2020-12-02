//
//  AddPetViewController.swift
//  PetManager
//
//  Created by Yihui Liao on 12/1/20.
//

import UIKit
import Parse

class AddPetViewController: UIViewController {
    
    var didComeFromHome : Bool!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onAddPet(_ sender: Any) {
        
        if (didComeFromHome){
            self.performSegue(withIdentifier: "homeSegue", sender: nil)
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
