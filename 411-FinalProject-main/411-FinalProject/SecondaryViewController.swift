//
//  SecondViewController.swift
//  411-FinalProject
//
//  Created by Deangelo Aguilar and Juan Cocina on 12/7/21.
//

import UIKit

class SecondaryViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var nothingView: UIView!
    
    // MARK:- Properties
    var currentListIndex = 0
    var lists: [List] = []
    var maketitle = "Task"
    var update: ((_ lists: [List])-> Void)?
    
    // MARK:- LifeCycle Methods
     override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
     }
    
//    // MARK:- Actions
//    @IBAction func home_button(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//    }

}

// MARK:- Private Methods
extension SecondaryViewController {
    private func setupViews() {
        self.title = maketitle
        let addButton = UIBarButtonItem(title: "Add Task", style: .done, target: self, action: #selector(addTaskTapped))
        navigationItem.rightBarButtonItem = addButton
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        handleAvailability()
    }
    
    @objc private func addTaskTapped() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "secondentry") as! SecondEntryViewController
        vc.title = "New Task"
        vc.update = { task in //reload the tables
            DispatchQueue.main.async {
                if self.lists[self.currentListIndex].tasks != nil {
                    self.lists[self.currentListIndex].tasks?.append(task)
                } else {
                    self.lists[self.currentListIndex].tasks = [task]
                }
                self.saveLists()
                self.tableView.reloadData()
                self.update?(self.lists)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func saveLists() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(lists) {
            UserDefaults.standard.set(encoded, forKey: "Lists")
        }
        handleAvailability()
    }
    
    private func handleAvailability() {
        if lists[currentListIndex].tasks?.count == 0 || lists[currentListIndex].tasks == nil {
            setNothingView(alpha: 1)
        } else {
            setNothingView(alpha: 0)
        }
    }
    
    private func setNothingView(alpha: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.nothingView.alpha = alpha
        }
    }
}

// MARK:- TableView Delegate
extension SecondaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists[currentListIndex].tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = lists[currentListIndex].tasks?[indexPath.row]
        
        return cell
    }
    
    // deleting a cell
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            lists[currentListIndex].tasks?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveLists()
            update?(self.lists)
            tableView.endUpdates()
        }
    }
    //animation for cell deletion
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


