//
//  ThreadDemoTableViewController.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/23.
//

import UIKit

class ThreadDemoTableViewController: UITableViewController {
    
    let dataArray = ["PThread", "NSThread", "GCD", "NSOperation"]
    let vcArray = [PThreadViewController(), NSThreadDemoViewController(), GCDViewController(), NSOperationDemoViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellID") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier");
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.vcArray[indexPath.row]
        vc.navigationItem.title = String(describing: type(of: self.vcArray[indexPath.row]))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
