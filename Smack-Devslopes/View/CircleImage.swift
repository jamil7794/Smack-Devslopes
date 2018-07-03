//
//  CircleImage.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 7/3/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

@IBDesignable // we can see the result inside the storyboard
class CircleImage: UIImageView {

    override func awakeFromNib() {
        setupview()
    }
    
    func setupview(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true // pic doesnt go out of bound
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupview()
    }
}
