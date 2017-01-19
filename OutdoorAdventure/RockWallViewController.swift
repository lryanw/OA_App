//
//  RockWallViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/13/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class RockWallViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    func getImageWithColor(color: UIColor) -> UIImage {
        let size = CGSize(width: 50, height: 50);
        let rect = CGRect(origin: .zero, size: size);
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        color.setFill();
        UIRectFill(rect);
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return image;
    }
    
    var items: [(UIColor, String, String, String)] = [(UIColor.red ,"Up Up And Away", "Ryan Lee", "I+"), (UIColor.red ,"Up Up And Away", "Ryan Lee", "I+"), (UIColor.red ,"Up Up And Away", "Ryan Lee", "I+")];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell", for: indexPath) as! routeTableViewCell;

        cell.routeImage.image = getImageWithColor(color: UIColor.black);
        cell.routeName.text = items[indexPath.row].1;
        cell.routeSetter.text = items[indexPath.row].2;
        cell.routeRating.text = items[indexPath.row].3;
        
        return cell;
    }
    
    @IBAction func toGallary(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RockWallToGallary", sender: sender);
    }
    
    @IBAction func toNews(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RockWallToNews", sender: sender)
    }
    
    @IBAction func toCalendar(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RockWallToCalendar", sender: sender);
    }
    
    @IBAction func toInfo(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RockWallToInfo", sender: sender);
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
