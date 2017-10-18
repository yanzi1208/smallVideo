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


// MARK: - UIColor
func hexInt(_ hexValue: Int) -> UIColor {
    return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(hexValue & 0xFF)) / 255.0,
                   alpha: 1.0)
}

func rgba(_ r : CGFloat,_ g : CGFloat,_ b : CGFloat, _ a : CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func rgb(_ r : CGFloat,_ g : CGFloat,_ b : CGFloat ) -> UIColor {
    return rgba(r, g, b, 1)
}


// MARK:- 获取字符串的CGSize
func getSize(str:String, fontSize: CGFloat) -> CGSize {
    let size = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT))
    return str.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil).size
}
