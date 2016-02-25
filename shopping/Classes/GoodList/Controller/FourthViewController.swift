//
//  FourthViewController.swift
//  shopping
//
//  Created by 王庆华 on 15/12/11.
//  Copyright © 2015年 王庆华. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellName = "cell"
    let myTableViewCellIdentified = "MyTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        // Do any additional setup after loading the view.
    }

    // 准备UI
    private func prepareUI() {
    
        navigationItem.title = "我的"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // 注册
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellName)
        
        //注册 
        tableView.registerNib(UINib(nibName: myTableViewCellIdentified, bundle: nil), forCellReuseIdentifier: myTableViewCellIdentified)
        
       
        tableView.tableFooterView = UIView()
        
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

extension FourthViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            return 3
        } else if section == 2 {
            return 5
        } else {
            // do nothing.
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44
        } else {
            return 50
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "第一组"
        } else if section == 1{
            return "第二组"
        } else {
            return "第三组"
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(cellName,
                forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = "123"
            return cell
        } else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier(cellName,
                forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = "test"
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(myTableViewCellIdentified, forIndexPath: indexPath) as! MyTableViewCell
            // 设置代理
            cell.delegate = self
            cell.selectionStyle = UITableViewCellSelectionStyle.None
//            cell.selectButton.setTitle("删除", forState: UIControlState.Normal)
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}

extension FourthViewController:MyTableViewCellDelegate {
    
    func deleteButtonClick(cell: MyTableViewCell, button: UIButton) {
        
        let idx:NSIndexPath = tableView.indexPathForCell(cell)!
        print(idx)
    
        
//        tableView .deleteRowsAtIndexPaths([idx], withRowAnimation: UITableViewRowAnimation.Fade)
        tableView.reloadData()
        print("删除一行")
        
        
    }
}
