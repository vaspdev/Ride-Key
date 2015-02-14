//
//  Ride.swift
//  Ride Key
//
//  Created by VASP on 10/02/15.
//  Copyright (c) 2015 VASP. All rights reserved.
//

import UIKit

class Ride {

    var headgate: String = ""
    var name: String = ""
    var phone: String = ""
    var WaterRemain: String = ""
    var watertoday: String = ""
    init(headgate: String, name: String, phone: String,WaterRemain: String,watertoday:String)
    {
        self.headgate = headgate
        self.name = name
        self.phone = phone
        self.WaterRemain = WaterRemain
        self.watertoday = watertoday
        
    }

}
