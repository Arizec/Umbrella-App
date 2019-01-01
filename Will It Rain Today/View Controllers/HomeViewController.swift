//
//  ViewController.swift
//  Will It Rain Today
//
//  Created by Gabrielle Chandrasaputra on 1/1/19.
//  Copyright © 2019 Arizec. All rights reserved.
//

import UIKit

var options = ["Change Location", "Set Alarm", "Settings"]

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //return same amount of rows as count
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return options.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = options[indexPath.row] //list array as table cells
        cell.backgroundColor = nil //make cells clear
        cell.textLabel?.textColor = UIColor.black //make text color white


        return(cell)

    }
    
    //pathway to location/notification/settings
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myIndex = indexPath.row
        if(myIndex == 0){
            performSegue(withIdentifier: "goToLocation", sender: self)
        }
//        else if(myIndex == 1){
//            performSegue(withIdentifier: "goToMemories", sender: self)
//        }
//
        else{
            performSegue(withIdentifier: "goToSettings", sender: self)
        }
        
        //unselect table view highlight
        tableView.deselectRow(at: indexPath, animated: true)
    }
    


}

