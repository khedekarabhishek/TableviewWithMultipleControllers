//
//  MyTableViewController.swift
//  TableviewWithMultipleControllers
//
//  Created by Abhishek Khedekar on 09/01/18.
//  Copyright © 2018 Abhishek Khedekar. All rights reserved.
//

import UIKit

class MyTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    lazy var firstVC:FirstViewController = {
        return self.storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UITableViewAutomaticDimension
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as! FirstTableViewCell
            cell.contentViewController =  self.firstVC
            return cell
            
        default:
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "myLabel"
            cell.contentView.backgroundColor = UIColor.green
            return cell
        }
    }
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if cell .isKind(of: FirstTableViewCell.self) {
                let mycell:FirstTableViewCell = cell as! FirstTableViewCell
                mycell.addViewControllerToParentViewController(parentViewController: self)
            }
        default:
//            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
            break
        }
    }
    
 
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if cell .isKind(of: FirstTableViewCell.self) {
                let mycell:FirstTableViewCell = cell as! FirstTableViewCell
                mycell.removeViewControllerFromParentViewController()
            }
        default:
            //            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
            break
        }
    }
    
}
