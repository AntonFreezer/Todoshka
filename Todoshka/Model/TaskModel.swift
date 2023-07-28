//
//  TaskModel.swift
//  Todoshka
//
//  Created by Anton Kholodkov on 27.07.2023.
//

class Task: Codable {
    var text: String
    var isDone: Bool
    
    init(text: String, done: Bool = false) {
        self.text = text
        self.isDone = done
    }
}
