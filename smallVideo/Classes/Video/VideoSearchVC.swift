//
//  VideoSearchVC.swift
//  smallVideo
//
//  Created by zky on 2017/12/18.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class VideoSearchVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchBar = UISearchBar.init(frame: CGRect(x: 10, y: 20, width: SCREEN_WIDTH-20, height: 40))
        searchBar.backgroundColor = UIColor.clear
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        
//        for subView : UIView in searchBar.subviews {
//            if subView.isKind(of: UIView.self) {
//                subView.subviews.first?.removeFromSuperview()
//                if (subView.subviews.first?.isKind(of: UITextField.self))! {
//                    let textField  = subView.subviews.first as! UITextField
////                    textField.setBackgroundColor = rgb
//
//
//                }
//            }
//        }
        
        
        
//        for (UIView *subView in searchBar.subviews) {
//            if ([subView isKindOfClass:[UIView  class]]) {
//                [[subView.subviews objectAtIndex:0] removeFromSuperview];
//                if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
//                    UITextField *textField = [subView.subviews objectAtIndex:0];
//                    textField.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
//
//                    //设置输入框边框的颜色
//                    //                    textField.layer.borderColor = [UIColor blackColor].CGColor;
//                    //                    textField.layer.borderWidth = 1;
//
//                    //设置输入字体颜色
//                    //                    textField.textColor = [UIColor lightGrayColor];
//
//                    //设置默认文字颜色
//                    UIColor *color = [UIColor grayColor];
//                    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"搜索感兴趣的内容"
//                        attributes:@{NSForegroundColorAttributeName:color}]];
//                    //修改默认的放大镜图片
//                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
//                    imageView.backgroundColor = [UIColor clearColor];
//                    imageView.image = [UIImage imageNamed:@"gww_search_ misplaces"];
//                    textField.leftView = imageView;
//                }
//            }
//        }
        
        view.addSubview(searchBar)
    }

//    http://127.0.0.1/cms-web/queryByTag?tag=chaoren&offset=0&jsonCallBack=111&deviceId=11122
    func loadDataArr(_ category : String, _ index : Int) {
//        
//        HttpTools.requestData(.get, URLString: "queryPdList?type=\(index)&deviceId=1&offset=0") { (result) in
//            print("\(category)--\(result)")
//            self.dataArr = VideoListModel.toVidelListModel(dataArr: result as! NSArray) as NSArray
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension VideoSearchVC: UISearchBarDelegate {
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked" + searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange" + searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked" + searchBar.text!)
    }
}
