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
    
    //First Name, Last Name, Email, ProfileImage, IsEmployee
    var user: [(String, String, String, Int, Bool)]!
    
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
        let startHour = calendar.component(.hour, from: startTime.date)
        let startMin = calendar.component(.minute, from: startTime.date)
        
        let endHour = calendar.component(.hour, from: endTime.date)
        let endMin = calendar.component(.minute, from: endTime.date)
        
        if((endHour < startHour) || (endHour == startHour && endMin <= startMin)) {
            let alertController = UIAlertController(title: "ALERT", message: "INVALID TIME", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            print("Heere")
            //DATABASE SEND
            let userClimbingModel = UserClimbingAddRequest(email: user[0].2, startHour: startHour, startMin: startMin, endHour: endHour, endMin: endMin)
            userClimbingModel.downloadItems()
            
            performSegue(withIdentifier: "TimePickerToCurrentlyClimbing", sender: sender)
        }
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
