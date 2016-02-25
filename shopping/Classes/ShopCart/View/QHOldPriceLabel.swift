//
//  QHOldPriceLabel.swift
//  shopping
//
//  Created by 王庆华 on 15/12/10.
//  Copyright © 2015年 王庆华. All rights reserved.
//

import UIKit

class QHOldPriceLabel: UILabel {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        // 调用父类是为了让Label原有的数据正常显示 
        super.drawRect(rect)
        
        // 绘制中划线 
        let ctx = UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctx, 0, rect.size.height * 0.5)
        CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height * 0.5)
        CGContextStrokePath(ctx)
    }
    

}
