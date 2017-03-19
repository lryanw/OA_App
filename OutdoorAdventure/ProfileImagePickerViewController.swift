//
//  ProfileImagePickerViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/14/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class ProfileImagePickerViewController: UIViewController {

    @IBOutlet weak var profileImage_1: UIImageView!
    @IBOutlet weak var profileImage_2: UIImageView!
    @IBOutlet weak var profileImage_3: UIImageView!
    @IBOutlet weak var profileImage_4: UIImageView!
    @IBOutlet weak var profileImage_5: UIImageView!
    @IBOutlet weak var profileImage_6: UIImageView!
    @IBOutlet weak var profileImage_7: UIImageView!
    @IBOutlet weak var profileImage_8: UIImageView!
    
    var tappedImage : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var imageArray : [UIImageView] = [profileImage_1, profileImage_2, profileImage_3, profileImage_4, profileImage_5, profileImage_6, profileImage_7, profileImage_8]
        
        for i in 0 ..< imageArray.count {
            imageArray[i] = ImageTransformer.roundImageView(imageView: imageArray[i])
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageArray[i].isUserInteractionEnabled = true
            imageArray[i].addGestureRecognizer(tapGestureRecognizer)
            
            imageArray[i] = ImageTransformer.roundImageView(imageView: imageArray[i])
        }
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        tappedImage = tapGestureRecognizer.view as! UIImageView
        
        performSegue(withIdentifier: "ProfileImagePickerToCreateProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ProfileImagePickerToCreateProfile") {
            let destinationVC = segue.destination as! CreateProfileViewController
            destinationVC.profileImage.image = tappedImage.image
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
