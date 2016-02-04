//
//  Video.swift
//  MagicalRecord
//
//  Created by Trương Thắng on 2/4/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import Foundation
class Video {
    var id: String = NSUUID().UUIDString
    var startTime: NSTimeInterval = NSTimeIntervalSince1970
    var endTime: NSTimeInterval = NSTimeIntervalSince1970
    var fileName: String = ""
}