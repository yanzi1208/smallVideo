//
//  UUID_Untils.swift
//  smallVideo
//
//  Created by zky on 2017/10/24.
//  Copyright © 2017年 zky. All rights reserved.
//

import Foundation
import Security
//// MARK: - 保存和读取UUID

//class func saveUUIDToKeyChain() {
//    var keychainItem = KeychainItemWrapper(account: "Identfier", service: "AppName", accessGroup: nil)
//    var string = (keychainItem[(kSecAttrGeneric as! Any)] as! String)
//    if (string == "") || !string {
//        keychainItem[(kSecAttrGeneric as! Any)] = self.getUUIDString()
//    }
//}

//class func readUUIDFromKeyChain() -> String {
//    var keychainItemm = KeychainItemWrapper(account: "Identfier", service: "AppName", accessGroup: nil)
//    var UUID = (keychainItemm[(kSecAttrGeneric as! Any)] as! String)
//    return UUID
//}
//
//class func getUUIDString() -> String {
//    var uuidRef = CFUUIDCreate(kCFAllocatorDefault)
//    var strRef = CFUUIDCreateString(kCFAllocatorDefault, uuidRef)
//    var uuidString = (strRef as! String).replacingOccurrencesOf("-", withString: "")
//    CFRelease(strRef)
//    CFRelease(uuidRef)
//    return uuidString
//}

