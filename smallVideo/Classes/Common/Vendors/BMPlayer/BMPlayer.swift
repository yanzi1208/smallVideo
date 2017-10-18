//
//  BMPlayer.swift
//  Pods
//
//  Created by BrikerMan on 16/4/28.
//
//

import UIKit

import MediaPlayer

/// BMPlayerDelegate to obserbe player state
public protocol BMPlayerDelegate : class {
    func bmPlayer(player: BMPlayer ,playerStateDidChange state: BMPlayerState)
    func bmPlayer(player: BMPlayer ,loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval)
    func bmPlayer(player: BMPlayer ,playTimeDidChange currentTime : TimeInterval, totalTime: TimeInterval)
    func bmPlayer(player: BMPlayer ,playerIsPlaying playing: Bool)
}

/**
 internal enum to check the pan direction
 
 - horizontal: horizontal
 - vertical:   vertical
 */
enum BMPanDirection: Int {
    case horizontal = 0
    case vertical   = 1
}

open class BMPlayer: UIView {
    open static let shared = BMPlayer()
    open weak var delegate: BMPlayerDelegate?
    open var backBlock:((Bool) -> Void)?
    
    lazy var statusBar : UIView = {
        return (UIApplication.shared.value(forKey: "statusBarWindow") as! NSObject).value(forKey: "statusBar")
        }() as! UIView
    
    /// Gesture to change volume / brightness
    open var panGesture: UIPanGestureRecognizer!
    
    /// AVLayerVideoGravityType
    open var videoGravity = AVLayerVideoGravityResizeAspect {
        didSet {
            self.playerLayer?.videoGravity = videoGravity
        }
    }
    
    open var isPlaying: Bool {
        get {
            return playerLayer?.isPlaying ?? false
        }
    }
    
    //Closure fired when play time changed
    open var playTimeDidChange:((TimeInterval, TimeInterval) -> Void)?
    
    //Closure fired when play state chaged
    open var playStateDidChange:((Bool) -> Void)?
    
    open var avPlayer: AVPlayer? {
        return playerLayer?.player
    }
    
    open var playerLayer: BMPlayerLayerView?
    fileprivate var resource: BMPlayerResource!
    fileprivate var currentDefinition = 0
    fileprivate var controlView: BMPlayerControlView!
    fileprivate var isFullScreen:Bool = false
    fileprivate var lastSuperview: UIView?
    fileprivate var lastFrame : CGRect?
    fileprivate var isLandscape : Bool = false
    fileprivate var isUserTapMaxButton : Bool = false
    fileprivate var fullStatusBarHidden : Bool = true
    fileprivate var rotateView : UIView?
    
    /// 滑动方向
    fileprivate var panDirection = BMPanDirection.horizontal
    /// 音量滑竿
    fileprivate var volumeViewSlider: UISlider!
    
    fileprivate let BMPlayerAnimationTimeInterval:Double                = 4.0
    fileprivate let BMPlayerControlBarAutoFadeOutTimeInterval:Double    = 0.5
    
    /// 用来保存时间状态
    fileprivate var sumTime         : TimeInterval = 0
    fileprivate var totalDuration   : TimeInterval = 0
    fileprivate var currentPosition : TimeInterval = 0
    fileprivate var shouldSeekTo    : TimeInterval = 0
    
    fileprivate var isURLSet        = false
    fileprivate var isSliderSliding = false
    fileprivate var isPauseByUser   = false
    fileprivate var isVolume        = false
    fileprivate var isMaskShowing   = false
    fileprivate var isSlowed        = false
    fileprivate var isMirrored      = false
    fileprivate var isPlayToTheEnd  = false
    //视频画面比例
    fileprivate var aspectRatio:BMPlayerAspectRatio = .default
    
    //Cache is playing result to improve callback performance
    fileprivate var isPlayingCache: Bool? = nil
    
    // MARK: - Public functions
    
