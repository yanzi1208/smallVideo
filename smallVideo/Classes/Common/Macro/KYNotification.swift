//
//  KYNotification.swift
//  smallVideo
//
//  Created by zky on 2017/9/11.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

    let KYNotification = KYNotificationString.shared
open class KYNotificationString: NSObject {
    open static let shared = KYNotificationString()
    
    open let playerPortrait : String = "screenPortrait"
    open let playerLeft: String = "screenLandscapeLeft"
    open let playerRight: String = "screenLandscapeRight"
    
    
}
