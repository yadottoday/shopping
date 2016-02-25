//
//  QHGoodModel.swift
//  shopping
//
//  Created by 王庆华 on 15/12/10.
//  Copyright © 2015年 王庆华. All rights reserved.
//

import UIKit

class QHGoodModel: NSObject {
    
    //是否已经加入购物车 
    var alreadyAddShoppingCart: Bool = false
    //商品图片名称 
    var iconName: String?
    //商品标题 
    var title: String?
    //商品描述 
    var desc: String?
    //商品购买个数 默认是0 
    var count: Int = 1
    //新价格 
    var newPrice: String?
    //老价格 
    var oldPrice: String?
    //是否选中 默认没有选中 
    var selected:Bool = true
    
    //字典转模型  
    init(dict: [String : AnyObject]) {
        super.init()
        
        //使用kvo 为当前对象的属性  
        setValuesForKeysWithDictionary(dict)
    }
    
    //防止对象属性和kvo时的dict的key 不匹配而崩溃 
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}
