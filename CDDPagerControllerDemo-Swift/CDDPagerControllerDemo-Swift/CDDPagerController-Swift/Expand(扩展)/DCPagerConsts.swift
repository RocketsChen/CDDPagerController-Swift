//
//  DCPagerConsts.swift
//  CDDPagerControllerDemo-Swift
//
//  Created by 陈甸甸 on 2018/3/5.
//  Copyright © 2018年 陈甸甸. All rights reserved.
//

import UIKit
import Foundation

let DCScreenW: CGFloat = UIScreen.main.bounds.width
let DCScreenH: CGFloat = UIScreen.main.bounds.height

class DCPagerConsts: NSObject {

    /** 常量数 */
    static let DCPagerMargin = 10
    
    /** 按钮tag附加值 */
    static let DCButtonTagValue = 100
    
    /** 默认标题栏高度 */
    static let DCNormalTitleViewH = 44
    
    /** 下划线默认高度 */
    static let DCUnderLineH = 4
    
}


// MARK: - 颜色
extension UIColor {
    
    var dc_components:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r:CGFloat = 0.0
        var g:CGFloat = 0.0
        var b:CGFloat = 0.0
        var a:CGFloat = 0.0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r,g,b,a)
    }
}
