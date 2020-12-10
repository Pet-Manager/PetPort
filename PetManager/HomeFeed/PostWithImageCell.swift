//
//  PostWithImageCell.swift
//  PetManager
//
//  Created by Diane Nguyen on 12/10/20.
//

import UIKit

class PostWithImageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petProfileView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
