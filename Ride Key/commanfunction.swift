//
//  commanfunction.swift
//  Ride Key
//
//  Created by VASP on 04/02/15.
//  Copyright (c) 2015 VASP. All rights reserved.
//

import UIKit

class Commanfunction {
    
    
    func showAlert(message: String)
    {
        let alert = UIAlertView()
        alert.title = ""
        alert.message = message
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    

    
    func CreateTextFile(fileName: String, writeText: String)
    {
        let fileManager: NSFileManager = NSFileManager()
        let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory
        let nsUserDomainMask = NSSearchPathDomainMask.UserDomainMask
        if let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        {
            if paths.count > 0
            {
                if let dirPath = paths[0] as? String
                {
                    let writePath = dirPath.stringByAppendingPathComponent(fileName)
                    fileManager.removeItemAtPath(writePath, error:nil)
                    writeText.writeToFile(writePath, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
                }
            }
        }
        
    }
    
    
    func ReadFile(fileName: String) -> String
    {
        var readData: String = ""
        let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory
        let nsUserDomainMask = NSSearchPathDomainMask.UserDomainMask
        if let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        {
            if paths.count > 0
            {
                if let dirPath = paths[0] as? String
                {
                    let readPath = dirPath.stringByAppendingPathComponent(fileName)
                    readData = String(contentsOfFile: readPath, encoding: NSUTF8StringEncoding, error: nil)!
                }
            }
        }
        return readData
    }
    
    func validateDecimalno(textvalue: String) ->Bool
    {
        var alertFlg:Bool = false
        
        
        if(textvalue != "")
        {
            var flg: Bool = false
            var checkString = Array(textvalue)
            var dotCount:Int = 0
            for character in checkString
            {
                if(character == "0"){flg = false}
                else if(character == "1"){flg = false}
                else if(character == "2"){flg = false}
                else if(character == "3"){flg = false}
                else if(character == "4"){flg = false}
                else if(character == "5"){flg = false}
                else if(character == "6"){flg = false}
                else if(character == "7"){flg = false}
                else if(character == "8"){flg = false}
                else if(character == "9"){flg = false}
                else if(character == "."){flg = false
                    dotCount++}
                else {flg = true}
            }
            
            if(textvalue == ".")
            {
                flg = true
            }
            
            if(dotCount>1)
            {
                flg = true
            }
            
            
            if(!flg)
            {
                alertFlg = false
            }
            else
            {
                alertFlg = true
                 showAlert("this text field can only contain decimal number.")
                textvalue == ""
                
            }
        }
        return alertFlg
    }



}