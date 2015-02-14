//
//  JsonCreater.swift
//  Ride Key
//
//  Created by VASP on 02/02/15.
//  Copyright (c) 2015 VASP. All rights reserved.
//

import UIKit

/*class JsonCreater: UIViewController {

   func createJSON() -> String
    {
        /*var rideobj = NSMutableArray()
        var cnt: Int = 0
        var Ride_array: NSMutableArray = NSMutableArray()
        if(Ride_array != nil)
        {
            Ride_array = RideOrder.sharedInstance.headgate.Hg_dictonary as NSMutableArray
            cnt = Ride_array.count
        }
        for var x = 0 ; x < cnt ; x++
        {
            let obj = Ride_array[x] as Ride_array
            var dict = ["Rh": obj.Rh,
                "Rn": obj.Rn,
                "RP": obj.RP,]
            rideobj.insertObject(dict, atIndex: rideobj.count)
        }
        var dictonary_Ride = ["Ride_array": rideobj]
   */
       // var root_dir = ["Headers": RideOrder.sharedInstance.headgate.Hg_dictonary]
        //var jsonString: NSString = JSONStringify(root_dir)
       // var jsonString1: NSString = convertStringToBase64(jsonString)
        //return jsonString1
    }
    func convertStringToBase64(string: String) -> String
    {
        var utf8str = string.dataUsingEncoding(NSUTF8StringEncoding)!
        var base64str = utf8str.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.EncodingEndLineWithLineFeed)
        return base64str
    }
    
    func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String
    {
        var options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
        if NSJSONSerialization.isValidJSONObject(value)
        {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: options, error: nil)
            {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding)
                {
                    return string
                }
            }
        }
        return ""
    }


    }*/
