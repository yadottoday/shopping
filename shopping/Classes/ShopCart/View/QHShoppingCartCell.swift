//
//  QHShoppingCartCell.swift
//  shopping
//
//  Created by 王庆华 on 15/12/10.
//  Copyright © 2015年 王庆华. All rights reserved.
//

import UIKit

protocol QHShoppintCartCellDelegate: NSObjectProtocol {
    
    func shoppingCartCell(cell: QHShoppingCartCell, button: UIButton, countLabel: UILabel)
    
    func reCalculateTotalPrice()
}

class QHShoppingCartCell: UITableViewCell {
    
    // MARK: - 属性 
    // 属性
    var goodModel: QHGoodModel? {
        didSet {
            
            //选中状态 
            selectButton.selected = goodModel!.selected
            
            goodCountLabel.text = "\(goodModel!.count)"
            
            if let iconName = goodModel?.iconName {
                iconView.image = UIImage(named: iconName)
            }
            
            if let title = goodModel?.title {
                titleLabel.text = title
            }
            
            if let newPrice = goodModel?.newPrice {
                newPriceLabel.text = newPrice
            }
            
            if let oldPrice = goodModel?.oldPrice {
                oldPriceLabel.text = oldPrice
            }
            
            // 重新布局 更新frame 
            layoutIfNeeded()

        }
    }
    
    // 代理属性 
    weak var delegate: QHShoppintCartCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - 构造方法 
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 准备UI
        prepareUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func prepareUI() {
        
        // 添加子控件 
        contentView.addSubview(selectButton)
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(newPriceLabel)
        contentView.addSubview(oldPriceLabel)
        contentView.addSubview(addAndSubtraction)
        addAndSubtraction.addSubview(subtractionButton)
        addAndSubtraction.addSubview(goodCountLabel)
        addAndSubtraction.addSubview(addButton)
        
        // 约束子控件 
        selectButton.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(12)
            make.centerY.equalTo(contentView.snp_centerY)
        }
        
        iconView.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(42)
            make.top.equalTo(10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(contentView.snp_top).offset(10)
            make.left.equalTo(iconView.snp_right).offset(12)
        }
        
        newPriceLabel.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(titleLabel.snp_top).offset(5)
            make.right.equalTo(-12)
        }
        
        oldPriceLabel.snp_makeConstraints { (make) -> Void in

            make.top.equalTo(newPriceLabel.snp_bottom).offset(5)
            make.right.equalTo(-12)
        }
        
        addAndSubtraction.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(120)
            make.top.equalTo(40)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        subtractionButton.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        goodCountLabel.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(30)
            make.top.equalTo(0)
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
        
        addButton.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(70)
            make.top.equalTo(0)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    // MARK: - 响应事件 
    // 被点击的按钮 tag10 减 tag11 加 
    @objc private func didTappedCalculateButton(button: UIButton) {
        
        delegate?.shoppingCartCell(self, button: button, countLabel: goodCountLabel)
    }
    
    // 选中按钮后触发
    @objc private func didSelecteButton(button: UIButton) {
        
        // 选中
        button.selected = !button.selected
        goodModel?.selected = button.selected
        
        // 重新计算价格
        delegate?.reCalculateTotalPrice()
    }
    
    
    // MARK: - 懒加载 
    private lazy var selectButton: UIButton = {
       
        let selectButton = UIButton(type: UIButtonType.Custom)
        selectButton.setImage(UIImage(named: "check_n"), forState: UIControlState.Normal)
        selectButton.setImage(UIImage(named: "check_y"), forState: UIControlState.Selected)
        selectButton.addTarget(self, action: "didSelecteButton:", forControlEvents: UIControlEvents.TouchUpInside)
        selectButton.sizeToFit()
        return selectButton
    }()
    
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
    
    // 新价格标签 
    private lazy var newPriceLabel: UILabel = {
        
        let newPriceLabel = UILabel()
        newPriceLabel.textColor = UIColor.redColor()
        return newPriceLabel
    }()
    
    // 老价格标签 
    private lazy var oldPriceLabel: UILabel = {
       
        let oldPriceLabel = QHOldPriceLabel()
        oldPriceLabel.textColor = UIColor.grayColor()
        return oldPriceLabel
    }()
    
    // 加减操作的view 
    private lazy var addAndSubtraction: UIView = {
       
        let addAndSubtraction = UIView()
        addAndSubtraction.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
        return addAndSubtraction
    }()
    
    // 减号按钮 
    private lazy var subtractionButton: UIButton = {
       
        let subtractionButton = UIButton(type: UIButtonType.Custom)
        subtractionButton.tag = 10
        subtractionButton.setBackgroundImage(UIImage(named: "subtraction_icon"), forState: UIControlState.Normal)
        subtractionButton.addTarget(self, action: "didTappedCalculateButton:", forControlEvents: UIControlEvents.TouchUpInside)
        return subtractionButton
    }()
    
    // 加号按钮 
    private lazy var addButton: UIButton = {
        
        let addButton = UIButton(type: UIButtonType.Custom)
        addButton.tag = 11
        addButton.setBackgroundImage(UIImage(named: "add_icon"), forState: UIControlState.Normal)
        addButton.addTarget(self, action: "didTappedCalculateButton:", forControlEvents: UIControlEvents.TouchUpInside)
        return addButton
    }()
    
    // 显示数量 label 
    private lazy var goodCountLabel: UILabel = {
        
        let goodCountLabel = UILabel()
        goodCountLabel.textAlignment = NSTextAlignment.Center
        return goodCountLabel
    }()
    

}
