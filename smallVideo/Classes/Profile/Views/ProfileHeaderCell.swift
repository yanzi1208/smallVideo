//
//  ProfileHeaderCell.swift
//  smallVideo
//
//  Created by zky on 2017/9/29.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public class func getProfileHeaderCellHeight() -> CGFloat {
        return 100
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
