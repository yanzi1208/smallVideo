//
//  HttpTool.swift
//  smallVideo
//
//  Created by zky on 2017/12/20.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

enum MethodType {
    case get
    case post
}

typealias successBlock =  ( _ responseObject : AnyObject)->()
typealias failureBlock = ( _ error : NSError)->()

let BASE_URL = "http://116.62.133.195:80/cms-web/"

class HttpTool {
    
    /// 创建单例
    static let shareInstance : HttpTool = {
        let tool = HttpTool()
        
        return tool
    }()
    
    
    //    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
    //
    //        // 1.获取类型
    //        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
    //        let URL = "http://116.62.133.195:8081/cms-web/\(URLString)" as String
    //        // 2.发送网络请求
    //        request(URL, method: method, parameters: parameters).responseJSON { (response) in
    //            // 3.获取结果
    //            guard let result = response.result.value else {
    //                print(response.result.error!)
    //                return
    //            }
    //
    //            // 4.将结果回调出去
    //            finishedCallback(result)
    //        }
    //    }
    
}

//MARK: - 网络请求封装:
extension HttpTool {
    /// POST请求
   fileprivate func postRequest(urlString : String, params : [String : AnyObject], success :@escaping successBlock, failure : @escaping failureBlock) {
        request(urlString, method: .post, parameters: params).responseJSON { (response) in
            guard  response.result.isSuccess else {
                print(response.result.error! as NSError)
                failure(response.result.error! as NSError)
                return
            }

            success(response.result.value as AnyObject)
            print(response.result.value as AnyObject)
        }
        
    }
    
    /// GET请求
    fileprivate func getRequest(urlString : String, params : [String : AnyObject], success : @escaping successBlock, failure : @escaping failureBlock) {
        request(urlString, method: .get, parameters: params).responseJSON { (response) in
            guard  response.result.isSuccess else {
                print(response.result.error! as NSError)
                failure(response.result.error! as NSError)
                return
            }
            
            success(response.result.value as AnyObject)
            print(response.result.value as AnyObject)
        }
    
//upload(<#T##data: Data##Data#>, with: <#T##URLRequestConvertible#>)
    
    }
    
    
    
    
    
}

//MARK: - 网络请求:
extension HttpTool {
    
    /// 点击了收藏
    func request_collect(params : [String : AnyObject], success : @escaping successBlock, failure : @escaping failureBlock) {
        
        let deviceId = params["deviceId"] as! Int
        let userName = params["userName"] as! String
        let title = params["title"] as! String
        let url1 = params["url1"] as! String
        let url2 = params["url2"] as! String
        
        let url = BASE_URL + "collect?id&deviceId=\(deviceId)&userName=\(userName)&title=\(title)&url1=\(url1)&url2=\(url2)"
        getRequest(urlString: url, params: params, success: { (result) in
            success(result)
        }) { (error) in
            
        }
    }
    
    
    /// 视频页面数据列表
    func request_queryPdList(params : [String : AnyObject], success : @escaping successBlock, failure : @escaping failureBlock) {
        
        let index =  params["index"] as! Int
        let url = BASE_URL + "queryPdList?type=\(index)&deviceId=1&offset=0"
        getRequest(urlString: url, params: params, success: { (result) in
            success(result as! NSArray)
        }) { (error) in
            
        }
    }
   
    
    //    http://127.0.0.1/cms-web/queryByTag?tag=chaoren&offset=0&jsonCallBack=111&deviceId=11122
    /// 视频搜索 根据tag 查询视频列表
    func request_queryByTag(params : [String : AnyObject], success : @escaping successBlock, failure : @escaping failureBlock) {
        
        let tag = params["tag"] as! String
        let offset = params["offset"] as! Int
        let jsonCallBack = 111
        let deviceId = 11122
        
        let url = BASE_URL + "queryByTag?tag=\(tag)&offset=\(offset)&jsonCallBack=\(jsonCallBack)&deviceId=\(deviceId)"
        getRequest(urlString: url, params: params, success: { (result) in
            print(result)
//            success(result as! NSArray)
        }) { (error) in
            
        }
    }
    
    
//    http://127.0.0.1/cms-web/userRecord?app=ios(android)&deviceId=1111&detail=dfdsfdfdsfsfds
    /// 用户登记 post 提交数据
    func request_userRecord(params : [String : AnyObject], success : @escaping successBlock, failure : @escaping failureBlock) {
        
        let deviceId = 1111
        let detail = "dfdsfdfdsfsfds"
        let url = BASE_URL + "userRecord?app=ios&deviceId=\(deviceId)&detail=\(detail)"
        getRequest(urlString: url, params: params, success: { (result) in
            print(result)
            //            success(result as! NSArray)
        }) { (error) in
            
        }
    }
    
    
//    根据一个产品查询相关产品
//    http://127.0.0.1/cms-web/queryMore? productId=1111&offset=0&jsonCallBack=4343&deviceId=1111
    func request_queryMore(params : [String : AnyObject], success : @escaping successBlock, failure : @escaping failureBlock) {
        
        let productId = 1111
        let offset = 0
        let jsonCallBack = 4343
        let deviceId = 1111
        
        let url = BASE_URL + "queryMore?productId=\(productId)&offset=\(offset)&jsonCallBack=\(jsonCallBack)&deviceId=\(deviceId)"
        getRequest(urlString: url, params: params, success: { (result) in
            print(result)
            //            success(result as! NSArray)
        }) { (error) in
            
        }
    }


//    10、文件上传
//    http://127.0.0.1/cms-web/fileUpload?
//    参数
//    deviceId=1111&userId=2222&title=test&time=30.2&size=10,
//    @RequestParam("files") CommonsMultipartFile[] files

