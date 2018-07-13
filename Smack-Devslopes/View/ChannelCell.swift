//
//  ChannelCell.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 7/13/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    

    //Outlets
    @IBOutlet weak var channelName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) { //82
        super.setSelected(selected, animated: animated)
// What will the view look like when any of the channels are selected
        
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }

    func confifureCell(channel : Channel) { //82
        let title = channel.channelTitle ?? ""
        // If you cant find the value there then return an empty string

        channelName.text = title
    }
}
