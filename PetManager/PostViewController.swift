//
//  PostViewController.swift
//  PetManager
//
//  Created by Diane Nguyen on 11/28/20.
//

import UIKit
import Parse
import AlamofireImage

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pets = [PFObject]()

    //pet dummy data
    func petData() -> PFObject {
        let pet = PFObject(className: "Pets")
        pet["name"] = "Douglas"
        pet["author"] = PFUser.current()!
        
        return pet
    }

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func onOpenCamera(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        //check to see if camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFit: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)

    }
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var uncheckedButton: UIButton!
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        let imageData = imageView.image!.pngData()
                let file = PFFileObject(name: "image.png", data: imageData!)
                
        post["caption"] = textView.text!
        post["isHealth"] = isHealth
        post["author"] = PFUser.current()!
        post["pet"] = petData() // after add pet, figure out how to select pet
        post["image"] = file
        
        print("health status: \(isHealth)")
        
        post.saveInBackground{ (success, error) in
            if success {
                print("saved post")
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
    
    // https://stackoverflow.com/questions/5562938/looking-to-understand-the-ios-uiviewcontroller-lifecycle
    // call viewWillAppear to reload image and text
    override func viewWillAppear(_ animated: Bool) {
        let imageHolder: UIImage = UIImage(named: "post-pet-img-holder")!
        imageView.image = imageHolder
        
        let placeHolderText: String = "Type your pet post here"
        textView.text = placeHolderText
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetPostCollectionViewCell", for: indexPath) as! PetPostCollectionViewCell
        
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
