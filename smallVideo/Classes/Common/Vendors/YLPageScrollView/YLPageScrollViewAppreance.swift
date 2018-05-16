//
//  YLPageScrollViewAppreance.swift
//  YLPageScrollView
//
//  Created by Youngly on 2017/3/12.
//  Copyright © 2017年 YL. All rights reserved.
//

import UIKit

class YLPageScrollViewAppreance {

    var titleFont : UIFont = UIFont.systemFont(ofSize: 14)
    var titleViewHeight : CGFloat = 40.0
    var titleOffset : CGFloat = 8
    var titleMargin : CGFloat = 20
    var botomLineHeight : CGFloat = 3.0
    var maxScaleRatio : CGFloat = 1.2
    
    
    var titleNormalColor : UIColor = rgb(r: 200, g: 200, b: 200)
    var titleSelectedColor : UIColor = rgb(r: 50, g: 50, b: 50)
    
    lazy var bottomLineColor : UIColor = {
        let bottomLineColor = self.titleNormalColor
        return bottomLineColor
    }()
    
    var isScrollEnable : Bool = false
    var isShowBottomLine = false
    var isNeedScale = true
}
