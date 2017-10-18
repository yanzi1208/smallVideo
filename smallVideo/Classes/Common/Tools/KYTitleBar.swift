//
//  KYTitleBar.swift
//  smallVideo
//
//  Created by zky on 2017/9/21.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

enum titleBar {
    case none
    case back
    case custom
}

@objc protocol KYTitleBarDelegate {
    @objc optional func leftButtonTouched()
    @objc optional func rightButtonTouched()
}

class KYTitleBar: UIView {
    
    var delegate : KYTitleBarDelegate?
    
    open var leftButton : UIButton?
    open var rightButton : UIButton?
    open var titleLabel : UILabel?
    
    init(leftType : titleBar, rightType : titleBar, titleString : String) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        if leftType != .none {
            leftButton = UIButton.init(type: .custom)
            leftButton!.frame = CGRect(x: 0, y: 20, width: 44, height: 44)
            leftButton!.setTitle(nil, for: .normal)
            leftButton!.setImage(imageNamed("leftbackicon_white_titlebar_night_24x24_"), for: .normal)
            leftButton!.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
            addSubview(leftButton!)
        }
        
        if rightType != .none {
            rightButton = UIButton.init(type: .custom)
            rightButton!.frame = CGRect(x: SCREEN_WIDTH-64, y: 20, width: 44, height: 44)
            rightButton!.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
            addSubview(rightButton!)
        }
        
        
        titleLabel = UILabel.init(frame: CGRect(x: SCREEN_WIDTH/2-72, y: 20, width: 144, height: 44))
        titleLabel!.text = titleString
        titleLabel!.textAlignment = .center
        titleLabel!.font = fontSize(18)
        addSubview(titleLabel!)
        
        
        let bottomLine = UIView.init(frame: CGRect(x: 0, y: 63, width: SCREEN_WIDTH, height: 1))
        bottomLine.backgroundColor = rgb(230, 230, 230)
        addSubview(bottomLine)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func leftButtonClick() {
        delegate?.leftButtonTouched!()
    }

    @objc func rightButtonClick() {
        delegate?.rightButtonTouched!()
    }
    
}
