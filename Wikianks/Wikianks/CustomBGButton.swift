//
//  CustomBGButton.swift
//  Wikianks
//
//  Created by Pawan on 11/08/17.
//  Copyright © 2017 Pawan. All rights reserved.
//

import UIKit

class CustomBGButton: UIButton {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit(){
        self.backgroundColor = brandColor
        self.setTitleColor(fontColorOnBrandColor, for: UIControlState.normal)
        self.titleLabel?.font = UIFont(name: fontNameCustom, size: (self.titleLabel?.font.pointSize)!)
        self.layer.cornerRadius = 4
    }
    

}
