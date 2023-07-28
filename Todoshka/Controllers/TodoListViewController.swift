//
//  ViewController.swift
//  Todoshka
//
//  Created by Anton Kholodkov on 22.07.2023.
//

import UIKit
import SnapKit


class TodoListViewController: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: "Tasks.plist")
    
    
    var tasksArray: [[Task]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        
        loadData()
        configureNavigationView()
        configureTableView()
    }
    //MARK: - Views Configuration
    func configureTableView() {
        title = "Tasks To Do"
        tableView.sectionHeaderTopPadding = 0
        view.backgroundColor = UIColor(named: Colors.TableViewBackgroundColor.rawValue)
        
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
                self.tasksArray.append([Task(text: text)])
                self.saveTasks()
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
        
        let task = tasksArray[indexPath.section][indexPath.row]
        
        var cell: TodoTableViewCell
        cell = tableView.dequeueReusableCell(
            withIdentifier: TaskCellType.task.rawValue,
            for: indexPath) as! TaskTodoTableViewCell
        
        
        cell.messageLabel.text = task.text
        cell.accessoryType = task.isDone ? .checkmark : .none
        
        cell.taskView.clipsToBounds = true
        cell.taskView.layer.cornerRadius = 7
        
        return cell
    }
    //MARK: - UITableView Delegate - Accessory Type
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskForCell = tasksArray[indexPath.section][indexPath.row]
        taskForCell.isDone = !taskForCell.isDone
        
        saveTasks()
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    //MARK: - Working with Data
    func saveTasks() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(tasksArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error upon encoding tasks data, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadData() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                tasksArray = try decoder.decode([[Task]].self, from: data)
            } catch {
                print("Could not decode the Tasks array, \(error)")
            }
        }
    }
}
