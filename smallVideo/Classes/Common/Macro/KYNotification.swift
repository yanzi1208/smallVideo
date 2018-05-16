//
//  KYNotification.swift
//  smallVideo
//
//  Created by zky on 2017/9/11.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

// 通知
enum NotificationString {
    case playerPortrait, playerLeft, playerRight
    case switchTheme
    
    var desc : String {
        switch self {
            
        // 播放器方向通知
        case .playerPortrait: return "screenPortrait"
        case .playerLeft: return "screenLandscapeLeft"
        case .playerRight: return "screenLandscapeRight"
            
        //换肤通知
        case .switchTheme: return "switchTheme"
        }
    }
}

// 字符串
enum constString {
    case themeType
    
    func desc() -> String {
        switch self {
        case .themeType: return "themeType"
            
        }
    }
    
}
