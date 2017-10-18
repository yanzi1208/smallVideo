//
//  VideoCategoryCell.swift
//  SmallVideo
//
//  Created by zky on 2017/8/31.
//  Copyright © 2017年 zky. All rights reserved.
//

import UIKit


@objc protocol VideoCategoryCellDelegate {
    @objc optional func touchedPlayImageButton(cell : VideoCategoryCell, cellIndex : Int)
}


class VideoCategoryCell: UITableViewCell {
    
    weak var delegate : VideoCategoryCellDelegate?
    var  cellIndex : Int = 0
    
    /// 预览图
    var bgImageView = UIImageView()
    /// 标题 label
    var titleLabel = UILabel()
    /// 播放数量
    var playCountLabel = UILabel()
    /// 时间 label
    var timeLabel = UILabel()
    /// 背景图片
    open var playImageButton = UIButton()
    /// 用户头像
    var headButton = UIButton()
    /// 用户昵称
    var nameLable = UILabel()
    /// 评论数量
    var collectButton = UIButton()
    
    var listModel = VideoListModel() {
        didSet {
            titleLabel.text = listModel.title
            nameLable.text = listModel.userName
            timeLabel.text = listModel.size
            playCountLabel.text = "\(listModel.points) 次播放"
            let imgUrl = URL(string: listModel.imageUrl!)
            bgImageView.kf.setImage(with: imgUrl, placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { receivedSize, totalSize in
                print("\(receivedSize)/\(totalSize)")
            }, completionHandler: { image, error, cacheType, imageURL in
                print(" Finished")
            })
            let headUrl = URL(string: listModel.logo!)
            headButton.kf.setBackgroundImage(with: headUrl, for: .normal)
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
    
    var headTouched:(()->())?
    var collectTouched:(()->())?
    var moreTouched:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.layer.masksToBounds = true
        contentView.addSubview(bgImageView)
        
        titleLabel.text = "美女搞笑视频集锦,逗死我了,你能忍住不笑算你厉害"
        titleLabel.font = fontSize(16)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 2
        contentView.addSubview(titleLabel)
        
        playCountLabel.text = "8次播放"
        playCountLabel.font = fontSize(10)
        playCountLabel.textColor = UIColor.white
        contentView.addSubview(playCountLabel)
        
        timeLabel.text = "2M"
        timeLabel.font = fontSize(10)
        timeLabel.backgroundColor = rgb(50, 50, 50)
        timeLabel.textAlignment = .center
        timeLabel.textColor = UIColor.white
        timeLabel.layer.cornerRadius = 10
        timeLabel.layer.masksToBounds = true
        contentView.addSubview(timeLabel)
        
        playImageButton.setImage(imageNamed("new_play_video_44x44_"), for: .normal)
        playImageButton.setBackgroundImage(imageWithColor(rgba(100, 100, 100, 0.3)), for: .normal)
        playImageButton.addTarget(self, action: #selector(playImageButtonTouched), for: .touchUpInside)
        contentView.addSubview(playImageButton)
        
        let bottomBgView = UIView()
        bottomBgView.backgroundColor = UIColor.white
        contentView.addSubview(bottomBgView);
        
        headButton.setBackgroundImage(imageWithColor(UIColor.gray), for: .normal)
        headButton.layer.cornerRadius = 15
        headButton.layer.masksToBounds = true
        headButton.addTarget(self, action: #selector(headButtonTouched), for: .touchUpInside)
        contentView.addSubview(headButton)
        
        nameLable.text = "盛盛爱动漫"
        nameLable.font = fontSize(12)
        contentView.addSubview(nameLable)
        
        collectButton.setTitle("收藏", for: .normal)
        collectButton.setImage(imageNamed("maintab_collect"), for: .normal)
        collectButton.setImage(imageNamed("maintab_collect_selected"), for: .selected)
        collectButton.setTitleColor(UIColor.black, for: .normal)
        collectButton.titleLabel?.font = fontSize(12)
        collectButton.addTarget(self, action: #selector(collectButtonTouched), for: .touchUpInside)
        contentView.addSubview(collectButton)
        
        let moreButton = UIButton()
        moreButton.setImage(imageNamed("More_24x24_"), for: .normal)
        moreButton.addTarget(self, action: #selector(moreButtonTouched), for: .touchUpInside)
        contentView.addSubview(moreButton)
        
        let margin = 8
        
        bgImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(contentView)
            make.height.equalTo(180*KScaleY)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-30)
            make.height.equalTo(40)
        }
        
        playCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(margin)
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(20)
        }
        
        playImageButton.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(bgImageView)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-18)
            make.bottom.equalTo(playImageButton.snp.bottom).offset(-10)
            make.width.greaterThanOrEqualTo(40)
            make.height.equalTo(20)
        }
        
        headButton.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(playImageButton.snp.bottom).offset(margin)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-margin)
            make.centerY.equalTo(headButton)
            make.height.width.equalTo(headButton)
        }
        
        collectButton.snp.makeConstraints { (make) in
            make.right.equalTo(moreButton.snp.left)
            make.centerY.equalTo(headButton)
            make.height.equalTo(headButton)
            make.width.lessThanOrEqualTo(60)
        }
        

        nameLable.snp.makeConstraints { (make) in
            make.left.equalTo(headButton.snp.right).offset(margin)
            make.right.equalTo(collectButton.snp.left).offset(-margin)
            make.centerY.equalTo(headButton)
            make.height.equalTo(headButton)
        }
        
        
    }
    
    class func getVideoCategoryCellHeight() -> CGFloat {
        return 180*KScaleY+45
    }
    
    @objc func playImageButtonTouched() {
        delegate?.touchedPlayImageButton!(cell: self, cellIndex : cellIndex)
    }
    
    @objc func headButtonTouched() {
        self.headTouched?()
//        print("点击了头像")
    }
    
    @objc func collectButtonTouched() {
        collectButton.isSelected = !collectButton.isSelected
        
      
        
        let url = "collect?id&deviceId=\(listModel.deviceId)&userName=\(listModel.userName!)&title=\(listModel.title!)&url1=\(listModel.url1!)&url2=\(listModel.url2!)"
        HttpTools.requestData(.get, URLString: url) { (result) in
            
            print("\nhahah\n\(result)")
        }
    }
    
    @objc func moreButtonTouched() {
        self.moreTouched?()
//        print("点击了更多")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
