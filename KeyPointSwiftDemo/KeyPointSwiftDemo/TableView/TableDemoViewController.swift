//
//  TableDemoViewController.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/22.
//

import UIKit

class TableDemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    let dataSourceArray = ["原生", "代码自定义", "Xib自定义" ,"根据约束自动计算动态高度->"]
    let CellIDOrign = "CellIDOrign"
    let CellIDCode = "CellIDCode"
    let CellIDXib = "CellIDXibCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(CellIDCodeCell.self, forCellReuseIdentifier: CellIDCode)
        myTableView.register(UINib.init(nibName: CellIDXib, bundle: nil), forCellReuseIdentifier: CellIDXib)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: CellIDOrign)
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: CellIDOrign) ?? UITableViewCell(style: .subtitle, reuseIdentifier: CellIDOrign)
            cell.textLabel?.text = self.dataSourceArray[indexPath.row]
            break
        case 1:
            let codeCell = tableView.dequeueReusableCell(withIdentifier: CellIDCode)! as! CellIDCodeCell;
            codeCell.contentLabelString = self.dataSourceArray[indexPath.row]
            cell = codeCell
            break
        case 2:
            let codeCell = tableView.dequeueReusableCell(withIdentifier: CellIDXib)! as! CellIDXibCell;
            codeCell.contentLabelString = self.dataSourceArray[indexPath.row]
            cell = codeCell
            break
        default:
            cell.textLabel?.text = self.dataSourceArray[indexPath.row]
            break
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 50;
        case 1:
            return 100;
        case 2:
            return 150;
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            self.navigationController?.pushViewController(TableViewCalHeightViewController(), animated: true)
        }
            
    }

}
