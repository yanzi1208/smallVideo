//
//  ProfileHeaderCell.swift
//  smallVideo
//
//  Created by zky on 2017/9/29.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UIView {

    lazy var collectButton: UIButton = {
        let button = UIButton.init()
        button.setImage(imageNamed("favoriteicon_profile_24x24_"), for: .normal)
        button.setTitle("收藏", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.black, for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(-15, 13, 0, 0)
        button.titleEdgeInsets = UIEdgeInsetsMake(33, -21, 0, 0)
        button.addTarget(self, action: #selector(collectButtonTouch), for: .touchUpInside)
        return button
    }()
    
    lazy var styleButton: UIButton = {
        let button = UIButton.init()
        button.theme_setImage(["nighticon_profile_24x24_","dayicon_profile_night_24x24_" ], forState: .normal)
        button.setTitle("夜间", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.black, for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(-15, 13, 0, 0)
        button.titleEdgeInsets = UIEdgeInsetsMake(33, -21, 0, 0)
        button.addTarget(self, action: #selector(ProfileHeaderCell.styleButtonTouch(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    var collectButtonBlock:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        
        addSubview(collectButton)
        addSubview(styleButton)
        
        let emptyView = UIView.init(frame: CGRect(x: 0, y: 70, width: SCREEN_WIDTH, height: 10))
        emptyView.backgroundColor = UIColor.darkGray
        addSubview(emptyView)
        
        collectButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.left).offset(screen_width()/4.0)
            make.top.equalTo(10)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        styleButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.right).offset(-screen_width()/4.0)
            make.top.equalTo(collectButton)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
    
    @objc func collectButtonTouch() {
        self.collectButtonBlock?()
        print("收藏")
    }
    @objc func styleButtonTouch(sender: UIButton) {

        let theme = MyThemes.current
        switch theme {
        case .light:
            print("light")
            sender.setTitle("夜间", for: .normal)
            MyThemes.switchTo(theme: .night)
        case .night:
            print("night")
            sender.setTitle("白天", for: .normal)
            MyThemes.switchTo(theme: .light)
        }
        
    }
    
    public class func getProfileHeaderCellHeight() -> CGFloat {
        return 80
    }


}
