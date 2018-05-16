//
//  UIColor+Category.swift
//  smallVideo
//
//  Created by zky on 2017/12/7.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

// MARK: - UIColor
func hexInt(_ hexValue: Int) -> UIColor {
    return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(hexValue & 0xFF)) / 255.0,
                   alpha: 1.0)
}

func rgba(r : CGFloat, g : CGFloat, b : CGFloat, a : CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func rgb(r : CGFloat,g : CGFloat,b : CGFloat ) -> UIColor {
    return rgba(r: r, g: g, b: b, a: 1)
}

// MARK: - 获取随机色
extension UIColor {
    
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}
// MARK:- 从颜色中获取RGB的值
extension UIColor {
    func getRGBValue() -> (CGFloat, CGFloat, CGFloat) {
        
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        return (red * 255, green * 255, blue * 255)
    }
}
