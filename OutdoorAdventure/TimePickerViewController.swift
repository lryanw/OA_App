//
//  TimePickerViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/19/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {

    //DatePickers
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var endTime: UIDatePicker!
    
    //First Name, Last Name, Email,
    var user: [(String, String, String, UIImage, Bool)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startClimbing(sender: UIButton) {
        
        //Get times from DatePicker
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: startTime.date)
        var min = calendar.component(.minute, from: startTime.date)
        var startString = "\(hour) \(min)"
        
        hour = calendar.component(.hour, from: endTime.date)
        min = calendar.component(.minute, from: endTime.date)
        var endString = "\(hour) \(min)"
        
        //DATABASE SEND
        
        performSegue(withIdentifier: "TimePickerToCurrentlyClimbing", sender: sender)
    }
    
    @IBAction func cancel(sender: UIButton) {
        performSegue(withIdentifier: "TimePickerToCurrentlyClimbing", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TimePickerToCurrentlyClimbing") {
            let destinationVC = segue.destination as! CurrentlyClimbingViewController
            destinationVC.user = self.user
        }
    }
}
