//
//  ProfileVC.swift
//  SmallVideo
//
//  Created by zky on 2017/8/24.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    var scrollView : UIScrollView!
    
    var tableView : UITableView!
    var headerBgView : UIImageView!
    var headerView : ProfileVCHeader!
    
    
    let headerHeight : CGFloat = 200
    let headerBgScale : CGFloat = (SCREEN_HEIGHT/200)
    
    static let headerID = "header"
    static let reusedID = "UITableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeTheme(notification:)), name:NSNotification.Name(rawValue : NotificationString.switchTheme.desc) , object: nil)
        
        headerBgView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: headerHeight+20))
        headerBgView.image = imageNamed("wallpaper_profile")
        view.addSubview(headerBgView)
        
        scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-20-49))
        scrollView.delegate = self
        scrollView.isScrollEnabled  = true
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64)
        view.addSubview(scrollView)
        
        headerView = ProfileVCHeader.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: headerHeight))
        scrollView.addSubview(headerView)
        
        let bgView = ProfileHeaderCell.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: ProfileHeaderCell.getProfileHeaderCellHeight()))
        bgView.backgroundColor = rgb(r:229, g:229, b:229)
        bgView.collectButtonBlock = {
            self.navigationController?.pushViewController(CollectVC(), animated: true)
        }
        
        tableView = UITableView.init(frame: CGRect(x: 0, y: headerHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.tableHeaderView = bgView
        tableView.tableFooterView = UIView()
        scrollView.addSubview(tableView)
        
    }
    
    @objc func changeTheme(notification : NSNotification) {
//
//        let userInfo = notification.userInfo as NSDictionary?
//        if let currenttheme = userInfo?.object(forKey:  constString.themeType.desc()) as? ThemeType {
//            switch currenttheme {
//            case .light:
//                tableView.backgroundColor = UIColor.white
//            case .black:
//                tableView.backgroundColor = rgb(r: 50, g: 50, b: 50)
//
//            }
//        }else {
//            print(notification)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: ProfileVC.reusedID)
        if indexPath.row == 0 {
            cell.textLabel?.text = "消息通知"
        }else if indexPath.row == 1 {
            cell.textLabel?.text = "离线"
        }else if indexPath.row == 2 {
            cell.textLabel?.text = "活动"
        }else if indexPath.row == 3 {
            cell.textLabel?.text = "我要反馈"
        }else if indexPath.row == 4 {
            cell.textLabel?.text = "系统设置"
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            // 消息通知
            
        }else if indexPath.row == 1 {
            // 离线
            
        }else if indexPath.row == 2 {
            // 活动
            
        }else if indexPath.row == 3 {
            // 我要反馈
            navigationController!.present(FeedbackVC(), animated: true, completion: nil)
            
        }else if indexPath.row == 4 {
            // 系统设置
            navigationController?.pushViewController(SettingVC(), animated: true)
//            navigationController!.present(FeedbackVC(), animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 44
    }
//    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.1
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//         return 100
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if section == 0 {
//            let bgView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
//            bgView.backgroundColor = rgb(229, 229, 229)
//            return bgView
//        }
//        return nil
//    }
//
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y;
        if offsetY < 0  {
            let headerBgWidth = (headerHeight-offsetY)*headerBgScale
            headerBgView.frame = CGRect(x: -(headerBgWidth-SCREEN_WIDTH)/2, y: 0, width: headerBgWidth, height: headerHeight-offsetY+20)
            
        }else if offsetY > 0  {
            headerBgView.frameY = -offsetY
        }
        
    }
    
}
