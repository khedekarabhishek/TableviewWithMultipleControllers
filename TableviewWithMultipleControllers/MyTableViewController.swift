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

    lazy var secondVC:SecondViewController = {
        return self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
    }()

    lazy var thirdVC:ThirdViewController = {
        return self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
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
        return 300
//        switch indexPath.row {
//        case 0:
//            return 300
//        default:
//            return 100
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as! FirstTableViewCell
            cell.contentViewController =  self.firstVC
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            cell.contentViewController =  self.secondVC
            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell") as! ThirdTableViewCell
            cell.contentViewController =  self.thirdVC
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
            
        case 1:
            if cell .isKind(of: SecondTableViewCell.self) {
                let mycell:SecondTableViewCell = cell as! SecondTableViewCell
                mycell.addViewControllerToParentViewController(parentViewController: self)
            }
            
        case 2:
            if cell .isKind(of: ThirdTableViewCell.self) {
                let mycell:ThirdTableViewCell = cell as! ThirdTableViewCell
                mycell.addViewControllerToParentViewController(parentViewController: self)
            }
            
        default:
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
            
        case 1:
            if cell .isKind(of: SecondTableViewCell.self) {
                let mycell:SecondTableViewCell = cell as! SecondTableViewCell
                mycell.removeViewControllerFromParentViewController()
            }
            
        case 2:
            if cell .isKind(of: ThirdTableViewCell.self) {
                let mycell:ThirdTableViewCell = cell as! ThirdTableViewCell
                mycell.removeViewControllerFromParentViewController()
            }

        default:
            break
        }
    }
    
}