    func request_fileUpload(params : [String : AnyObject], success : @escaping successBlock, failure : @escaping failureBlock) {

//        let deviceId = 1111
//        let userId = 2222
//        let title = "test"
//        let time = 30.2
//        let size = 10
        
//        let url = BASE_URL + "queryMore?productId=\(productId)&offset=\(offset)&jsonCallBack=\(jsonCallBack)&deviceId=\(deviceId)"
//        let url = BASE_URL
        
    }
    
    func uploadVideo(mp4Path : URL){
        let url = BASE_URL + "fileUpload"
        upload(
            //同样采用post表单上传
            multipartFormData: { multipartFormData in
                multipartFormData.append(mp4Path, withName: "files", fileName: "123456.mp4", mimeType: "video/mp4")
                //服务器地址
        },to: url,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //json处理
                upload.responseJSON { response in
                    //解包
                    guard let result = response.result.value else { return }
                    print("json:\(result)")
                }
                //上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("视频上传进度: \(progress.fractionCompleted)")
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
        
    
//    private func upload(uploadImage: UIImage,address: String,scale: Double) {
//
//        upload(<#T##data: Data##Data#>, to: <#T##URLConvertible#>)
//
//        upload(.POST, address, multipartFormData: { (multipartFormData) in
//
//            let data = UIImageJPEGRepresentation(uploadImage, scale)
//            let imageName = String(NSDate()) + ".png"
//
//            //multipartFormData.appendBodyPart(data: ,name: ,fileName: ,mimeType: )这里把图片转为二进制,作为第一个参数
//            multipartFormData.appendBodyPart(data: data!, name: "file", fileName: imageName, mimeType: "image/png")
//
//            //把剩下的两个参数作为字典,利用 multipartFormData.appendBodyPart(data: name: )添加参数,
//            //因为这个方法的第一个参数接收的是NSData类型,所以要利用 NSUTF8StringEncoding 把字符串转为NSData
//            let param = ["phoneId" : HCUserModel.sharedInstance.phoneId!, "phoneType" : "1"]
//
//            //遍历字典
//            for (key, value) in param {
//                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
//            }
//
//        }) { (encodingResult) in
//            switch encodingResult {
//            case .Success(let upload, _, _):
//                upload.responseJSON(completionHandler: { (response) in
//                    if let myJson = response.result.value {
//
//                        if myJson as! NSObject == 0 {
//                            print("上传成功")
//                        }else {
//                            print("上传失败")
//                        }
//                    }
//                })
//            case .Failure(let error):
//                print(error)
//            }
//        }
//    }

    
    

    

}




