//
//  KYTabBarC.swift
//  SmallVideo
//
//  Created by zky on 2017/8/24.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class KYTabBarC: UITabBarController {
    var _bgView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _bgView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        _bgView.backgroundColor = rgb(r: 20, g: 20, b: 20)
        tabBar.insertSubview(_bgView, at: 0)
        tabBar.isOpaque = true
        
        
        addchildVC(chileVC: VideoVC(), title: "视频", image: "video_tabbar_32x32_", selectedImage: "video_tabbar_press_32x32_")
        addchildVC(chileVC: PublicVideoVC(), title: "发布", image: "weitoutiao_tabbar_32x32_", selectedImage: "weitoutiao_tabbar_press_32x32_")
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
    
    
    //改变主题的通知
    func changeThemeNotificantion() {
    }
//
//
//            _bgView.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgColor"];
//
//            [self setTabBarItem:_fastNewsVC.tabBarItem Title:@"快讯" withTitleSize:13.0 selectedImage:[[ConfigurationTheme shareInstance] getThemeImageName:@"selectIcon-01_00.png"] withTitleColor:RGB(21, 95, 216, 1.0f)unselectedImage:[[ConfigurationTheme shareInstance] getThemeImageName:@"icon-01_00.png"] withTitleColor:RGB(108, 108, 108, 1.0f)];
//
//            [self setTabBarItem:_informationVC.tabBarItem Title:@"要闻" withTitleSize:13.0 selectedImage:[[ConfigurationTheme shareInstance] getThemeImageName:@"selectIcon-01_01.png"] withTitleColor:RGB(21, 95, 216, 1.0f)unselectedImage:[[ConfigurationTheme shareInstance] getThemeImageName:@"icon-01_01.png"] withTitleColor:RGB(108, 108, 108, 1.0f)];
//
//            [self setTabBarItem:_priceVC.tabBarItem Title:@"行情" withTitleSize:13.0 selectedImage:[[ConfigurationTheme shareInstance] getThemeImageName:@"selectIcon-01_02.png"] withTitleColor:RGB(21, 95, 216, 1.0f)unselectedImage:[[ConfigurationTheme shareInstance] getThemeImageName:@"icon-01_02.png"] withTitleColor:RGB(108, 108, 108, 1.0f)];
//
//            [self setTabBarItem:_dataVC.tabBarItem Title:@"日历" withTitleSize:13.0 selectedImage:[[ConfigurationTheme shareInstance] getThemeImageName:@"selectIcon-01_03.png"] withTitleColor:RGB(21, 95, 216, 1.0f)unselectedImage:[[ConfigurationTheme shareInstance] getThemeImageName:@"icon-01_03.png"] withTitleColor:RGB(108, 108, 108, 1.0f)];
//
//            [self setTabBarItem:_settingVC.tabBarItem Title:@"我" withTitleSize:13.0 selectedImage:[[ConfigurationTheme shareInstance] getThemeImageName:@"selectIcon-01_04.png"] withTitleColor:RGB(21, 95, 216, 1.0f)unselectedImage:[[ConfigurationTheme shareInstance] getThemeImageName:@"icon-01_04.png"] withTitleColor:RGB(108, 108, 108, 1.0f)];
//
//        }
//
//        - (void)setTabBarItem:(UITabBarItem *)tabbarItem
//        Title:(NSString *)title
//        withTitleSize:(CGFloat)size
//        selectedImage:(UIImage *)selectedImage
//        withTitleColor:(UIColor *)selectColor
//        unselectedImage:(UIImage *)unselectedImage
//        withTitleColor:(UIColor *)unselectColor{
//
//        //设置图片
//        tabbarItem = [tabbarItem initWithTitle:title image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//
//        //未选中字体颜色
//        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont systemFontOfSize:size]} forState:UIControlStateNormal];
//
//        //选中字体颜色
//        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont systemFontOfSize:size]} forState:UIControlStateSelected];
//        }
//
//
        
        

}
