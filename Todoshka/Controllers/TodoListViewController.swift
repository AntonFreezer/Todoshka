//
//  ViewController.swift
//  Todoshka
//
//  Created by Anton Kholodkov on 22.07.2023.
//

import UIKit
import SnapKit
import CoreData

class TodoListViewController: UITableViewController {
    
    //MARK: - Variables
    private let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    private var tasksArray = [[Task]]()
    
    //MARK: - UI Components
    var resultsSearchController = UISearchController(searchResultsController: nil)
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        configureNavigationView()
        configureTableView()
        
        //        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    //MARK: - Views Configuration
    func configureTableView() {
        title = "Tasks To Do"
        
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        
        view.backgroundColor = UIColor(named: Colors.TableViewBackgroundColor.rawValue)
        tableView.tableHeaderView?.backgroundColor = UIColor(named: Colors.NavBarColor.rawValue)
        
        tableView.register(
            TaskTodoTableViewCell.self,
            forCellReuseIdentifier: TaskCellType.task.rawValue)
    }
    
    func configureNavigationView() {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showResultsSearchController))
        
        navigationItem.rightBarButtonItems = [addButton, searchButton]
    }
    
    private func configureSearchController() {
        resultsSearchController.searchResultsUpdater = self
        
        resultsSearchController.searchBar.sizeToFit()
        resultsSearchController.searchBar.barTintColor = UIColor(named: Colors.SearchBarColor.rawValue)
        
        resultsSearchController.searchBar.placeholder = "Search for the task"
    }
    //MARK: - Add
    @objc func addButtonPressed() {
        
        AlertManager.addTaskAlert(on: self) { strings in
            let taskText = strings.first
            
            let newTask = Task(context: self.context)
            newTask.text = taskText
            newTask.isDone = false
            
            self.tasksArray.append([newTask])
            
            self.tableView.beginUpdates()
            UIView.animate(withDuration: 0.33, animations: {
                let indexSet = IndexSet(integer: self.tasksArray.count - 1)
                self.tableView.insertSections(indexSet, with: .left)}) { _ in
                    self.saveTasks()
                }
            self.tableView.endUpdates()
        }
    }
    //MARK: - UITableView Delegate & Data Source
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // making the space between navBar and first task
        super.tableView(tableView, heightForHeaderInSection: section)
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
        cell.taskView.clipsToBounds = true
        cell.taskView.layer.cornerRadius = 7
        
        return cell
    }
    //MARK: - Delete
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let taskForCell = tasksArray[indexPath.section][indexPath.row]
        taskForCell.isDone = !taskForCell.isDone
        
        tableView.beginUpdates()
        UIView.animate(withDuration: 0.33, animations: {
            self.tasksArray.remove(at: indexPath.section)
            let indexSet = IndexSet(arrayLiteral: indexPath.section)
            
            tableView.deleteSections(indexSet, with: .right)}) { _ in
                
                self.context.delete(taskForCell)
                self.saveTasks()
            }
        
        tableView.endUpdates()
    }
    
    //MARK: - Core Data
    func saveTasks() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Error when saving context \(error)")
        }
    }
    
    func loadData() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            let requestResult = try context.fetch(request)
            fetchTasksPerSection(from: requestResult)
        } catch {
            print("Error when fetching \(Task.self) from context")
        }
        
        func fetchTasksPerSection(from tasksRequestResult: [Task]) {
            for task in tasksRequestResult {
                tasksArray.append([task])
            }
        }
    }
}
    //MARK: - Search
    extension TodoListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    private func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }
    
    @objc private func showResultsSearchController() {
        if tableView.tableHeaderView == nil {
            tableView.tableHeaderView = resultsSearchController.searchBar
            
            
        } else {
            tableView.tableHeaderView = nil
        }
    }
}
