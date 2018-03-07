//
//  DCPagerViewController.swift
//  CDDPagerControllerDemo-Swift
//
//  Created by 陈甸甸 on 2018/3/6.
//Copyright © 2018年 陈甸甸. All rights reserved.
//

import UIKit

class DCPagerViewController: UIViewController {
    
    /** 自定义顶部按钮 */
    var titleButton = UIButton()
    /** 上一次选中的按钮 */
    var lastSelectButton = UIButton()
    
    /** 标题ScrollView的高度 */
    var titleViewHeight = CGFloat()
    
    /** 标题按钮的宽度 */
    var titleButtonWidth = CGFloat()
    
    /** 正常标题颜色 /选中标题颜色  */
    var norColor = UIColor.black
    var selColor = UIColor.red
    
    /** 标题ScrollView距离顶部的间距 */
    var topDistance = Int()
    /** 是否已经加载标题 */
    var isLoadTitles = Bool()
    /** 是否隐藏指示条 */
    var isHideProgress = Bool()
    

    // MARK: - LazyLoad
    private lazy var titleButtonArray : NSMutableArray = {
        
        let titleButtonArray = NSMutableArray()
        return titleButtonArray
        
    }()
    
    private lazy var progressView : DCPagerProgressView = {
        let progressView = DCPagerProgressView()
        return progressView
        
    }()
    
    private lazy var pregressFrames : NSMutableArray = {
        
        let pregressFrames = NSMutableArray()
        return pregressFrames
        
    }()
    
    private lazy var titleScrollView : UIScrollView = {
        
        let titleScrollView  = UIScrollView()
        titleScrollView.showsHorizontalScrollIndicator = false
        view.addSubview(titleScrollView)
        return titleScrollView
    }()
    
    private lazy var contentScrollView : UIScrollView = {
        
        let contentScrollView  = UIScrollView()
        contentScrollView.backgroundColor = UIColor.white
        contentScrollView.delegate = self
        contentScrollView.bounces = false
        contentScrollView.isPagingEnabled = true
        contentScrollView.showsHorizontalScrollIndicator = false
        
        view.addSubview(contentScrollView)
        return contentScrollView
    }()
    
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        
        if isLoadTitles == false {
        
            viewDidLayoutSubviews()
            setUpAllTitle()
            isLoadTitles = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let statusH = CGFloat(UIApplication.shared.statusBarFrame.size.height) //X以外20
        let ty = (navigationController?.isNavigationBarHidden)! ? statusH : statusH + CGFloat(DCPagerConsts.DCNormalTitleViewH)
        let th = (titleViewHeight != 0) ?  titleViewHeight : CGFloat(DCPagerConsts.DCNormalTitleViewH)
        titleScrollView.frame = CGRect(x: 0, y: ty + CGFloat(topDistance), width: DCScreenW , height: th)
        contentScrollView.frame = CGRect(x: 0, y: ty + th + CGFloat(topDistance), width: DCScreenW, height: DCScreenH - (ty + th))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
    }
}


