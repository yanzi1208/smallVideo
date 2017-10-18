//
//  KYTabBarC.swift
//  SmallVideo
//
//  Created by zky on 2017/8/24.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class KYTabBarC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addchildVC(chileVC: VideoVC(), title: "视频", image: "video_tabbar_32x32_", selectedImage: "video_tabbar_press_32x32_")
//        addchildVC(chileVC: FollowVC(), title: "关注", image: "weitoutiao_tabbar_32x32_", selectedImage: "weitoutiao_tabbar_press_32x32_")
        addchildVC(chileVC: ProfileVC(), title: "未登录", image: "no_login_tabbar_32x32_", selectedImage: "no_login_tabbar_press_32x32_")
        
//        tabBar.tintColor = UIColor.black
//        UITabBarItem .appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.purple], for: .normal)
//        UITabBarItem .appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.black], for: .selected)
        
    }
    
    
    func addchildVC(chileVC : UIViewController, title : String, image : String, selectedImage : String) {
        chileVC.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        chileVC.tabBarItem.selectedImage = UIImage(named: selectedImage)
        chileVC.tabBarItem.title = title
        chileVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2)
        
        let nav = KYNavC.init(rootViewController: chileVC)
        addChildViewController(nav)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
