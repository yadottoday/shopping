//
//  QHShoppingCartViewController.swift
//  shopping
//
//  Created by 王庆华 on 15/12/10.
//  Copyright © 2015年 王庆华. All rights reserved.
//

import UIKit

class QHShoppingCartViewController: UIViewController {
    
    // MARK: - 属性 
    // 已经添加进购物车的商品模型数组 初始化 
    var addGoodArray: [QHGoodModel]? {
        didSet {
            
        }
    }

    // 总金额 默认0.00 
    var price: Float = 0.00
    
    // 商品列表cell的重用标识符 
    private let shoopingCartCellIdentifier = "shoppingCartCell"
    
    // MARK: - view的生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 自定义返回图片
        prepareUI()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 布局UI 
        layoutUI()
        
        // 重新计算价格 
        reCalculateGoodCount()
        
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    // 准备UI prepareUI
    private func prepareUI() {
        
         self.navigationItem.leftBarButtonItems = [spacer, leftBarButton]
        
        // self.navigationItem.leftBarButtonItem = leftBarButton
        


        
        
        
        // 标题
        navigationItem.title = "购物车列表"
        
        // view 的背景颜色  
        view.backgroundColor = UIColor.whiteColor()
        
        // cell 的行高 
        tableView.rowHeight = 80
        
        // 注册cell  
        tableView.registerClass(QHShoppingCartCell.self, forCellReuseIdentifier: shoopingCartCellIdentifier)
        
        // 添加子控件 
        view.addSubview(tableView)
        view.addSubview(bottomView)
        bottomView.addSubview(selectButton)
        bottomView.addSubview(totalPriceLabel)
        bottomView.addSubview(buyButton)
        
        // 判断是否需要全选 
        print(addGoodArray)
        
        for model in addGoodArray! {
            if model.selected != true {
                // 只要有一个不等于就不全选
                selectButton.selected = false
                break
            }
        }
    }
    
    // 布局UI
    private func layoutUI() {
        
        // 约束子控件 
        tableView.snp_makeConstraints { (make) -> Void in
            
            make.left.top.right.equalTo(0)
            make.bottom.equalTo(-49)
        }
        
        bottomView.snp_makeConstraints { (make) -> Void in
            
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(49)
        }
        
        selectButton.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(12)
            make.centerY.equalTo(bottomView.snp_centerY)
        }
        
        totalPriceLabel.snp_makeConstraints { (make) -> Void in
            
            make.center.equalTo(bottomView.snp_center)
        }
        
        buyButton.snp_makeConstraints { (make) -> Void in
            
            make.right.equalTo(-12)
            make.top.equalTo(9)
            make.width.equalTo(88)
            make.height.equalTo(30)
        }
    }
    
    // MARK: - 懒加载
    lazy var leftBarButton: UIBarButtonItem = {
       
        let leftBarButton = UIBarButtonItem(title: "", style: .Plain, target:self, action: "backToPrevious")
        leftBarButton.image = UIImage(named: "navigation_back_white")
        leftBarButton.width = 100
    
        return leftBarButton
        
    }()

    
    // 底部视图
    lazy var bottomView:UIView = {
       
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.whiteColor()
        return bottomView
    }()
    
    // 底部多选、反选按钮 
    lazy var selectButton: UIButton = {
       
        let selectButton = UIButton(type: UIButtonType.Custom)
        selectButton.setImage((UIImage(named: "check_n")), forState: UIControlState.Normal)
        selectButton.setImage(UIImage(named: "check_y"), forState: UIControlState.Selected)
        selectButton.setTitle("多选\\反选", forState: UIControlState.Normal)
        selectButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        selectButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        selectButton.addTarget(self, action: "didTappedSelectButton:", forControlEvents: UIControlEvents.TouchUpInside)
        selectButton.selected = true
        selectButton.sizeToFit()
        return selectButton
    }()
    
    // 底部总价Label  
    lazy var totalPriceLabel: UILabel = {
        
        let totalPriceLabel = UILabel()
        let attributeText = NSMutableAttributedString(string: "总共价格:\(self.price)0")
        attributeText.setAttributes([NSForegroundColorAttributeName: UIColor.redColor()],range: NSMakeRange(5, attributeText.length-5))
        totalPriceLabel.attributedText = attributeText
        totalPriceLabel.sizeToFit()
        return totalPriceLabel
        
    }()
    
    // 底部付款按钮 
    lazy var buyButton: UIButton = {
        
        let buyButton = UIButton(type: UIButtonType.Custom)
        buyButton.setTitle("付款", forState: UIControlState.Normal)
        buyButton.setBackgroundImage(UIImage(named: "button_cart_add"), forState: UIControlState.Normal)
        buyButton.layer.cornerRadius = 15
        buyButton.layer.masksToBounds = true
        return buyButton
    }()
    
    lazy var spacer: UIBarButtonItem = {
       
        //用于消除左边空隙
        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        spacer.width = 0
        return spacer
        
    }()
    
    lazy var tableView: UITableView = {
       
        let tableView = UITableView()
        
        // 指定数据源和代理 
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
        
    }()
    
    // 点击事件 这里的方法不能写成 private
    func backToPrevious() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UITableViewDataSource, UITableViewDelegate 数据 代理 