    /**
     Play
     
     - parameter resource:        media resource
     - parameter definitionIndex: starting definition index, default start with the first definition
     */
    open func setVideo(resource: BMPlayerResource, definitionIndex: Int = 0) {
        isURLSet = false
        self.resource = resource
        
        currentDefinition           = definitionIndex
        controlView.prepareUI(for: resource, selectedIndex: definitionIndex)
        
        if BMPlayerConf.shouldAutoPlay {
            isURLSet = true
            let asset = resource.definitions[definitionIndex]
            playerLayer?.playAsset(asset: asset.avURLAsset)
        } else {
            controlView.showCover(url: resource.cover)
            controlView.hideLoader()
        }
    }
    
    /**
     auto start playing, call at viewWillAppear, See more at pause
     */
    open func autoPlay() {
        if !isPauseByUser && isURLSet && !isPlayToTheEnd {
            play()
        }
    }
    
    /**
     Play
     */
    open func play() {
        if resource == nil {
            return
        }
        if !isURLSet {
            let asset = resource.definitions[currentDefinition]
            playerLayer?.playAsset(asset: asset.avURLAsset)
            controlView.hideCoverImageView()
            isURLSet                = true
        }
        
        panGesture.isEnabled = true
        playerLayer?.play()
        isPauseByUser = false
    }
    
    /**
     Pause
     
     - parameter allow: should allow to response `autoPlay` function
     */
    open func pause(allowAutoPlay allow: Bool = false) {
        playerLayer?.pause()
        isPauseByUser = !allow
    }
    
    /**
     seek
     
     - parameter to: target time
     */
    open func seek(_ to:TimeInterval, completion: (()->Void)? = nil) {
        playerLayer?.seek(to: to, completion: completion)
    }
    
    /**
     update UI to fullScreen
     */
    open func updateUI(_ isFullScreen: Bool) {
        controlView.updateUI(isFullScreen)
    }
    
    /**
     increade volume with step, default step 0.1
     
     - parameter step: step
     */
    open func addVolume(step: Float = 0.1) {
        self.volumeViewSlider.value += step
    }
    
    /**
     decreace volume with step, default step 0.1
     
     - parameter step: step
     */
    open func reduceVolume(step: Float = 0.1) {
        self.volumeViewSlider.value -= step
    }
    
    /**
     prepare to dealloc player, call at View or Controllers deinit funciton.
     */
    open func prepareToDealloc() {
        playerLayer?.prepareToDeinit()
        controlView.prepareToDealloc()
        
    }
    
    // MARK: - Action Response
    
    @objc fileprivate func panDirection(_ pan: UIPanGestureRecognizer) {
        // 根据在view上Pan的位置，确定是调音量还是亮度
        let locationPoint = pan.location(in: self)
        
        // 我们要响应水平移动和垂直移动
        // 根据上次和本次移动的位置，算出一个速率的point
        let velocityPoint = pan.velocity(in: self)
        
        // 判断是垂直移动还是水平移动
        switch pan.state {
        case UIGestureRecognizerState.began:
            // 使用绝对值来判断移动的方向
            let x = fabs(velocityPoint.x)
            let y = fabs(velocityPoint.y)
            
            if x > y {
                self.panDirection = BMPanDirection.horizontal
                
                // 给sumTime初值
                if let player = playerLayer?.player {
                    let time = player.currentTime()
                    self.sumTime = TimeInterval(time.value) / TimeInterval(time.timescale)
                }
                
            } else {
                self.panDirection = BMPanDirection.vertical
                if locationPoint.x > self.bounds.size.width / 2 {
                    self.isVolume = true
                } else {
                    self.isVolume = false
                }
            }
            
        case UIGestureRecognizerState.changed:
            switch self.panDirection {
            case BMPanDirection.horizontal:
                self.horizontalMoved(velocityPoint.x)
            case BMPanDirection.vertical:
                self.verticalMoved(velocityPoint.y)
            }
            
        case UIGestureRecognizerState.ended:
            // 移动结束也需要判断垂直或者平移
            // 比如水平移动结束时，要快进到指定位置，如果这里没有判断，当我们调节音量完之后，会出现屏幕跳动的bug
            switch (self.panDirection) {
            case BMPanDirection.horizontal:
                controlView.hideSeekToView()
                isSliderSliding = false
                if isPlayToTheEnd {
                    isPlayToTheEnd = false
                    seek(self.sumTime, completion: {
                        self.play()
                    })
                } else {
                    seek(self.sumTime, completion: {
                        self.autoPlay()
                    })
                }
                // 把sumTime滞空，不然会越加越多
                self.sumTime = 0.0
                
            case BMPanDirection.vertical:
                self.isVolume = false
            }
        default:
            break
        }
    }
    
