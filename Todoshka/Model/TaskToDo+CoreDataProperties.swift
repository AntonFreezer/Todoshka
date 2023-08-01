//
//  TaskToDo+CoreDataProperties.swift
//  Todoshka
//
//  Created by Anton Kholodkov on 01.08.2023.
//
//

import Foundation
import CoreData


extension TaskToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskToDo> {
        return NSFetchRequest<TaskToDo>(entityName: "TaskToDo")
    }

    @NSManaged public var text: String
    @NSManaged public var isDone: Bool
    @NSManaged public var category: String?

}

extension TaskToDo : Identifiable {

}
