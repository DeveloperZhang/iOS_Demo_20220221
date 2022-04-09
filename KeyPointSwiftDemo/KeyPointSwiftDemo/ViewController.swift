//
//  ViewController.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/21.
//

import UIKit

class ViewController: UITableViewController {
    
    let dataSourceArray = ["ScrollViewUI--滚动视图UI", "原始约束", "VFL约束", "约束优先级", "TableView列表", "自定义视图", "闭包", "多线程", "响应式 链式 响应式 编程"]
    let vcArray: [UIViewController] = [ScrollDemoViewController(), OrignConstraintViewController(), VFLConstraintViewController(), ConstraintPriorityDemoViewController(), TableDemoViewController(), CustomViewDemoViewController(), ClosureDemoViewController(), ThreadDemoTableViewController(), ReactLinkFuncDemoViewController()]
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentify: String = "CellID";
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentify)!;
        cell.textLabel?.text = self.dataSourceArray[indexPath.row];
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.vcArray[indexPath.row]
        vc.navigationItem.title = String(describing: type(of: self.vcArray[indexPath.row]))
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

