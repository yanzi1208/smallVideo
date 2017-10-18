//
//  FeedbackVC.swift
//  smallVideo
//
//  Created by zky on 2017/9/21.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit

class FeedbackVC: BaseVC, KYTitleBarDelegate {

    lazy var titleBar : KYTitleBar = {
        let tTitleBar = KYTitleBar.init(leftType: .back, rightType: .custom, titleString: "意见反馈")
        tTitleBar.delegate = self
        tTitleBar.rightButton?.setTitle("发送", for: .normal)
        tTitleBar.rightButton?.setTitleColor(UIColor.black, for: .normal)
        return tTitleBar
    }()
    
    lazy var textView : UITextView = {
        let tTextView = UITextView.init(frame: CGRect(x: 10, y: 74, width: SCREEN_WIDTH-20, height: 200))
        tTextView.layer.cornerRadius = 3
        tTextView.layer.masksToBounds = true
        tTextView.layer.borderWidth = 1
        tTextView.layer.borderColor = rgb(180, 180, 180).cgColor
        return tTextView;
    
    }()
    lazy var textFiled : UITextField = {
        let tTextFiled = UITextField.init(frame: CGRect(x: 10, y: Int(self.textView.frameMaxY+15), width: Int(SCREEN_WIDTH-20), height: 30))
        tTextFiled.layer.cornerRadius = 3
        tTextFiled.layer.masksToBounds = true
        tTextFiled.layer.borderWidth = 1
        tTextFiled.placeholder = "QQ、邮件或者电话..."
        tTextFiled.layer.borderColor = rgb(180, 180, 180).cgColor
        return tTextFiled
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
  
        view.addSubview(titleBar)
        view.addSubview(textView)
        view.addSubview(textFiled)
        
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapBgview)))
    }
    
    @objc func tapBgview() {
        textView.resignFirstResponder()
        textFiled.resignFirstResponder()
    }
    func leftButtonTouched() {
       dismiss(animated: true, completion: nil)
    }
    
    func rightButtonTouched() {
        print("点击发送按钮")
        leftButtonTouched()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
