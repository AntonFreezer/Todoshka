//
//  TaskTodoTableViewCell.swift
//  Todoshka
//
//  Created by Anton Kholodkov on 23.07.2023.
//

import UIKit
import SnapKit


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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Customize the appearance or perform animations based on the selected state
        if selected {
            // Add animation for when the cell is selected
            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.contentView.alpha = 0.5 // For example, fade out the cell content
                }
            } else {
                self.contentView.alpha = 0.5 // Without animation, just set the desired state directly
            }
        } else {
            // Reset the appearance for when the cell is deselected
            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.contentView.alpha = 1.0 // For example, fade in the cell content
                }
            } else {
                self.contentView.alpha = 1.0 // Without animation, just set the desired state directly
            }
        }
    }
    
}
