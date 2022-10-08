//
//  PostCell.swift
//  UserApp
//
//  Created by Esin Esen on 5.04.2022.
//

import UIKit

class PostCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    var id = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.cornerRadius = 5
    }
    
    func configure(model: Post) {
        self.titleLabel.text = model.title
        self.id = String(model.id!)
    }
    
}
