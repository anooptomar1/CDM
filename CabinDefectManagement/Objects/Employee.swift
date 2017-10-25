//
//  Employee.swift
//  CabinDefectManagement
//
//  Created by qwerty on 25/10/17.
//  Copyright © 2017 Sim Kim Wee. All rights reserved.
//

import Foundation

struct Employee {
    var username : String??
    var name : String??
    var password : String??
    var startTime : Date
    var endTime : Date
    var type : Type
    }
enum Type : String {
    case technician = "technician"
    case supervisor = "supervisor"
    case planner = "planner"
    
    static let AllValues = [technician,supervisor,planner]
}
