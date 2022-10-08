//
//  CommentsCell.swift
//  UserApp
//
//  Created by Esin Esen on 6.04.2022.
//

import UIKit

class CommentsCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.cornerRadius = 5
    }
    
    func configure(model: Comment) {
        self.nameLabel.text = model.name
        self.emailLabel.text = model.email
        self.bodyLabel.text = model.body
    }
    
}
