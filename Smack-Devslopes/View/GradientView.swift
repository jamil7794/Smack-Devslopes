//
//  GradientView.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 6/13/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

@IBDesignable // Let this class know that it needs to render inside the storyboard (it id going to be able to work in storyboard 65
class GradientView: UIView {
    
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        didSet{
            self.setNeedsLayout()
        }
        // setting layout with the new color. change inside the storboard 65
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1){
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        // updating 2 colors 65
        gradientLayer.startPoint = CGPoint(x:0 ,y:0) //start ffrom top left 65
        gradientLayer.endPoint = CGPoint(x:1, y:1) // end in bottom right 65
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
}
