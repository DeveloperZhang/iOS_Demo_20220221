//
//  TableViewCalHeightViewController.swift
//  KeyPointSwiftDemo
//
//  Created by Vicent on 2022/2/22.
//

import UIKit

class TableViewCalHeightViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    let kCellID = "CellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.rowHeight = UITableView.automaticDimension
        myTableView.register(UINib.init(nibName: "AutomaticDimensionTableViewCell", bundle: nil), forCellReuseIdentifier: kCellID)
    }

    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: kCellID) ?? UITableViewCell(style: .subtitle, reuseIdentifier: kCellID);
        return cell;
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
