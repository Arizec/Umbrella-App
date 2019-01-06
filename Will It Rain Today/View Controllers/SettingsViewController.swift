//
//  SettingsViewController.swift
//  Will It Rain Today
//
//  Created by Gabrielle Chandrasaputra on 1/1/19.
//  Copyright © 2019 Arizec. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var tempUnit: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //show nav bar
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    @IBAction func onButtonTap(_ sender: Any) {
        //do something
    }
    

}

extension SettingsViewController{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? HomeViewController)?.finalTempType = tempUnit.titleForSegment(at: tempUnit.selectedSegmentIndex)! // pass back data to HomeViewController
    }
}
