//
//  RootViewController.swift
//  iOSTest
//
//  Created by Jinhong Kim on 11/4/16.
//  Copyright © 2016 JHK. All rights reserved.
//

import UIKit


let TestViewControllers = ["KVCViewController"]


class RootViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension RootViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TestViewControllers.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = TestViewControllers[indexPath.row]
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIViewController.make() as KVCViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
