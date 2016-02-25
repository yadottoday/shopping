//
//  MyTableViewCell.swift
//  shopping
//
//  Created by 王庆华 on 15/12/14.
//  Copyright © 2015年 王庆华. All rights reserved.
//

import UIKit

// 代理方法  kvo消耗新能 一般使用delegate 或者 block 
protocol MyTableViewCellDelegate : NSObjectProtocol {
    
    func deleteButtonClick(cell:MyTableViewCell, button: UIButton)
}

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var selectButton: UIButton!
    
    // 属性
    weak var delegate: MyTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        prepareUI()
//    }

    func prepareUI() {
        selectButton.setTitle("删除", forState: UIControlState.Normal)
        selectButton.backgroundColor = UIColor.redColor()
        selectButton.layer.cornerRadius = 15
        selectButton.layer.masksToBounds = true
        selectButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        selectButton.addTarget(self, action: "BtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    @objc private func BtnClick(button:UIButton) {
        
        delegate?.deleteButtonClick(self, button: button)
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
}
