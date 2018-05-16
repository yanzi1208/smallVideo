//
//  PublicVideoCell.swift
//  smallVideo
//
//  Created by zky on 2018/1/21.
//  Copyright © 2018年 zky. All rights reserved.
//

import UIKit

class PublicVideoCell: UICollectionViewCell {
    open var videoImage  = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        videoImage.frame = self.contentView.bounds
        
        self.contentView.addSubview(videoImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
