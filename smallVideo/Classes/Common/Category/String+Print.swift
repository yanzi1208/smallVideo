//
//  String+Print.swift
//  smallVideo
//
//  Created by zky on 2017/9/12.
//  Copyright © 2017年 zky. All rights reserved.
//

import Foundation

extension String {
    var unicodeStr : String {
        let tempStr1 = self.replacingOccurrencesOfString(target: "\\u", withString: "\\U")
        let tempStr2 = tempStr1.replacingOccurrencesOfString(target: "\"", withString: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: String.Encoding.utf8)
        var returnStr:String = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: .mutableContainers, format: nil) as! String
        } catch {
            print(error)
        }
        return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
}
