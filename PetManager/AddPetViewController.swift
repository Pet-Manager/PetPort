//
//  AddPetViewController.swift
//  PetManager
//
//  Created by Yihui Liao on 12/1/20.
//

import UIKit
import Parse
import AlamofireImage

class AddPetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var petNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
 
         */
 
        // Do any additional setup after loading the view.
    }

    
    @IBAction func addImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 100, height: 100)
        let scaledImage = image.af_imageAspectScaled(toFit: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func onAddPet(_ sender: Any) {
        
        let pet = PFObject(className: "Pets")
        let user = PFUser.current()!
   //     let objectID = user.objectId
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        pet["image"] = file
        pet["name"] = petNameField.text
        pet["author"] = PFUser.current()!
        
        user.add(pet, forKey: "pets")
       
        
        user.saveInBackground{(success, error) in
            if success {
                //self.dismiss(animated: true, completion: nil)
                print("success")
            } else{
                print("error")
            }
        }

        
        pet.saveInBackground{(success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("success")
            } else{
                print("error")
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
