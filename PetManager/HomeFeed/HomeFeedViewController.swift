//
//  HomeFeedViewController.swift
//  PetManager
//
//  Created by Yihui Liao on 11/23/20.
//

import UIKit
import Parse
import AlamofireImage

class HomeFeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var pets = [PFObject]()
    var posts = [PFObject]()
        
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
        tableView.delegate = self
        tableView.dataSource = self
        
        self.collectionView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className:"Posts")
        query.includeKeys(["author","pet"]) // fetch actual object
        query.limit = 10
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
        
        
        let user = PFUser.current()
        //let objectID = user?.objectId
        
        //(post["comments"] as? [PFObject]) ?? []
        
        
        self.pets = (user?["pets"] as? [PFObject]) ?? []
        //self.pets = user?["pets"] as! [PFObject]
        self.collectionView.reloadData()
        //print(self.pets.count)
 
 
        
        /**
        
        let query = PFUser.query()
        query?.getObjectInBackground(withId: user?.objectId ?? "") { (user, error) in
            if error == nil {
                self.pets = user!["pets"] as! [PFObject]
                self.collectionView.reloadData()
                print(self.pets.count)
            } else {
                print("failed")
            }
 
            
            
        }
 
 */
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetCollectionViewCell", for: indexPath) as! PetCollectionViewCell
        
        let pet = pets[indexPath.row]
        
        pet.fetchInBackground{(pet, error) in
            if error == nil {
                let name = pet?["name"] as? String
                //print(name!)
                cell.petName.text = name
            } else {
                print("name: failed")
            }
        }
        
        pet.fetchInBackground{(pet, error) in
            if error == nil {
                let petImage = pet?["image"] as! PFFileObject
                let urlString = petImage.url!
                let url = URL(string: urlString)!
         
                cell.petImage.af_setImage(withURL: url)
            } else {
                print("file: failed")
            }
        }
        
        /**
        let petImage = pet["file"] as! PFFileObject
        let urlString = petImage.url!
        let url = URL(string: urlString)!
 
        cell.petImage.af_setImage(withURL: url)
        */
        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        // check to see if user has uploaded picture in post
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        let imageData = try! Data(contentsOf: url)
        let image = UIImage(data: imageData)!
        
        // if true, then no image uploaded in post
        if isEqualImage(image){
            // display post without image on home feed
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
            cell.userLabel.text = user.username
            cell.captionLabel.text = post["caption"] as? String
//            cell.createdAtLabel.text = post["createdAt"] as? String
            
            return cell
        } else {
            // there is an image
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostWithImageCell") as! PostWithImageCell
            cell.authorLabel.text = user.username
            cell.captionLabel.text = post["caption"] as? String
            cell.createdAtLabel.text = post["createdAt"] as? String
            cell.photoView.af.setImage(withURL: url)
            
            return cell
        }
    }
    
    func isEqualImage(_ image: UIImage) -> Bool {
        let imageHolder: UIImage = UIImage(named: "post-pet-img-holder")!
        let stockImage = imageHolder.pngData()
        let curImage = image.pngData()
        
        return stockImage == curImage
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
