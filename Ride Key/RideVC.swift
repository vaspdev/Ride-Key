//
//  RideVC.swift
//  Ride Key
//
//  Created by VASP on 10/02/15.
//  Copyright (c) 2015 VASP. All rights reserved.
//

import UIKit

class RideVC: UIViewController {

    @IBOutlet var webv: UIWebView!
    @IBOutlet var wv: UIWebView!
    var Headgatelist = [String]()
    var namelist = [String]()
    var phonelist = [String]()
    var waterRemaininglist = [String]()
    var watertodaylist = [String]()
    var HTMLCell = [String]()
    var arrayheader = NSMutableArray()
    var html1: String =
    "<html><body style='background-color:black'><table style='width:100%; color: white;font-family: Helvetica Neue;' cellspacing='0' cellpadding='0'><tr>" +
        "<td style='width:25%; height:50px; font-weight: bold; text-align:left;font-family: Helvetica Neue;'>Headgate</td>" +
        "<td style='width:25%; height:50px; font-weight: bold; text-align:left;font-family: Helvetica Neue;'>Name</td>" +
        "<td style='width:25%; height:50px; font-weight: bold; text-align:left;font-family: Helvetica Neue;'>Phone</td>" +
        "<td style='width:15%; height:50px; font-weight: bold; text-align:left;font-family: Helvetica Neue;'>Water Remaining</td>" +
        "<td style='width:10%; height:50px; font-weight: bold; text-align:right;font-family: Helvetica Neue;'>Water Today</td>" +
    "</tr></table></body></html>"
    
    var CompleteHtml: String = ""

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        loaddata()
        
        let path = NSBundle.mainBundle().pathForResource("ride", ofType: "json")
        var error: NSError?
        let JsonData: NSData = NSData(contentsOfFile: path!)!
        let jsonObject = NSJSONSerialization.JSONObjectWithData(JsonData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        let JsonRows = jsonObject.valueForKey("Headgates") as NSArray
        var rowCount = JsonRows.count
        for var i = 0 ; i < rowCount ; i++
        {
            let JsonRow = JsonRows[i] as NSDictionary
            var headgates: String = JsonRow["Headgate"] as String
            Headgatelist.append(headgates)
            var name:String = JsonRow["Name"] as String
            namelist.append(name)
            var phone :String = JsonRow["Phone"] as String
            phonelist.append(phone)
            var waterremaining : String = JsonRow["WaterRemaining"] as String
            waterRemaininglist.append(waterremaining)
            var watertoday :String = JsonRow["waterToday"] as String
            watertodaylist.append(watertoday)
            
            
            var htmlCell1: String = "<tr><td style='width:25%; height:55px; text-align:left ;font-family: Helvetica Neue;border-bottom: 1px solid Silver; color: #555555; '>" // Headgate
            var htmlCell2: String = "</td><td  style='width:25%; height:55px; text-align:left ;font-family: Helvetica Neue;border-bottom: 1px solid Silver; color: #555555;'>" // Name
            var htmlCell3: String = "</td><td  style='width:25%; height:55px; text-align:left ;font-family: Helvetica Neue;border-bottom: 1px solid Silver; color: #555555;'>" // Phone
            var htmlCell4: String = "</td><td  style='width:15%; height:55px; text-align:left ;font-family: Helvetica Neue;border-bottom: 1px solid Silver; color: #555555;'>" // waterremain
            var htmlCell5: String = "</td><td  style='width:10%; height:55px; text-align:center ;font-family: Helvetica Neue;border-bottom: 1px solid Silver; color: #555555;'>"// watertoday
            var htmlCell6: String = "</td></tr>"

            var Html: String = htmlCell1 + headgates + htmlCell2 + name + htmlCell3 + phone + htmlCell4 + waterremaining + htmlCell5 + watertoday + htmlCell6
            
            CompleteHtml = CompleteHtml + Html
        }
        
        getdata(CompleteHtml)
    }
    
    func loaddata()
    {
        var wid:NSString = "\(html1)"
        var width: Float = wid.floatValue - 100
        var w: CGFloat = CGFloat(width)
        webv.frame = CGRectMake(0.0, 0.0,w,55)
        webv.scrollView.scrollEnabled = false;
        webv.scrollView.bounces = false;
        let htmls: String! = wid
        webv.loadHTMLString(wid, baseURL: nil)
    }
    
    func getdata(html: String)
    {
        var htmlCellH: String = "<html><body style='background-color: white'><table style='width:100%;font-family: Helvetica Neue;' cellspacing='0' cellpadding='0'>"
        var htmlCellf: String = "</table></body></html>"
        var HTML :String = htmlCellH + html + htmlCellf
        var wid:NSString = "\(HTML)"
        var width: Float = wid.floatValue - 100
        var w: CGFloat = CGFloat(width)
        wv.frame = CGRectMake(0.0, 0.0,w,35)
        wv.scrollView.scrollEnabled = true;
        wv.scrollView.bounces = true;
        wv.loadHTMLString(wid, baseURL: nil)
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
