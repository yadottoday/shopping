//
//  FirstViewController.swift
//  shopping
//
//  Created by 王庆华 on 15/12/11.
//  Copyright © 2015年 王庆华. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentified = "cell"
    var numbers = ["One","Two","Three","Foure","Five","Six","Seven","Eight","Nine","Ten"];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 准备UI
        prepareUI()
        // Do any additional setup after loading the view.
    }

   private func prepareUI() {
    
        navigationItem.title = "首页"
    
        tableView.delegate = self
        tableView.dataSource = self
    
//        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentified)
        tableView.registerNib(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentified)
    
    
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            numbers.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
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

extension FirstViewController:UITableViewDelegate, UITableViewDataSource, FirstTableViewCellDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentified, forIndexPath: indexPath) 
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentified, forIndexPath: indexPath) as! FirstTableViewCell
        
//        cell.textLabel?.text = numbers[indexPath.row]
        cell.myLabel.text = numbers[indexPath.row]
        cell.delegate = self
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == 2 {
            return false
        }
        return true
    }
    
    func deleteCell(cell: FirstTableViewCell, button: UIButton) {
        
        let idx:NSIndexPath = tableView.indexPathForCell(cell)!
        
        numbers.removeAtIndex(idx.row)
        tableView.deleteRowsAtIndexPaths([idx], withRowAnimation: UITableViewRowAnimation.Top)
    }
}




