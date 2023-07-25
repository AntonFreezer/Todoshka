//
//  TaskTodoTableViewCell.swift
//  Todoshka
//
//  Created by Anton Kholodkov on 23.07.2023.
//

import UIKit
import SnapKit

// Здесь идет конфигурация ячейки под бизнес-логику, пока что оставил пустым, буду здесь констрейнты прописывать
class TaskTodoTableViewCell: TodoTableViewCell {
    private let taskBubbleImageName = "TaskBubble"
    
    override func configureLayout() {
        super.configureLayout()
        setupConstraints()
    }
    
    func setupConstraints() {
        let messagePadding = UIEdgeInsets(top: 25, left: 10, bottom: 25, right: 30)

        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(messagePadding)
        }
        
        
        
        
        
    }
}
