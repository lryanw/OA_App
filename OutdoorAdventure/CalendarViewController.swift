//
//  CalendarViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/15/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toGallery(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CalendarToGallery", sender: sender);
        
    }
    
    @IBAction func toRockWall(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CalendarToRockWall", sender: sender);
    }
    
    @IBAction func toNews(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CalendarToNews", sender: sender);
    }
    
    @IBAction func toInfo(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CalendarToInfo", sender: sender);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