extension QHShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return addGoodArray?.count ?? 0
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 从缓存池创建cell,不成功就根据重用标识符和注册的cell新创建一个
        let cell = tableView.dequeueReusableCellWithIdentifier(shoopingCartCellIdentifier, forIndexPath: indexPath) as! QHShoppingCartCell
        
        // 取消cell 选中效果 
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        // 指定代理对象
        cell.delegate = self 
        
        // 传递数据模型 
        cell.goodModel = addGoodArray?[indexPath.row]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            addGoodArray?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
             reCalculateGoodCount()
        }
    }
}

// MARK: - view上的一些事件处理 
extension QHShoppingCartViewController {
    
    // 返回按钮
    @objc func reCalculateGoodCount() {
        //遍历模型 
        for model in addGoodArray! {
            
            // 只计算选中的商品 
            if model.selected == true {
                price += Float(model.count)*(model.newPrice! as NSString).floatValue
            }
        }
        
        // 赋值价格
        let attributeText = NSMutableAttributedString(string: "总共价格:\(self.price)0")
        attributeText.setAttributes([NSForegroundColorAttributeName: UIColor.redColor()], range: NSMakeRange(5, attributeText.length - 5))
        totalPriceLabel.attributedText = attributeText
        
        // 清空price 
        price = 0
        
        // 刷新表格 
        tableView.reloadData()
    }
    
    // 点击了多选按钮后的处理事件 
    
    @objc private func didTappedSelectButton(button: UIButton) {
        
        selectButton.selected = !selectButton.selected
        for model in addGoodArray! {
            model.selected = selectButton.selected
        }
        
        // 重新计算总价格 
        reCalculateGoodCount()
        
        // 刷新表格  
        tableView.reloadData()
    }
}

// MAKK: QHShoppingCartCellDelegate 代理方法 
extension QHShoppingCartViewController :QHShoppintCartCellDelegate {
    
    // 点击cell 中的加减按钮 
    /**
        cell 被点击的cell 
        button: 被点击的按钮 
    countLabel : 显示数量的label
    */
    
    func shoppingCartCell(cell: QHShoppingCartCell, button: UIButton, countLabel: UILabel) {
        
        // 根据cell 获取当前模型 
        guard let indexPath = tableView.indexPathForCell(cell) else {
            return
        }
        
        // 获取当前模型 添加到购物车数组 
        let model = addGoodArray![indexPath.row]
        
        if button.tag == 10 {
            if model.count < 1 {
                
                alertView("数量不能低于0")
                print("数量不能低于0")
                return
            }
            
            // 减
            model.count--
            countLabel.text = "\(model.count)"
        } else {
            //加 
            model.count++
            countLabel.text = "\(model.count)"
        }
        
        // 重新计算 
        reCalculateGoodCount()
    }
    
    // 重新计算总价  
    func reCalculateTotalPrice() {
        reCalculateGoodCount()
    }
    
    
    func alertView(messageStr: String) {
        
        let alterController = UIAlertController(title: "系统提示", message: messageStr, preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        
        let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default, handler:nil)
        
        alterController.addAction(cancelAction)
        alterController.addAction(okAction)
        self.presentViewController(alterController, animated: true, completion: nil)
    }
}



