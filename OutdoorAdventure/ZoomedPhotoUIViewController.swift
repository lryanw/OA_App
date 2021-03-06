//
//  ZoomedPhotoUIViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 2/21/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class ZoomedPhotoUIViewController: UIViewController {
    
    //==========GLOBAL VARIABLES===========
    
    @IBOutlet weak var deleteButton: UIButton!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var picMenu: UIView!
    
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageviewTrailingConstraint: NSLayoutConstraint!
    
    var currImage : UIImage!
    var currImageSize : CGSize!
    var currImagePath : String!
    var senderString : String!
    
    //First Name, Last Name, Email, ProfileImage, IsEmployee
    var user: [(String, String, String, Int, Bool)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Hides the delete button if not an employee
        if(!user[0].4 || senderString != "Gallary") {
            deleteButton.isHidden = true
        }
        
        imageView.image = currImage
        imageView.frame.size = (currImageSize)!
        
        let tapSelector : Selector = #selector(ZoomedPhotoUIViewController.handleTap)
        let tapGesture = UITapGestureRecognizer(target: self, action: tapSelector)
        tapGesture.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    func handleTap() {
        picMenu.isHidden = !picMenu.isHidden;
    }
    
    //===========REMOVE PIC FROM DB===========
    
    @IBAction func deletePic() {
        let alertController = UIAlertController(title: "Delete Picture?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in self.removeFromDB() }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func removeFromDB() {
        let imageRem = ImageRemoveRequest(imagePath: currImagePath)
        imageRem.downloadItems()
        imageRem.removeImageFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    //==========SET UP SCROLLVIEW FOR IMAGE==========
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / (imageView.bounds.width)
        let heightScale = size.height / (imageView.bounds.height)
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        
        scrollView.maximumZoomScale = max(widthScale+25, heightScale+25)
        scrollView.zoomScale = minScale
    }

    
    fileprivate func updateConstraintsForSize(_ size: CGSize) {
        
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageviewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
    //==========SEGUES==========
    
    @IBAction func toGallary(sender: UIButton) {
        if(senderString == "Gallary") {
            performSegue(withIdentifier: "ImageViewerToGallary", sender: sender)
        } else if(senderString == "News") {
            performSegue(withIdentifier: "ImageViewerToNews", sender: sender)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ImageViewerToGallary") {
            let destinationVC = segue.destination as! MyGalleryViewController
            destinationVC.user = self.user
        } else if(segue.identifier == "ImageViewerToNews") {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.user = self.user
        }
    }

}

extension ZoomedPhotoUIViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)  // 4
    }
}

