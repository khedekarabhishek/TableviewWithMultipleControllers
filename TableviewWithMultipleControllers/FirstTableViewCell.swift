//
//  FirstTableViewCell.swift
//  TableviewWithMultipleControllers
//
//  Created by Abhishek Khedekar on 09/01/18.
//  Copyright © 2018 Abhishek Khedekar. All rights reserved.
//

import UIKit
import Foundation

class FirstTableViewCell: UITableViewCell {
    
    var contentViewController:FirstViewController = FirstViewController()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func addViewControllerToParentViewController(parentViewController:UIViewController)  {
        parentViewController.addChildViewController(self.contentViewController)
        self.contentViewController.didMove(toParentViewController: parentViewController)
        self.contentView.addSubview((self.contentViewController.view)!)
    }
    
    func removeViewControllerFromParentViewController() {
        self.contentViewController.view.removeFromSuperview()
        self.contentViewController.willMove(toParentViewController: nil)
        self.contentViewController.removeFromParentViewController()
    }
    

    
}