    fileprivate func verticalMoved(_ value: CGFloat) {
        self.isVolume ? (self.volumeViewSlider.value -= Float(value / 10000)) : (UIScreen.main.brightness -= value / 10000)
    }
    
    fileprivate func horizontalMoved(_ value: CGFloat) {
        isSliderSliding = true
        if let playerItem = playerLayer?.playerItem {
            // 每次滑动需要叠加时间，通过一定的比例，使滑动一直处于统一水平
            self.sumTime = self.sumTime + TimeInterval(value) / 100.0 * (TimeInterval(self.totalDuration)/400)
            
            let totalTime       = playerItem.duration
            
            // 防止出现NAN
            if totalTime.timescale == 0 { return }
            
            let totalDuration   = TimeInterval(totalTime.value) / TimeInterval(totalTime.timescale)
            if (sumTime >= totalDuration) { sumTime = totalDuration}
            if (sumTime <= 0){ sumTime = 0}
            
            controlView.showSeekToView(to: sumTime, total: totalDuration, isAdd: value > 0)
        }
    }

    
    @objc fileprivate func fullScreenButtonPressed() {
     
        if isFullScreen == false {
            isUserTapMaxButton = true
            fullScreenWith(Direction: .landscapeLeft)
        }else {
            originalscreen()
        }
    }
    
    //  全屏
    func fullScreenWith(Direction direction: UIInterfaceOrientation){
    
        lastSuperview = superview
        lastFrame = frame
        isFullScreen = true
        statusBarHiddeen(hidden: true)
        
        let keyWindow = UIApplication.shared.keyWindow
        rotateView = UIView.init(frame: (keyWindow?.bounds)!)
        keyWindow?.addSubview(rotateView!)
        rotateView!.addSubview(self)
        self.center = CGPoint(x: SCREEN_WIDTH/2.0, y: SCREEN_HEIGHT/2.0)
        
        if isLandscape == true {
            if isUserTapMaxButton {
                UIDevice.current.setValue(NSNumber.init(value: UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
                UIApplication.shared.setStatusBarHidden(false, with: .fade)
            } else {
                UIDevice.current.setValue(NSNumber.init(value: UIInterfaceOrientation.landscapeRight.rawValue), forKey: "orientation")
                UIApplication.shared.setStatusBarHidden(false, with: .fade)
            }
            if rotateView!.frame.size.width < rotateView!.frame.size.height {
                frame = CGRect(x: 0, y: 0, width: SCREEN_HEIGHT, height: SCREEN_WIDTH)
            }else {
                frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
            }
        }else {
            //播放器所在控制器不支持旋转，采用旋转view的方式实现
            if direction == .landscapeLeft {
                UIView.animate(withDuration: 0.25, animations: { 
                    self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.5));
                })
                UIApplication.shared.setStatusBarOrientation(.landscapeRight, animated: false)
            }else if direction == .landscapeRight {
                UIView.animate(withDuration: 0.25, animations: { 
                    self.transform = CGAffineTransform( rotationAngle: CGFloat(-Double.pi * 0.5));
                })
                UIApplication.shared.setStatusBarOrientation(.landscapeLeft, animated: false)
            }
            frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }
        controlView.updateUI(isFullScreen)
        self.backgroundColor = UIColor.black
        layoutIfNeeded()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = self.bounds
        controlView?.frame = self.bounds
        
        print("self.frame\(self.frame),self.bounds\(self.bounds), playerLayer\(String(describing: playerLayer?.frame)), controlView\(controlView.frame)")
    }
    
    // 原始大小
    func originalscreen() {
        isFullScreen = false
        isUserTapMaxButton = false
        UIApplication.shared.setStatusBarOrientation(.portrait, animated: false)
        statusBarHiddeen(hidden: false)
        rotateView?.removeFromSuperview()
        rotateView = nil
        if isLandscape == true {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }else {
            UIView.animate(withDuration: 0.25, animations: { 
                self.transform = CGAffineTransform(rotationAngle: CGFloat(0))
            })
        }
        frame = lastFrame!
        lastSuperview?.addSubview(self)
        updateUI(isFullScreen)
    }
    
