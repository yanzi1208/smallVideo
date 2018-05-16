//
//  KYConfig.swift
//  SmallVideo
//
//  Created by zky on 2017/8/27.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let STATUBAR_HEIGHT = 22;
let NAVBAR_HEIGHT = 64;
let KScaleX = (SCREEN_WIDTH/320.0)
let KScaleY = (SCREEN_HEIGHT/568.0)

// MARK: - UIImage
func imageNamed(_ image : String) -> UIImage {
    return UIImage(named: image)!
}

func imageWithColor(_ color: UIColor) -> UIImage {
    
    let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
}


// MARK: - UIFont
func fontSize(_ x : Int) -> UIFont {
    return UIFont.systemFont(ofSize: CGFloat(x))
}



// MARK:- 获取字符串的CGSize
func getSize(str:String, fontSize: CGFloat) -> CGSize {
    let size = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT))
    return str.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil).size
}
