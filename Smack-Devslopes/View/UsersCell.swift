//
//  UsersCell.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 7/28/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class UsersCell: UITableViewCell {

    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var avatarName: UILabel!
    @IBOutlet weak var avatarColor: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(user: Users){
        id.text = user.id
        avatarName.text = user.avatarName
        avatarColor.text = user.avatarColor
        name.text = user.name
        email.text = user.email

    }

}
