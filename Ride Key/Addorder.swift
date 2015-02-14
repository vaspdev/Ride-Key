//
//  Addorder.swift
//  Ride Key
//
//  Created by VASP on 05/02/15.
//  Copyright (c) 2015 VASP. All rights reserved.
//

import UIKit

class Addorder {

    var headgate: String = ""
    var name: String = ""
    var Phone: String = ""
    var amount: String = ""
    var overrider: Int = 0
    var Date: String = ""
    var Reason: String = ""
    
    init(headgate: String, name: String, Phone: String, amount: String, overrider: Int, Date: String, Reason: String)
    {
        self.headgate = headgate
        self.name = name
        self.Phone = Phone
        self.amount = amount
        self.overrider = overrider
        self.Date = Date
        self.Reason = Reason
    }
}
