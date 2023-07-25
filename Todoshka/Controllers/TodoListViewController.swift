//
//  ViewController.swift
//  Todoshka
//
//  Created by Anton Kholodkov on 22.07.2023.
//

import UIKit
import SnapKit


class TodoListViewController: UITableViewController {
    
    var texts = [["To get haircut"],
                 ["To wash dishes"],
                 ["Walk a dog"],
                 ["Meet your friends and Shelby's at 5 and take shower before"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks To Do"
        configureTableView()
        configureNavigationView()
    }
    //MARK: - Views Configuration
    func configureTableView() {
        
        tableView.sectionHeaderTopPadding = 0
        view.backgroundColor = UIColor(named: Colors.TableViewBackgroundColor.rawValue)
//        tableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        
        tableView.register(
            TaskTodoTableViewCell.self,
            forCellReuseIdentifier: TaskCellType.task.rawValue)
        
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func configureNavigationView() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        addButton.tintColor = .darkGray
        navigationItem.rightBarButtonItem = addButton
    }
    //MARK: - Actions
    @objc func addButtonPressed() {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new task", message: nil, preferredStyle: .alert)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "e.g. call mom tomorrow morning"
            textField = alertTextField
        }
        
        let action  = UIAlertAction(title: "Add task", style: .default) { action in
            let text = textField.text
            guard text != nil else { return }
            self.texts.append([text!])
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - UITableView Delegate & Data Source
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? .leastNonzeroMagnitude : 4.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        texts.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let text = texts[indexPath.section][indexPath.row]
        
        var cell: TodoTableViewCell
        cell = tableView.dequeueReusableCell(
            withIdentifier: TaskCellType.task.rawValue,
            for: indexPath) as! TaskTodoTableViewCell
        
        cell.messageLabel.text = text
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        switch selectedCell?.accessoryType {
        case .checkmark:
            selectedCell?.accessoryType = .none
        default:
            selectedCell?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
