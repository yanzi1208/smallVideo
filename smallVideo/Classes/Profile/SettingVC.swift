//
//  SettingVC.swift
//  smallVideo
//
//  Created by zky on 2017/9/26.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class SettingVC: BaseVC, KYTitleBarDelegate, UITableViewDataSource, UITableViewDelegate {
    static let reusedId  = "UITableViewCell"
    
    lazy var titleBar : KYTitleBar = {
        let tTitleBar = KYTitleBar.init(leftType: .back, rightType: .custom, titleString: "设置")
        tTitleBar.delegate = self
        return tTitleBar
    }()
    
    lazy var tableView : UITableView = {
        let tTableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64), style: .plain)
        tTableView.delegate = self
        tTableView.dataSource = self
        return tTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(titleBar)
        view.addSubview(tableView)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: SettingVC.reusedId)
        if  cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: SettingVC.reusedId)
            if indexPath.row == 0 {
                cell?.textLabel?.text = "清理缓存"
                cell?.detailTextLabel?.text = "135.4K"
            }else if indexPath.row == 1 {
                cell?.textLabel?.text = "检查版本"
                cell?.detailTextLabel?.text = "1.0"
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func leftButtonTouched() {
        navigationController?.popViewController(animated: true)
    }
    


}
