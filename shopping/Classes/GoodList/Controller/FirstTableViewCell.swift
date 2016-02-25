//
//  FirstTableViewCell.swift
//  shopping
//
//  Created by 王庆华 on 15/12/15.
//  Copyright © 2015年 王庆华. All rights reserved.
//

import UIKit

protocol FirstTableViewCellDelegate: NSObjectProtocol {
    
    func deleteCell(cell: FirstTableViewCell, button: UIButton)
}

class FirstTableViewCell: UITableViewCell {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!

    weak var delegate:FirstTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareUI() {
        
        myButton.setTitle("删除", forState: UIControlState.Normal)
        myButton.backgroundColor = UIColor.redColor()
        myButton.layer.cornerRadius = 15
        myButton.layer.masksToBounds = true
        myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myButton.addTarget(self, action: "BtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    @objc private func BtnClick(button:UIButton){
        
        delegate?.deleteCell(self, button: button)
    }
    
}
