//
//  ProfileVCHeader.swift
//  smallVideo
//
//  Created by zky on 2017/9/20.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class ProfileVCHeader: UIView {
    
    var iconView = UIButton()
    var nameLabel = UILabel()
    var attionNum = UILabel()
    var followNum = UILabel()
    var vistorNum = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(attionNum)
        addSubview(followNum)
        addSubview(vistorNum)
        
        iconView.layer.cornerRadius = 25
        iconView.layer.masksToBounds = true
        iconView.backgroundColor = UIColor.gray
        
        nameLabel.text = "Wey Ye >"
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = .center
        
        attionNum.text = "1"
        attionNum.textColor = UIColor.white
        attionNum.textAlignment = .center
        
        followNum.text = "1.1W"
        followNum.textColor = UIColor.white
        followNum.textAlignment = .center
        
        vistorNum.text = "10w"
        vistorNum.textColor = UIColor.white
        vistorNum.textAlignment = .center

        
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(60)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.top.equalTo(iconView.snp.bottom).offset(8)
            make.size.equalTo(CGSize(width: 200, height: 20))
        }
        
        followNum.snp.makeConstraints { (make) in
            make.centerX.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.size.equalTo(CGSize(width: 80, height: 20))
        }
        
        attionNum.snp.makeConstraints { (make) in
            make.right.equalTo(followNum.snp.left).offset(-40)
            make.top.equalTo(followNum)
            make.size.equalTo(CGSize(width: 80, height: 20))
        }
        
        vistorNum.snp.makeConstraints { (make) in
            make.left.equalTo(followNum.snp.right).offset(40)
            make.top.equalTo(followNum)
            make.size.equalTo(CGSize(width: 80, height: 20))
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        
        
        
        
        
        
        
    }
    
}
