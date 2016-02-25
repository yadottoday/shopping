//
//  SecondViewController.swift
//  shopping
//
//  Created by 王庆华 on 15/12/11.
//  Copyright © 2015年 王庆华. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        // Do any additional setup after loading the view.
    }

    // 准备UI 
    private func prepareUI() {
    
        navigationItem.title = "货架"
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
