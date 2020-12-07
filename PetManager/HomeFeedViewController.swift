//
//  HomeFeedViewController.swift
//  PetManager
//
//  Created by Yihui Liao on 11/23/20.
//

import UIKit
import Parse
import AlamofireImage

class HomeFeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pets = [PFObject]()
    
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //self.collectionView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let user = PFUser.current()
        //let objectID = user?.objectId
        
        let query = PFQuery(className: "User")
        query.getObjectInBackground(withId: user?.objectId ?? "") { (user, error) in
            if error == nil {
                self.pets = user!["pets"] as! [PFObject]
                self.collectionView.reloadData()
            } else {
                print("failed")
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetCollectionViewCell", for: indexPath) as! PetCollectionViewCell
        
        let pet = pets[indexPath.row]
        
        let petImage = pet["file"] as! PFFileObject
        let urlString = petImage.url!
        let url = URL(string: urlString)!
 
        cell.petImage.af_setImage(withURL: url)
        
        return cell

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