// MARK: - 设置 UI 界面
extension DCPagerViewController {
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        contentScrollView.backgroundColor = UIColor.white
    }
    
    
    // MARK: - 设置标题
    fileprivate func setUpAllTitle() {
        
        creatTitlesButton { () -> Int in
            return childViewControllers.count
        }
    }
    
    
    // MARK: - 创建scrollView按钮
    private func creatTitlesButton(buttonCount : () -> Int){
        
        guard buttonCount() == 0 else { //当子控制器不等于0 的情况下
            
            let customW = 80
            let w = Int(DCScreenW)
            let buttonW = (titleButtonWidth != 0) ?  titleButtonWidth : ((buttonCount() * customW) < w) ? CGFloat(w / buttonCount()) : CGFloat (customW + 20)
            
            let th = (titleViewHeight != 0) ? titleViewHeight : 44
            
            let buttonH = th
            
            progressView = DCPagerProgressView()
            progressView.frame = CGRect(x: buttonW * 0.2, y: buttonH - 5, width: buttonW * 0.6, height: 3)
            progressView.isHidden = isHideProgress
            titleScrollView.addSubview(progressView)
            
            for i in 0..<buttonCount() {
                
                titleButton = UIButton.init(type:UIButtonType.custom)
                let vc = childViewControllers[i]
                titleButton.setTitle(vc.title, for:.normal)
                titleButton.tag = i + DCPagerConsts.DCButtonTagValue
                titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                titleButton.frame = CGRect(x: CGFloat(i * Int(buttonW)), y: 0, width: buttonW, height: buttonH)
                titleButton.backgroundColor = UIColor.clear
                titleButton.setTitleColor(norColor,for:
                    .normal) //普通状态下文字的颜色
                titleButton.addTarget(self, action: #selector(titleButtonClick(_:)), for: .touchUpInside)
                titleScrollView.addSubview(titleButton)
                
                titleButtonArray.add(titleButton) //数据按钮
            
                if i==0 { //默认选中第一个
                    titleButtonClick(titleButton)
                }

            }
            progressView.backgroundColor = selColor
            titleScrollView.contentSize = CGSize(width: CGFloat(buttonCount()) * buttonW, height: 0)
            contentScrollView.contentSize = CGSize(width: CGFloat(buttonCount()) * DCScreenW, height: 0)
            
            return
        }
        
    }
    
    // MARK: - 按钮点击事件
    @objc private func titleButtonClick (_ button : UIButton){
        
        let buttonTag = button.tag - DCPagerConsts.DCButtonTagValue //获取tag
        
        //选中标题
        selectButton(button: button)
        
        //添加控制器
        addOneVcWithButtton(index: buttonTag)
        
        contentScrollView.contentOffset = CGPoint(x: CGFloat(buttonTag) * DCScreenW, y: 0)
    }
    
    
    // MARK: - 添加Vc
    private func addOneVcWithButtton(index :Int) {
        
        let vc = self.childViewControllers[index] //获取Vc
    
        guard (vc.view.superview != nil) else {
            vc.view.frame = CGRect(x: CGFloat(index) * DCScreenW, y: 0, width: DCScreenW, height: contentScrollView.frame.height)
            contentScrollView.addSubview(vc.view)
            return
        }
    
    }
    
    
    
    // MARK: - 选中标题
    private func selectButton(button :UIButton){
        
        //还原
        lastSelectButton.transform = CGAffineTransform.identity
        
        lastSelectButton.setTitleColor(norColor, for: .normal)
        button.setTitleColor(selColor, for: .normal)
        lastSelectButton = button
        
        button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1);
    
        weak var weakSelf = self
        UIView .animate(withDuration: 0.25) {
            weakSelf?.progressView.center.x = button.center.x
        }


        if titleScrollView.contentSize.width > DCScreenW {
            
            var offsetX = button.center.x - DCScreenW * 0.5
            
            if offsetX < 0 {
                offsetX = 0
            }
            let offsetMax = titleScrollView.contentSize.width - DCScreenW;
            if offsetX > offsetMax {
                offsetX = offsetMax
            }
            titleScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        }
        
    }
}

// MARK: - Outside Link
extension DCPagerViewController {
    // MARK: - 点击标题处理
    func dc_setSelectIndex(index: Int) {
        guard childViewControllers.count <= 0 else {
            let button = titleButtonArray[index]
            guard index >= titleButtonArray.count else {
                titleButtonClick(button as! UIButton)
                return
            }
            return
        }
    }
}


// MARK: - UIScrollViewDelegate
extension DCPagerViewController : UIScrollViewDelegate{
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let tagIndex = scrollView.contentOffset.x / DCScreenW
        let buttonIndex = titleButtonArray[Int(tagIndex)]
        
        addOneVcWithButtton(index: Int(tagIndex))
        selectButton(button: buttonIndex as! UIButton)
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let tagIndex = Int(scrollView.contentOffset.x / DCScreenW)
        //index
        let leftI = CGFloat(tagIndex)
        let rightI = CGFloat(leftI + 1)
        
        //缩放
        var leftButton = UIButton()
        var rightButton = UIButton()
        leftButton = titleButtonArray[Int(leftI)] as! UIButton
        
        if Int(rightI) < titleButtonArray.count {
            rightButton = titleButtonArray[Int(rightI)] as! UIButton
        }
        
        var scaleR = scrollView.contentOffset.x / DCScreenW
        scaleR -= leftI;
        
        let scaleL = 1 - scaleR
        leftButton.transform = CGAffineTransform(scaleX: scaleL * 0.1 + 1, y: scaleL * 0.1 + 1);
        rightButton.transform = CGAffineTransform(scaleX: scaleR * 0.1 + 1, y: scaleR * 0.1 + 1);
     
        //渐变
        let strR = norColor.dc_components.red
        let endR = selColor.dc_components.red
        
        let strG = norColor.dc_components.green
        let endG = selColor.dc_components.green
        
        let strB = norColor.dc_components.blue
        let endB = selColor.dc_components.blue
        
        let r = endR - strR
        let g = endG - strG
        let b = endB - strB
        
        let rightColor = UIColor.init(red: strR + r * scaleR, green: strG + g * scaleR, blue: strB + b * scaleR, alpha: 1.0)
        let leftColor = UIColor.init(red: strR + r * scaleL, green: strG + g * scaleL, blue: strB + b * scaleL, alpha: 1.0)
        
        rightButton.setTitleColor(rightColor, for: .normal)
        leftButton.setTitleColor(leftColor, for: .normal)
    }
}
