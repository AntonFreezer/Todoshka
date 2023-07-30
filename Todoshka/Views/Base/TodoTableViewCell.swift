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

class TodoTableViewCell: UITableViewCell {
        
    lazy var taskView: UIView = {
        let taskView = UIView()
        taskView.backgroundColor = UIColor(named: Colors.TaskTodoTableViewCellColor.rawValue)
        return taskView
    }()
    
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
        configureDecorations()
        configureLayout()
    }
    
    func configureDecorations() {
        self.backgroundColor = UIColor(named: Colors.TableViewBackgroundColor.rawValue)
        self.selectionStyle = .none
    }
    
    func configureLayout() {
        contentView.addSubview(taskView)
        taskView.addSubview(messageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
