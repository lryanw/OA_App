//
//  CurrentlyClimbingViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/31/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class CurrentlyClimbingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Segues
    @IBAction func toGallery(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CurrentlyClimbingToGallery", sender: sender)
    }
    
    @IBAction func toRockWall(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CurrentlyClimbingToRockWall", sender: sender);
    }
    
    @IBAction func toNews(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CurrentlyClimbingToNews", sender: sender);
    }
    
    @IBAction func toCalendar(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CurrentlyClimbingToCalendar", sender: sender);
    }
    
    @IBAction func toInfo(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CurrentlyClimbingToInfo", sender: sender);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