    func statusBarHiddeen(hidden : Bool) {
        statusBar.isHidden = hidden
    }
    
    
    
    // MARK: - 生命周期
    deinit {
        playerLayer?.pause()
        playerLayer?.prepareToDeinit()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        

    }
//    
//    @available(*, deprecated:3.0, message:"Use newer init(customControlView:_)")
//    public convenience init(customControllView: BMPlayerControlView?) {
//        self.init(customControlView: customControllView)
//    }
//    
//    public convenience init() {
//        self.init(customControlView:nil)
//    }
//    
//    public init(customControlView: BMPlayerControlView?) {
//        super.init(frame:CGRect.zero)
//        self.customControlView = customControlView
//
//    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        configureVolume()
        preparePlayer()
    }
    
    // MARK: - 初始化
    fileprivate func initUI() {
        self.backgroundColor = UIColor.black
        controlView =  BMPlayerControlView()
        
        addSubview(controlView)
        controlView.updateUI(isFullScreen)
        controlView.delegate = self
        controlView.player   = self
        controlView.frame = bounds
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panDirection(_:)))
        self.addGestureRecognizer(panGesture)
        
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        //注册屏幕旋转通知
        NotificationCenter.default.addObserver(self, selector: #selector(orientChange(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: UIDevice.current)

        // statusBar 旋转
//        NotificationCenter.default.addObserver(self, selector: #selector(onOrientationChanged), name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
        
        //APP运行状态通知，将要被挂起
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground(notification:)), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        // app进入前台
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterPlayground(notification:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    fileprivate func configureVolume() {
        let volumeView = MPVolumeView()
        for view in volumeView.subviews {
            if let slider = view as? UISlider {
                self.volumeViewSlider = slider
            }
        }
    }
    
    fileprivate func preparePlayer() {
        playerLayer = BMPlayerLayerView()
        playerLayer!.videoGravity = videoGravity
        insertSubview(playerLayer!, at: 0)
        playerLayer?.frame = bounds
        playerLayer!.delegate = self
        controlView.showLoader()
        self.layoutIfNeeded()
    }
    
    

}

// MARK: - Notification
extension BMPlayer {
    // 屏幕旋转通知
    @objc func orientChange(notification : NSNotification) {
        let orientation = UIDevice.current.orientation
        if orientation == .landscapeLeft {
            if isFullScreen == false {
                if isLandscape == true{
                    //播放器所在控制器页面支持旋转情况下，和正常情况是相反的
                    fullScreenWith(Direction: .landscapeRight)
                }else {
                    fullScreenWith(Direction: .landscapeLeft)
                }
            }
        }else if orientation == .landscapeRight {
            if isFullScreen == false {
                if isLandscape == true{
                    //播放器所在控制器页面支持旋转情况下，和正常情况是相反的
                    fullScreenWith(Direction: .landscapeLeft)
                }else {
                    fullScreenWith(Direction: .landscapeRight)
                }
            }
        }else if orientation == .portrait {
            originalscreen()
        }
    }
    
    @objc fileprivate func appDidEnterBackground(notification: NSNotification) {
    
    }

    @objc fileprivate func appDidEnterPlayground(notification: NSNotification) {
        
    }

}


// MARK: - BMPlayerLayerViewDelegate
extension BMPlayer: BMPlayerLayerViewDelegate {
    public func bmPlayer(player: BMPlayerLayerView, playerIsPlaying playing: Bool) {
        controlView.playStateDidChange(isPlaying: playing)
        delegate?.bmPlayer(player: self, playerIsPlaying: playing)
        playStateDidChange?(player.isPlaying)
    }
    
