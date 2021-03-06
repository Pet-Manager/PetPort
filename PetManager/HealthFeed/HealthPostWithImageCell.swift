//
//  HealthPostWithImageCell.swift
//  PetManager
//
//  Created by Diane Nguyen on 12/11/20.
//

import UIKit

class HealthPostWithImageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
