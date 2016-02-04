//
//  VideoEntity+CoreDataProperties.swift
//  MagicalRecord
//
//  Created by Trương Thắng on 2/4/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension VideoEntity {

    @NSManaged var id: String?
    @NSManaged var startTime: NSTimeInterval
    @NSManaged var endTime: NSTimeInterval
    @NSManaged var fileName: String?

}
