//
//  QHGoodListCell.swift
//  shopping
//
//  Created by 王庆华 on 15/12/10.
//  Copyright © 2015年 王庆华. All rights reserved.
//

import UIKit

// 代理
protocol QHGoodListCellDelegate: NSObjectProtocol {
    
    func goodListCell(cell: QHGoodListCell, iconView: UIImageView)
}

class QHGoodListCell: UITableViewCell {
    
    // MARK: - 属性 
    // 商品模型  
    var goodModel: QHGoodModel? {
        didSet {
            
            if let iconName = goodModel?.iconName {
        
                iconView.image = UIImage(named: iconName)
            }
            
            if let title = goodModel?.title {
                titleLabel.text = title
            }
            
            if let desc = goodModel?.desc {
                descLabel.text = desc
            }
            
            // 已经点击的就禁用，这样做是防止cell重用 
            //  addCartButton.enabled = (goodModel?.alreadyAddShoppingCart)! 错误写法
            addCartButton.enabled = !goodModel!.alreadyAddShoppingCart
            
            // 重新布局 会更新frame  
            layoutIfNeeded()
        }
        
    }

    // 代理属性 weak variable should have optional type
    weak var delegate: QHGoodListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 准备UI
        prepareUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
     准备UI
    */
    private func prepareUI() {
    
        // 添加子控件 
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(addCartButton)
        
        // 约束子控件 
        iconView.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(12)
            make.top.equalTo(10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(contentView.snp_top).offset(10)
            make.left.equalTo(iconView.snp_right).offset(12)
        }
        
        descLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(titleLabel.snp_bottom).offset(12)
            make.left.equalTo(iconView.snp_right).offset(12)
        }
        
        addCartButton.snp_makeConstraints { (make) -> Void in
            
            make.right.equalTo(-12)
            make.top.equalTo(25)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
    }
    
    // MARK: - 响应事件 
    // 点击了购买按钮的事件 
    // parameter button: 购买按钮
    @objc private func didTappedAddCartButton(button: UIButton) {
        
        // 已经购买
        goodModel?.alreadyAddShoppingCart = true
        
        // 已经点击的就禁用 
        button.enabled = !goodModel!.alreadyAddShoppingCart
        
        //通知代理对象 去做后续操作 
        delegate?.goodListCell(self, iconView: iconView)
        
    }
    
    // MARK: - 懒加载 
    // 商品图片 
    private lazy var iconView: UIImageView = {
       
        let iconView = UIImageView()
        iconView.layer.cornerRadius = 30
        iconView.layer.masksToBounds = true
        return iconView
    }()
    
    // 商品标题  
    private lazy var titleLabel: UILabel = {
       
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    // 商品描述 
    private lazy var descLabel: UILabel = {
      
        let descLabel = UILabel()
        descLabel.textColor = UIColor.grayColor()
        return descLabel
    }()
    
    // 添加按钮  
    private lazy var addCartButton: UIButton = {
       
        let addCartButton = UIButton(type: UIButtonType.Custom)
        addCartButton.setBackgroundImage(UIImage(named: "button_cart_add"), forState: UIControlState.Normal)
        addCartButton.setTitle("购买", forState: UIControlState.Normal)
        
        // 添加按钮点击事件 
        addCartButton.addTarget(self, action: "didTappedAddCartButton:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return addCartButton
    }()
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
