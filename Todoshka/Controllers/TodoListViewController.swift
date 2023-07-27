//
//  ViewController.swift
//  Todoshka
//
//  Created by Anton Kholodkov on 22.07.2023.
//

import UIKit
import SnapKit


class TodoListViewController: UITableViewController {
    
    var tasksArray = [
        ["To get haircut"],
        ["To wash dishes"],
        ["Walk a dog"],
        ["Meet your friends and Shelby's at 5 and take shower before"],
//        ["Take bath"],
//        ["Read book"],
//        ["Share bed"],
//        ["Yoga class"],
//        ["Promenade"],
    ]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks To Do"
        
        if let tasks = defaults.array(forKey: "tasksArray") as? [[String]] {
            tasksArray = tasks
        }
        
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
        
        tableView.separatorStyle = .none
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
            
            if let text = textField.text, !text.isEmpty {
                self.tasksArray.append([text])
                
                self.defaults.set(self.tasksArray, forKey: "tasksArray")
                
                self.tableView.reloadData()
            }
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
        // hiding the first sectionHeader
        return section == 0 ? 15 : 4.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        tasksArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let text = tasksArray[indexPath.section][indexPath.row]
        
        var cell: TodoTableViewCell
        cell = tableView.dequeueReusableCell(
            withIdentifier: TaskCellType.task.rawValue,
            for: indexPath) as! TaskTodoTableViewCell
        
        
        cell.messageLabel.text = text
        cell.taskView.clipsToBounds = true
        cell.taskView.layer.cornerRadius = 5 //cell.contentView.bounds.height * 0.33
        
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
