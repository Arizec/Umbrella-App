//
//  AlarmViewController.swift
//  Will It Rain Today
//
//  Created by Gabrielle Chandrasaputra on 1/1/19.
//  Copyright © 2019 Arizec. All rights reserved.
//

import UIKit
import NotificationCenter

class AlarmViewController: UIViewController {

 
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    
    @IBAction func getTime(_ sender: Any) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day,.month,.year], from: self.datePicker.date)
        if let day = components.day, let month = components.month, let year = components.year {
            let dayString = String(day)
            let monthString = String(month)
            let yearString = String(year)
            
            print(dayString, monthString, yearString)
        }
        
    }
    
    func scheduleNotification(){
        
    }

}
