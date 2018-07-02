//
//  AvatarCell.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 7/2/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avartarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView(){
        self.layer.backgroundColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
