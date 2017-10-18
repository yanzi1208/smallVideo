//
//  HttpTools.swift
//  SmallVideo
//
//  Created by zky on 2017/8/29.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

enum MethodType {
    case get
    case post
}

class HttpTools {
    /// 创建单例
    static let shareInstance : HttpTools = {
        let tools = HttpTools()
        
        return tools
    }()


    
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        let URL = "http://116.62.133.195:8081/cms-web/\(URLString)" as String
        // 2.发送网络请求
        request(URL, method: method, parameters: parameters).responseJSON { (response) in
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }

}
