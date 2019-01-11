//
//  AlarmViewController.swift
//  Will It Rain Today
//
//  Created by Gabrielle Chandrasaputra on 1/1/19.
//  Copyright © 2019 Arizec. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

class AlarmViewController: UIViewController, UNUserNotificationCenterDelegate {
    var rainToday = ""
    
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()


    }
    
    func fetchData(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Time")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let minute = data.value(forKey: "minute") as! Int
                let hour = data.value(forKey: "hour") as! Int
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat =  "HH:mm"
                
                let date = dateFormatter.date(from: "\(hour):\(minute)")
                
                datePicker.date = date!

                
            }
            
            
        }
        catch{}

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Time")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    
    @IBAction func getTime(_ sender: Any) {
        // get date from datepicker
        let calendar = Calendar.current
        var components = calendar.dateComponents([.second, .hour, .minute], from: self.datePicker.date)
        components.second = 0
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let time = NSEntityDescription.insertNewObject(forEntityName: "Time", into: context)
        
        deleteAllRecords()
        
        time.setValue(components.minute, forKey: "minute")
        time.setValue(components.hour, forKey: "hour")
        
        fetchData()
        
        do{
            try context.save()
            print("SAVED")
        }
        catch{}
        
        // Will it rain today
        let sendNotif = Array(rainToday)[0] == "N" ? false : true
        
        //set notifications
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound];
        
        // Request authorization for daily notifications from user
        center.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        
        //notifications were denied
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
            }
        }
        
        // Content of notification message
        let content = UNMutableNotificationContent()
        content.title = sendNotif ? "It will rain today" : "No rain today"
        content.body =  sendNotif ? "It's raining today. Bring an Umbrella" :":)"
        content.sound = UNNotificationSound.default
        
        // triggers daily at set time
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // add trigger request to center
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                // Something went wrong
            }
            print("Added successfully")
        })
        
    }
}
