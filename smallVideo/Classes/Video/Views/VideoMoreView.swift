//
//  VideoMoreView.swift
//  smallVideo
//
//  Created by zky on 2017/10/18.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class VideoMoreView: UIView {
    
    var collectButton: UIButton {
        let collect = UIButton()
        collect.setImage(imageNamed("maintab_collect"), for: .normal)
        collect.addTarget(self, action: #selector(colllectButtonTouched), for: .touchUpInside)
        return collect
    }
    
    var reportButton: UIButton {
        let report = UIButton()
        report.setImage(imageNamed("maintab_collect"), for: .normal)
        report.addTarget(self, action: #selector(colllectButtonTouched), for: .touchUpInside)
        return report
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(collectButton)
        addSubview(reportButton)
        
        collectButton.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(20)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        reportButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-20)
            make.top.equalTo(self).offset(20)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
    
    @objc func colllectButtonTouched() {
        
        
    }

}
