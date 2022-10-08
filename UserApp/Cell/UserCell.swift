//
//  UserCell.swift
//  UserApp
//
//  Created by Esin Esen on 4.04.2022.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var id = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: User) {
        self.nameLabel.text = model.name
        self.usernameLabel.text = model.username
        self.id = String(model.id!)
    }

}
