//
//  RideOrder.swift
//  Ride Key
//
//  Created by VASP on 04/02/15.
//  Copyright (c) 2015 VASP. All rights reserved.
//

import UIKit

private let _RideOrder = RideOrder(order: NSMutableArray(),today: NSMutableArray(),ride: NSMutableArray())

class RideOrder
    {
        var order: NSMutableArray!
        var today: NSMutableArray!
         var ride: NSMutableArray!
    
    init(order: NSMutableArray,today: NSMutableArray,ride: NSMutableArray)
        {
            self.order = order
            self.today = today
            self.ride = ride
        }
    
    class var sharedInstance: RideOrder
    {
        return _RideOrder
    }
}





