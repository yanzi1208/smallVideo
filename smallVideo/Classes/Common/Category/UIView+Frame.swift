//
//  UIView+Frame.swift
//  smallVideo
//
//  Created by zky on 2017/9/20.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

extension UIView {
    
    var frameScreenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var frameScreenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var frameWidth: CGFloat {
        set {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
        
        get {
            return self.frame.width
        }
    }
    
    var frameHeight: CGFloat {
        set {
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
        
        get {
            return self.frame.height
        }
    }
    
    var frameX: CGFloat {
        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
        
        get {
            return self.frame.minX
        }
    }
    
    var frameY: CGFloat {
        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
        
        get {
            return self.frame.minY
        }
    }
    
    var frameMaxX: CGFloat {
        set {
            self.frameWidth = newValue - self.frameX
        }
        
        get {
            return self.frame.maxX
        }
    }
    
    var frameMaxY: CGFloat {
        set {
            self.frameHeight = newValue - self.frameY
        }
        
        get {
            return self.frame.maxY
        }
    }
    
    var frameMidX: CGFloat {
        set {
            self.frameWidth = newValue * 2
        }
        
        get {
            return self.frame.minX + self.frame.width / 2
        }
    }
    
    var frameMidY: CGFloat {
        set {
            self.frameHeight = newValue * 2
        }
        
        get {
            return self.frame.minY + self.frame.height / 2
        }
    }
    
    var frameCenterX: CGFloat {
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
        
        get {
            return self.center.x
        }
    }
    
    var frameCenterY: CGFloat {
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
        
        get {
            return self.center.y
        }
    }
    
    var frameOrigin: CGPoint {
        set {
            var rect = self.frame
            rect.origin = newValue
            self.frame = rect
        }
        
        get {
            return self.frame.origin
        }
    }
    
    var frameSize: CGSize {
        set {
            var rect = self.frame
            rect.size = newValue
            self.frame = rect
        }
        
        get {
            return self.frame.size
        }
    }
}
