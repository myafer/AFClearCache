//
//  TableViewController.swift
//  AFClearCache
//
//  Created by Afer on 2017/4/28.
//  Copyright © 2017年 Afer. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet weak var sizeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        AFClearCacheManager.asynCalcCacheSize { (size) in
            self.sizeLabel.text = size + "m"
        }
       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            AFClearCacheManager.asynRemoveCache(calcCallBack: { (size) in
                let ale = UIAlertView(title: "温馨提示", message: "删除缓存成功！现在\(size)M。", delegate: nil, cancelButtonTitle: "确定")
                ale.show()
            })
        }
    }

    
}
