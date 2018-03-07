//
//  DCPagerProgressView.swift
//  CDDPagerControllerDemo-Swift
//
//  Created by 陈甸甸 on 2018/3/5.
//Copyright © 2018年 陈甸甸. All rights reserved.
//

import UIKit

class DCPagerProgressView: UIView {

    /** 进度条 */
    var progress: NSInteger?
    /** 尺寸 */
    var itemFrames : NSMutableArray?
    /** 颜色 */
    var color : UIColor?
    /** 是否拉伸 */
    var isStretch : Bool?

    override init(frame: CGRect) { //重写方法
        super.init(frame: frame)
        
        setUpUI()

    }
    
    func setUpUI()  {
        
        let height = CGFloat(self.frame.size.height)
        let lineWidth = 2.0
        let cornerRadius = (height >= 4) ? 3.0 : lineWidth
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.masksToBounds = true
        
    }
    
    override func draw(_ rect: CGRect) {
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
