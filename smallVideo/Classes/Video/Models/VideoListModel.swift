//
//  VideoListModel.swift
//  SmallVideo
//
//  Created by zky on 2017/8/29.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class VideoListModel : Reflect   {

    var createTime : NSNumber = NSNumber(value: 0)
    var deviceId : NSNumber = NSNumber(value: 0)
    var videoId : NSNumber = NSNumber(value: 0)
    var imageUrl : String?
    var logo : String?
    var points : NSNumber = NSNumber(value: 0)
    var size : String?
    var tag : String?
    var title : String?
    var type : NSNumber = NSNumber(value: 0)
    var updateTime : NSNumber = NSNumber(value: 0)
    var url1 : String?
    var url2 : String?
    var userId : NSNumber = NSNumber(value: 0)
    var userName : String?
    
    class func toVidelListModel(dataArr: NSArray) -> [VideoListModel] {
        let model = VideoListModel.parses(arr: dataArr as NSArray)
        return model as! [VideoListModel]
    }

    override func mappingDict() -> [String : String]? {
        return ["videoId": "id"]
    }
}

/*
 createTime = "<null>";
 deviceId = 1;
 id = 15;
 imageUrl = "http://p9.pstatp.com/list/190x124/386400133b59aca2a834";
 logo = "http://baidu.com";
 points = 0;
 size = 5M;
 tag = "\U5e9e\U8d1d\U53e4\U57ce,\U80d6\U5973\U4eba,\U7f57\U9a6c\U6d74\U573a,\U9a6c\U672a\U90fd,\U6b27\U6d32";
 title = "\U9a6c\U672a\U90fd\Uff1a\U4e00\U591c\U4e4b\U95f4\U6d88\U5931\U7684\U5e9e\U8d1d\U53e4\U57ce\U4e0e\U90a3\U4e9b\U80a5\U7f8e\U767d\U7684\U6b27\U6d32\U80d6\U5973\U4eba";
 type = 1;
 updateTime = 1504867210000;
 url1 = "http://zhidao-video.oss-cn-hangzhou.aliyuncs.com/361e7671-9207-11e7-9b86-5ce0c55b1363.mp4";
 url2 = "<null>";
 userId = 1;
 userName = "\U54c8\U5229\U6ce2\U7279";


 */
