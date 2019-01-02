//
//  ViewController.swift
//  Will It Rain Today
//
//  Created by Gabrielle Chandrasaputra on 1/1/19.
//  Copyright © 2019 Arizec. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var options = ["Change Location", "Set Alarm", "Settings"]
let url = "https://api.darksky.net/forecast/00f4170d77a57f10a2d7c2f5a62da117/42.3601,-71.0589"

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var rainStatus: UILabel!
    
    @IBOutlet weak var weatherDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        callApi()
    }
    
    //hide navigation bar in homepage
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
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
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
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
        else if(myIndex == 1){
            performSegue(withIdentifier: "goToAlarm", sender: self)
        }

        else{
            performSegue(withIdentifier: "goToSettings", sender: self)
        }
        
        //unselect table view highlight
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func callApi(){
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            //print(response)
            switch response.result {
            case .success(let value): //Sucess - can retrieve information
                let json = JSON(value)
                let weather_summary = json["hourly"]["summary"]
                let rain_status = json["hourly"]["icon"] == "rain" ? "YES" : "NO"
                
                
                self.weatherDescription.text = "\(weather_summary)"
                self.rainStatus.text = "\(rain_status)"
                
                
            case .failure(let error): //ERROR - cannot load information
                
                //alert the user of the error
                let alert = UIAlertController(title: "Please enable internet", message: "The app cannot function without internet", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(error) //print error
            }
            
            
            
        }
       
    }
    


}

