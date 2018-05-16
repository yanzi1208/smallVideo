//
//  AppDelegate.swift
//  smallVideo
//
//  Created by zky on 2017/9/8.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var blockRotation: Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        redirectNSLogToDocumentFolder()
        
        MyThemes.switchTo(theme: .light)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = KYTabBarC()
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        // Setting a Keychain item value
//        let keychainItemWrapper = KeychainItemWrapper(identifier: "identifier for this item", accessGroup: "access group if shared")
//        keychainItemWrapper["superSecretKey"] = "aSuperSecretValue" as AnyObject?
   
        // Getting a Keychain item value
//        let keychainItemWrapper = KeychainItemWrapper(identifier: "identifier for this item", accessGroup: "access group if shared")
//        let superSecretValue = keychainItemWrapper["superSecretKey"] as? String?
//        print("The super secret value is: \(superSecretValue)")
       return true
    }

    func statusBarOrientationChangen(notification : NSNotification) {
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let device = NSData(data: deviceToken)
        let deviceId = device.description.replacingOccurrences(of:"<", with:"").replacingOccurrences(of:">", with:"").replacingOccurrences(of:" ", with:"")
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // 打印日志到沙盒,方便查看 打印是 控制台是不会输出的
    func redirectNSLogToDocumentFolder() {
        //如果已经连接Xcode调试则不输出到文件
        if (isatty(STDOUT_FILENO) != 0) {
            return;
        }
        
        //    //判定如果是模拟器就不输出
//            UIDevice *device = [UIDevice currentDevice];
//            if ([[device model]hasSuffix:@"Simulator"]) {
//                return;
//            }
        
        //将NSLog打印信息保存到Document目录下的Log文件夹下
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let logDirectory = (paths.firstObject as! NSString).appendingPathComponent("Log")
        let fileExists = FileManager.default.fileExists(atPath: logDirectory)
        
        if (fileExists == false) {
            do{
               try FileManager.default.createDirectory(atPath: logDirectory, withIntermediateDirectories: true, attributes: nil)
            }catch {
                print(error.localizedDescription)
            }
        }
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        //每次启动都保存一个新的日志文件中
        
        let dateStr = formatter.string(from: Date())
        let logFilePath = logDirectory.appendingFormat("/%@.log",dateStr)
        
        //将log文件输出到文件
        freopen(logFilePath.cString(using: String.Encoding.ascii), "a++", stdout)
        freopen(logFilePath.cString(using: String.Encoding.ascii), "a++", stderr)
        
        //捕获Object-C异常日志
        NSSetUncaughtExceptionHandler { (exception : NSException) in
                let name = exception.name
                let reason = exception.reason
                let symbols = exception.callStackSymbols
                
                //异常发生时的调用栈
                let strSymbols = NSMutableString()
                
                //将调用栈平成输出日志的字符串
                for str in symbols {
                    strSymbols.append(str)
                    strSymbols .append("\r\n")
                }
                
                //将crash日志保存到Document目录下的Log文件夹下
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
                let logDirectory = (paths.firstObject as! NSString).appendingPathComponent("Log") as NSString
                
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: logDirectory as String) == false {
                    
                    do{
                        try fileManager.createDirectory(atPath: logDirectory as String, withIntermediateDirectories: true, attributes: nil)
                    }catch {
                        print(error.localizedDescription)
                    }
                }
                
                let logFilePath = logDirectory.appendingPathComponent("UncaughtException.log")
                let formatter = DateFormatter()
                formatter.locale = Locale.init(identifier: "zh_CN")
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let dateStr = formatter.string(from: Date())
                let crashString = NSString.init(format: ",- %@ ->[Uncaught Exception]\r\nName:%@,Reason:%@\r\n[Fe Symbols Start]\r\n%@[Fe Symbols End]\r\n\r\n", dateStr,name as CVarArg,reason!,strSymbols)
                
                //把错误日志写到文件中
                if fileManager.fileExists(atPath: logFilePath) == false {
                    do{
                        try crashString.write(toFile: logFilePath, atomically: true, encoding: String.Encoding.utf8.rawValue)
                    }catch {
                        print(error.localizedDescription)
                    }
                }else {
                    let outFile = FileHandle.init(forWritingAtPath: logFilePath)
                    outFile?.seekToEndOfFile()
                    outFile?.write(crashString.data(using: String.Encoding.utf8.rawValue)!)
                    outFile?.closeFile()
                }
        }
    }
    
}


