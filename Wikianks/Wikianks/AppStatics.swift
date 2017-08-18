//
//  AppStatics.swift
//  Wikianks
//
//  Created by Pawan on 11/08/17.
//  Copyright © 2017 Pawan. All rights reserved.
//

import Foundation
import UIKit

let brandColor = UIColor(red: 0.290, green: 0.565, blue: 0.886, alpha: 1.00)
let brighterBrandColor = UIColor(red: 0.651, green: 0.808, blue: 0.992, alpha: 1.00)
let fontColorOnBrandColor = UIColor.white

enum levels{
    case easy
    case medium
    case hard
}

var selectedLevel = levels.easy

// MARK:- Fonts
let fontNamePrimary = "DINPro-Regular"
let fontNamePrimaryLight = "DINPro-Light"
let fontNamePrimaryBold = "DINPro-Bold"
let fontNameCustom = "BlockBE-Condensed"
let fontNameCustomTextured = "Block Berthold Textured"
