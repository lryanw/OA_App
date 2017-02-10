//
//  CurrentlyClimbingViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/31/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class CurrentlyClimbingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var circleBackground: UIImageView!
    
    //Toolbar for shadows
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    
    var items: [(UIImage, String, String)] = [(UIImage(named: "ic_launcher.png")!, "Ryan Lee", "30 min"), (UIImage(named: "ic_launcher.png")!, "Ryan Lee", "30 min"), (UIImage(named: "ic_launcher.png")!, "Ryan Lee", "30 min")];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        circleBackground.image = ImageTransformer.maskRoundedImage(image: ImageTransformer.getImageWithColor(color: UIColor.white, size: circleBackground.frame.size), radius: Float(circleBackground.frame.size.width/2));
        
        //Shadows
        circleBackground.layer.shadowColor = UIColor.black.cgColor;
        circleBackground.layer.shadowOpacity = 1;
        circleBackground.layer.shadowOffset = CGSize.zero;
        circleBackground.layer.shadowRadius = 10;
        
        topBar.layer.shadowColor = UIColor.black.cgColor;
        topBar.layer.shadowOpacity = 1;
        topBar.layer.shadowOffset = CGSize.zero;
        topBar.layer.shadowRadius = 10;
        
        bottomBar.layer.shadowColor = UIColor.black.cgColor;
        bottomBar.layer.shadowOpacity = 1;
        bottomBar.layer.shadowOffset = CGSize.zero;
        bottomBar.layer.shadowRadius = 10;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Number of items in the CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    //Sets up the cell in the CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currentlyClimbingCell", for: indexPath) as! CurrentlyClimbingCollectionViewCell;
        
        //Sets the image in the CollectionView cell
        cell.profileImage.image = ImageTransformer.maskRoundedImage(image: items[indexPath.item].0, radius: Float(cell.profileImage.frame.width/2));
        cell.profileName.text = items[indexPath.item].1;
        cell.timeClimbing.text = items[indexPath.item].2;
        
        return cell;
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
