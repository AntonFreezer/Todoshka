//
//  CustomTableViewCell.swift
//  Todoshka
//
//  Created by Anton Kholodkov on 22.07.2023.
//

import UIKit

enum TaskCellType: String {
    case task
    case subtask
}

// Базовая ячейка для сборки, от нее наследуются более детальные ячейки (e.g. TaskTodoTableViewCell)

class TodoTableViewCell: UITableViewCell {
    
    lazy var messageLabel: UILabel = {
        let messageLabel = UILabel(frame: .zero)
        messageLabel.textColor = .black
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return messageLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    func configureLayout() {
        self.backgroundColor = UIColor(named: Colors.TaskTodoTableViewCellColor.rawValue)
        contentView.addSubview(messageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
