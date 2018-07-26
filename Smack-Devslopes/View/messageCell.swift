//
//  messageCell.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 7/18/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class messageCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLml: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message){
        messageLbl.text = message.message
        userNameLbl.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = userDataService.instance.returnUIColor(components: message.userAvatarColor)
        timeStampLml.text = message.timeStamp
    }
}
