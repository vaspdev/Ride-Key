//
//  ViewController.swift
//  Ride Key
//
//  Created by VASP on 02/02/15.
//  Copyright (c) 2015 VASP. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate, UITextFieldDelegate{
    
    @IBOutlet var ButtonSave: UIButton!
    @IBOutlet weak var Headgatetext: UITextField!
    @IBOutlet weak var Nametext: UITextField!
    @IBOutlet weak var Phonetext: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var webv: UIWebView!
    @IBOutlet var PickerView: UIView!
    @IBOutlet var mview: UIView!
    @IBOutlet var Reasontext: UITextField!
    @IBOutlet var Switchoverride: UISwitch!
    @IBOutlet var amounttext: UITextField!
    @IBOutlet var datepicker: UIDatePicker!
    
    var headgatepickerview: UIPickerView = UIPickerView()
    var SelectedTableIndex: Int!
    var cf = Commanfunction()
    var Headgatelist = [String]()
    var namelist = [String]()
    var phonelist = [String]()
    var arrayheader = NSMutableArray()
    var html1: String =
    "<html><body style='background-color:black'><table style='width:90%; color: white;font-family: Helvetica Neue;' cellspacing='0' cellpadding='0'><tr>" +
        "<td style='width:25%; height:25px; font-weight: bold; text-align:center;font-family: Helvetica Neue;'>Headgate</td>" +
        "<td style='width:30%; height:25px; font-weight: bold; text-align:center;font-family: Helvetica Neue;'>Name</td>" +
        "<td style='width:20%; height:20px; font-weight: bold; text-align:center;font-family: Helvetica Neue;'>Phone</td>" +
        "<td style='width:25%; height:15px; font-weight: bold; text-align:center;font-family: Helvetica Neue;'>Amount</td>" +
        "<td style='width:25%; height:15px; font-weight: bold; text-align:center;font-family: Helvetica Neue;'>Override</td>" +
    "</tr></table></body></html>"
    
    @IBOutlet weak var tableView1: UITableView!


    
    override func viewDidLoad()
    {
        ButtonSave.hidden = true
        var DictArr = NSMutableArray()
        super.viewDidLoad()
        loaddata()
        let path = NSBundle.mainBundle().pathForResource("json", ofType: "txt")
        var error: NSError?
        let JsonData: NSData = NSData(contentsOfFile: path!)!
        let jsonObject = NSJSONSerialization.JSONObjectWithData(JsonData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        let JsonRows = jsonObject.valueForKey("Headgates") as NSArray
        var rowCount = JsonRows.count
        for var i = 0 ; i < rowCount ; i++
        {
            let JsonRow = JsonRows[i] as NSDictionary
            DictArr.addObject(JsonRow)
            var headgates: String = JsonRow["Headgate"] as String
            Headgatelist.append(headgates)
            var name:String = JsonRow["Name"] as String
            namelist.append(name)
            var phone :String = JsonRow["Phone"] as String
            phonelist.append(phone)
        }

        Headgatetext.inputView = headgatepickerview
        self.headgatepickerview.delegate = self
  
  
        tableView1.reloadData()
        
        let earlyDate = NSCalendar.currentCalendar().dateByAddingUnit(
            NSCalendarUnit.CalendarUnitDay,
            value: 3,
            toDate: NSDate(),
            options: NSCalendarOptions.WrapComponents)
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        var strDate = dateFormatter.stringFromDate(earlyDate!)
        date.text = strDate

        var customView:UIView = UIView (frame: CGRectMake(0, 100, 320, 160));
        datepicker = UIDatePicker(frame: CGRectMake (350, 0, 320, 160));
        datepicker.datePickerMode = UIDatePickerMode.Date
        datepicker.setDate(earlyDate!, animated: false)
        datepicker.addTarget(self, action: Selector("pickDate"), forControlEvents: UIControlEvents.ValueChanged)
        customView .addSubview(datepicker);
        date.inputView = customView;
        var doneButton:UIButton = UIButton (frame: CGRectMake(100, 100, 100, 44));
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.addTarget(self, action: "dismissDatePicker", forControlEvents: UIControlEvents.TouchUpInside);
        doneButton.backgroundColor = UIColor .blackColor();
        date.inputAccessoryView = doneButton;
        date.delegate = self
        
        amounttext.keyboardType = UIKeyboardType.NumbersAndPunctuation
        self.mview.endEditing(true)
    }
    
   
    func ValidateDate(selectdDate: NSDate, mode: Int)
      {
        let currentdate = NSDate()
        let earlyDate = NSCalendar.currentCalendar().dateByAddingUnit(
            NSCalendarUnit.CalendarUnitDay,
            value: 2,
            toDate: NSDate(),
            options: NSCalendarOptions.WrapComponents)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let startDate:String = dateFormatter.stringFromDate(earlyDate!)
   
        if(mode == 1)
         {
            if(dateFormatter.stringFromDate(selectdDate) == dateFormatter.stringFromDate(currentdate))
            {
                date.layer.borderWidth = 0
            }
            else
            {
                if(selectdDate.compare(currentdate) == NSComparisonResult.OrderedDescending)
                {
                    
                    if(selectdDate.compare(earlyDate!) == NSComparisonResult.OrderedAscending)
                    {
                        date.layer.borderWidth = 0
                    }
                    else
                    {
                        date.layer.borderWidth = 2
                        date.layer.borderColor = UIColor.redColor().CGColor
                        date.layer.cornerRadius = 10
                    }
                    
                }
                else
                {
                    date.layer.borderWidth = 2
                    date.layer.borderColor = UIColor.redColor().CGColor
                    date.layer.cornerRadius = 10
                }
            }
         }
        if(mode == 2)
         {
            if(dateFormatter.stringFromDate(selectdDate) < dateFormatter.stringFromDate(currentdate))
            {
                date.layer.borderWidth = 2
                date.layer.borderColor = UIColor.redColor().CGColor
                date.layer.cornerRadius = 10
            }
            else
            {
                date.layer.borderWidth = 0
            }
         }
     }
    
    
    @IBAction func amount(sender: AnyObject)
     {
        var amounts = cf.validateDecimalno(amounttext.text)
        if(amounttext.text < "0")
        {
            cf.showAlert("Enter Positive amount")
        }
     }
   
    func pickDate()
     {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        date.text = dateFormatter.stringFromDate(datepicker.date)
        
        var dateFormatter2 = NSDateFormatter()
        dateFormatter2.dateFormat = "MM/dd/yyyy"
        var dt: NSDate = dateFormatter2.dateFromString(date.text)!
        if(Switchoverride.on)
        {
            
            ValidateDate(dt,mode: 1)
        }
        else
        {
           ValidateDate(dt,mode: 2)
        }
        
        
     }
    
    func dismissDatePicker()
     {
        self.view.endEditing(true)
     }
    
    // picker view methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView!)-> Int
     {
        return 1
     }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int)-> Int
     {
         return Headgatelist.count
     }
    
    func pickerView(pickerView: UIPickerView!,titleForRow row: Int, forComponent component: Int)-> String
     {
        var element: String = "\(Headgatelist[row])"
        return element
     }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
     {
        
        Headgatetext.text = Headgatelist[row] as String
        var index: Int = 0
        for var v = 0 ; v < Headgatelist.count ; v++
        {
            if(Headgatelist[v] == Headgatelist[row])
            {
                index = v
                break
            }
        }
        
       Nametext.text = namelist[index] as String
       Phonetext.text = phonelist[index]  as String
       view.endEditing(true)
     }
    //-------------------

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func Submitbuttontappted(sender: AnyObject)
     {
        var headgate: String = Headgatetext.text
        var name: String = Nametext.text
        var Phone: String = Phonetext.text
        var amount: String = amounttext.text
        if(amount == "")
        {
            amount = "0"
        }
        var Date: String = date.text
        var Reason:String = Reasontext.text
        var override: Int!
        if(Switchoverride.on)
        {
            override = 1
        }
        else
        {
            override = 0
        }
        
        if(headgate == "")
        {
            cf.showAlert("Please Select Headgate")
        }
        else
        {
            var order = Addorder(headgate: headgate, name: name, Phone: Phone, amount: amount, overrider: override,Date:Date,Reason:Reason)
            RideOrder.sharedInstance.order.addObject(order)
            tableView1.reloadData()
        }
    
         clear()
        view.endEditing(true)
    }

    
    @IBAction func savebuttontapped(sender: AnyObject)
     {
        var headgate: String = Headgatetext.text
        var name: String = Nametext.text
        var Phone: String = Phonetext.text
        var amount: String = amounttext.text
        var Date: String = date.text
        var Reason:String = Reasontext.text
        var override: Int!
        if(Switchoverride.on)
        {
            override = 1
        }
        else
        {
            override = 0
        }
        RideOrder.sharedInstance.order[SelectedTableIndex] = Addorder(headgate: headgate, name: name, Phone: Phone, amount: amount, overrider: override,Date:Date,Reason:Reason)
        tableView1.reloadData()
        ButtonSave.hidden = true
        clear()
     }
    
    
    func clear()
    {
        Headgatetext.text = ""
        Nametext.text = ""
        Phonetext.text = ""
        amounttext.text = ""
        date.text = ""
        Reasontext.text = ""
        Switchoverride.setOn(false, animated: true)
        date.layer.borderWidth = 0

        
      let earlyDate = NSCalendar.currentCalendar().dateByAddingUnit(
            NSCalendarUnit.CalendarUnitDay,
            value: 3,
            toDate: NSDate(),
            options: NSCalendarOptions.WrapComponents)
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        var strDate = dateFormatter.stringFromDate(earlyDate!)
        date.text = strDate
    }
    
    
    @IBAction func Switchonoff(sender: AnyObject)
    {
        var dateFormatter2 = NSDateFormatter()
        dateFormatter2.dateFormat = "MM/dd/yyyy"
        var dt: NSDate = dateFormatter2.dateFromString(date.text)!
        if Switchoverride.on
        {
            Reasontext.enabled = true
            ValidateDate(dt,mode:1)
        }
        else
        {
            Reasontext.enabled = false
            Reasontext.text = ""
            date.layer.borderWidth = 0
            ValidateDate(dt,mode: 2)
        }
    }
    
    
    
    //tableheaderview
    
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
    
    //-----------tableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  RideOrder.sharedInstance.order.count
    }
    
    func HtmlCellGenerator(index: Int) -> String
    {
        var obj: Addorder = RideOrder.sharedInstance.order[index] as Addorder
        var htmlCell1: String = "<html><body style='background-color: white'><table style='width:100%;font-family: Helvetica Neue; color: #555555;'  cellspacing='0' cellpadding='0'><tr><td style='width:25%; height:35px'>" // Headgate
        var htmlCell2: String = "</td><td style='width:25%; height:35px; text-align:left;font-family: Helvetica Neue; color: #555555;'>" // Name
        var htmlCell3: String = "</td><td style='width:20%; height:35px; text-align:left;font-family: Helvetica Neue; color: #555555;'>" // Phone
        var htmlCell4: String = "</td><td style='width:15%; height:35px; text-align:right;font-family: Helvetica Neue; color: #555555;'>" // amount
        var htmlCell5: String = "</td><td style='width:15%; height:35px; text-align:right;font-family: Helvetica Neue; color: #555555;'>"// override
        var htmlCell6: String = "</td></tr></table></body></html>"
        var htmlCheckbox:String = ""
        if(obj.overrider == 1)
        {
            htmlCheckbox = "<input type='checkbox' checked='true' disabled >"
        }
        else if(obj.overrider == 0)
        {
            htmlCheckbox = "<input type='checkbox' disabled >"
        }
        var HtmlCell: String = htmlCell1 + obj.headgate + htmlCell2 + obj.name + htmlCell3 + obj.Phone + htmlCell4 + obj.amount + htmlCell5 + htmlCheckbox + htmlCell6
        return HtmlCell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.frame.size.height = 50
        var wv: UIWebView = UIWebView();
        var wid:NSString = "\(tableView.frame.size.width)"
        var width: Float = wid.floatValue - 100
        var w: CGFloat = CGFloat(width)
        wv.frame = CGRectMake(0.0, 0.0, w,35)
        wv.scrollView.scrollEnabled = false;
        wv.scrollView.bounces = false;
        var htmls: String = HtmlCellGenerator(indexPath.row)
        wv.loadHTMLString(htmls, baseURL: nil)
        cell.addSubview(wv)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    func ShowSelectedCellData(index: Int)
    {
        var obj: Addorder = RideOrder.sharedInstance.order[index] as Addorder
        Headgatetext.text = obj.headgate
        Nametext.text = obj.name
        Phonetext.text = obj.Phone
        amounttext.text = obj.amount
        
        if(obj.overrider == 1)
        {
            Switchoverride.setOn(true, animated: true)
        }
        else if(obj.overrider == 0)
        {
            Switchoverride.setOn(false, animated: true)
        }
        
        date.text = obj.Date
        Reasontext.text = obj.Reason
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        ShowSelectedCellData(indexPath.row)
        SelectedTableIndex = indexPath.row
        ButtonSave.hidden = false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            RideOrder.sharedInstance.order.removeObjectAtIndex(indexPath.row)
            tableView1.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    //--------------------
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval)
    {
        tableView1.reloadData()
    }
    
}

