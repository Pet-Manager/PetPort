//
//  PetPostCollectionViewCell.swift
//  PetManager
//
//  Created by Yihui Liao on 12/7/20.
//

import UIKit

class PetPostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var petImage: UIImageView!
    
    @IBOutlet weak var petName: UILabel!
    override func layoutSubviews() {
        petImage.layer.cornerRadius = petImage.bounds.height / 2
        petImage.clipsToBounds = true
    }
}
