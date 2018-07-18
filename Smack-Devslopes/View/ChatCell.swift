//
//  ChatCell.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 7/18/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var messageLbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configureCell(message: Message){
        let messageBody = message.message ?? ""
        let username = message.userName ?? ""
        messageLbl.text = "\(username): \(messageBody)"
    }

}
