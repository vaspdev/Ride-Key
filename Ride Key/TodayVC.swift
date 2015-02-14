//
//  TodayVC.swift
//  Ride Key
//
//  Created by VASP on 09/02/15.
//  Copyright (c) 2015 VASP. All rights reserved.
//

import UIKit

class TodayVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var cf = Commanfunction()
    @IBOutlet var tableView1: UITableView!
    @IBOutlet var webv: UIWebView!
    var Headgatelist = [String]()
    var namelist = [String]()
    var phonelist = [String]()
    var completelist = [String]()
    var headgates: String = ""
    var name :String = ""
    var phone :String = ""
    var SelectedTableIndex: Int!
    var html1: String =
    "<html><body style='background-color:black'><table style='width:100%; color: white;font-family: Helvetica Neue;' cellspacing='0' cellpadding='0'><tr>" +
         "<td style='width:15%; height:50px; font-weight: bold; text-align:left;font-family: Helvetica Neue;'>Complete</td>" +
        "<td style='width:25%; height:50px; font-weight: bold; text-align:left;font-family: Helvetica Neue;'>Headgate</td>" +
        "<td style='width:25%; height:50px; font-weight: bold; text-align:left;font-family: Helvetica Neue;'>Name</td>" +
        "<td style='width:25%; height:50px; font-weight: bold; text-align:left;font-family: Helvetica Neue;'>Phone</td>" +
    "</tr></table></body></html>"

        
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        loaddata()
        tableView1.reloadData()
        
        let path = NSBundle.mainBundle().pathForResource("test", ofType: "json")
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
            var complete :String = JsonRow["complete"] as String
            completelist.append(complete)
       

            var today = Today(headgate: headgates, name: name, phone: phone, complete: complete)
            RideOrder.sharedInstance.today.addObject(today)
            tableView1.reloadData()
        }
        

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
    
    func HtmlCellGenerator(index: Int) -> String
    {
        var obj: Today = RideOrder.sharedInstance.today[index] as Today
        var htmlCell1: String = "<html><body style='background-color: white'><table style='width:100%; font-family: Helvetica Neue; color: #555555;' cellspacing='0' cellpadding='0'><tr><td style='width:25%; height:35px'text-align:center;font-family: Helvetica Neue; color: #555555;>" // Headgate
        var htmlCell2: String = "</td><td style='width:25%; height:35px; text-align:left;font-family: Helvetica Neue; color: #555555;'>" // Name
        var htmlCell3: String = "</td><td style='width:20%; height:35px; text-align:left;font-family: Helvetica Neue; color: #555555;'>" // Phone
        var htmlCell4: String = "</td><td style='width:15%; height:35px; text-align:right;font-family: Helvetica Neue; color: #555555;'>" //
        var htmlCell5: String = "</td></tr></table></body></html>"
        
        var HtmlCell: String = htmlCell1 + obj.headgate + htmlCell2 + obj.name + htmlCell3 + obj.phone +  htmlCell5
        return HtmlCell
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //-----------tableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  RideOrder.sharedInstance.today.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.frame.size.height = 50
        var wv: UIWebView = UIWebView();
        var wid:NSString = "\(tableView.frame.size.width)"
        var width: Float = wid.floatValue - 200
        var w: CGFloat = CGFloat(width)
        wv.frame = CGRectMake(100.0, 0.0, w, 35)
        wv.scrollView.scrollEnabled = false;
        wv.scrollView.bounces = false;
        var htmls: String = HtmlCellGenerator(indexPath.row)
        wv.loadHTMLString(htmls, baseURL: nil)
        cell.addSubview(wv)
        var ch: UISwitch = UISwitch()
        ch.frame = CGRectMake(15.0, 8.0, 20.0, 31.0)
        cell.addSubview(ch)
      
        var obj: Today = RideOrder.sharedInstance.today[indexPath.row] as Today
            if(obj.complete == "1")
            {
                ch.setOn(true, animated: true)
            }
            else
            {
                ch.setOn(false, animated: true)
            }

        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let image = UIImage(named: "Button-Yellow.png") as  UIImage?
        var button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(w + 100.0, 8.0, 100.0, 29.0)
        button.setBackgroundImage(image, forState: UIControlState.Normal)
        button.setTitle("Adjust", forState: UIControlState.Normal)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        button.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cell.addSubview(button)
        return cell
    }
    
    func buttonAction(sender:UIButton!)
    {
        cf.showAlert("button tapped")
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        SelectedTableIndex = indexPath.row

    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
    }
    //--------------------
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval)
    {
        tableView1.reloadData()
    }
   
}