    public func bmPlayer(player: BMPlayerLayerView ,loadedTimeDidChange loadedDuration: TimeInterval , totalDuration: TimeInterval) {
        BMPlayerManager.shared.log("loadedTimeDidChange - \(loadedDuration) - \(totalDuration)")
        controlView.loadedTimeDidChange(loadedDuration: loadedDuration , totalDuration: totalDuration)
        delegate?.bmPlayer(player: self, loadedTimeDidChange: loadedDuration, totalDuration: totalDuration)
        controlView.totalDuration = totalDuration
        self.totalDuration = totalDuration
    }
    
    public func bmPlayer(player: BMPlayerLayerView, playerStateDidChange state: BMPlayerState) {
        BMPlayerManager.shared.log("playerStateDidChange - \(state)")
        
        controlView.playerStateDidChange(state: state)
        switch state {
        case BMPlayerState.readyToPlay:
            if !isPauseByUser {
                play()
            }
            if shouldSeekTo != 0 {
                seek(shouldSeekTo, completion: {
                    if !self.isPauseByUser {
                        self.play()
                    } else {
                        self.pause()
                    }
                })
            }
            
        case BMPlayerState.bufferFinished:
            autoPlay()
            
        case BMPlayerState.playedToTheEnd:
            isPlayToTheEnd = true
            
        default:
            break
        }
        panGesture.isEnabled = state != .playedToTheEnd
        delegate?.bmPlayer(player: self, playerStateDidChange: state)
    }
    
    
    
    public func bmPlayer(player: BMPlayerLayerView, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        BMPlayerManager.shared.log("playTimeDidChange - \(currentTime) - \(totalTime)")
        delegate?.bmPlayer(player: self, playTimeDidChange: currentTime, totalTime: totalTime)
        self.currentPosition = currentTime
        totalDuration = totalTime
        if isSliderSliding {
            return
        }
        
        controlView.playTimeDidChange(currentTime: currentTime, totalTime: totalTime)
        controlView.totalDuration = totalDuration
        playTimeDidChange?(currentTime, totalTime)
    }
}


// MARK: - BMPlayerControlViewDelegate
extension BMPlayer: BMPlayerControlViewDelegate {
    public func controlView(controlView: BMPlayerControlView,
                            didChooseDefition index: Int) {
        shouldSeekTo = currentPosition
        playerLayer?.resetPlayer()
        currentDefinition = index
        playerLayer?.playAsset(asset: resource.definitions[index].avURLAsset)
    }
    
    public func controlView(controlView: BMPlayerControlView,
                            didPressButton button: UIButton) {
        if let action = BMPlayerControlView.ButtonType(rawValue: button.tag) {
            switch action {
            case .back:
                backBlock?(isFullScreen)
                if isFullScreen {
                    originalscreen()
                } else {
                    playerLayer?.prepareToDeinit()
                }
                
            case .play:
                if button.isSelected {
                    pause()
                } else {
                    if isPlayToTheEnd {
                        seek(0, completion: {
                            self.play()
                        })
                        controlView.hidePlayToTheEndView()
                        isPlayToTheEnd = false
                    }
                    play()
                }
                
            case .replay:
                isPlayToTheEnd = false
                seek(0)
                play()
                
            case .fullscreen:
                fullScreenButtonPressed()
                
            default:
                print("[Error] unhandled Action")
            }
        }
    }
    
    public func controlView(controlView: BMPlayerControlView,
                            slider: UISlider,
                            onSliderEvent event: UIControlEvents) {
        switch event {
        case UIControlEvents.touchDown:
            playerLayer?.onTimeSliderBegan()
            isSliderSliding = true
            
        case UIControlEvents.touchUpInside :
            isSliderSliding = false
            let target = self.totalDuration * Double(slider.value)
            
            if isPlayToTheEnd {
                isPlayToTheEnd = false
                seek(target, completion: {
                    self.play()
                })
                controlView.hidePlayToTheEndView()
            } else {
                seek(target, completion: {
                    self.autoPlay()
                })
            }
        default:
            break
        }
    }
    
    public func controlView(controlView: BMPlayerControlView, didChangeVideoAspectRatio: BMPlayerAspectRatio) {
        self.playerLayer?.aspectRatio = self.aspectRatio
    }
    
    public func controlView(controlView: BMPlayerControlView, didChangeVideoPlaybackRate rate: Float) {
        self.playerLayer?.player?.rate = rate
    }
}
