//
//  CalendarViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/15/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //UI objects
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var currentCalendar: Calendar?;
    var animationFinished = true;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        if let currentCalendar = currentCalendar {
            monthLabel.text = CVDate(date: Date(), calendar: currentCalendar).globalDescription
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        let timeZoneBias = 480 // (UTC+08:00)
        currentCalendar = Calendar.init(identifier: .gregorian)
        if let timeZone = TimeZone.init(secondsFromGMT: -timeZoneBias * 60) {
            currentCalendar?.timeZone = timeZone
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        calendarView.commitCalendarViewUpdate();
        menuView.commitMenuViewUpdate();
    }
    
    //Updates the Month Label when scrolled
    func presentedDateUpdated(_ date: CVDate) {
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransform(translationX: 0, y: offset)
            updatedMonthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
            
            UIView.animate(withDuration: 0.35, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
                self.monthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransform.identity
                
            }) { _ in
                
                self.animationFinished = true
                self.monthLabel.frame = updatedMonthLabel.frame
                self.monthLabel.text = updatedMonthLabel.text
                self.monthLabel.transform = CGAffineTransform.identity
                self.monthLabel.alpha = 1
                updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }
    
    //UITableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell", for: indexPath) as! calendarTableViewCell;
        return cell;
    }
    
    //Segues
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
    
    @IBAction func toCurrentlyClimbing(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CalendarToCurrentlyClimbing", sender: sender);
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

//CVCalendarViewDelegate, CVCalendarMenuViewDelegate Handling
extension CalendarViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    //Required Implementation
    func presentationMode() -> CalendarMode {
        return CalendarMode.monthView;
    }
    
    func firstWeekday() -> Weekday {
        return Weekday.sunday;
    }
}

//CVCalendar Appearance Handling
extension CalendarViewController: CVCalendarViewAppearanceDelegate {
    
    func dayLabelWeekdayDisabledColor() -> UIColor {
        return UIColor.lightGray
    }
    
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 0
    }
    
    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont { return UIFont.systemFont(ofSize: 17) }
}

