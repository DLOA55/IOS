//
//  ViewController.swift
//  411-FinalProject
//
//  Created by Juan Cocina and Deangelo Aguilar on 10/28/21.
//

import UIKit

struct List: Codable {
    let title: String
    var tasks: [String]?
}

class ViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var nothingView: UIView!
    
    // MARK:- Properties
    private var lists: [List] = []
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadLists()
    }
    
    // MARK:- Actions
    @IBAction func didTappAdd() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        vc.title = "New List"
        vc.update = { newList in //reload the tables
            DispatchQueue.main.async {
                self.updateTasks(newList: newList)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK:- Private Methods
extension ViewController {
    private func setupViews() {
        self.title = "Task Lists"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func loadLists() {
        if let lists = UserDefaults.standard.value(forKey: "Lists") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: lists) as [List] {
                self.lists = objectsDecoded
                tableView.reloadData()
            }
        }
        handleAvailability()
    }
    
    private func saveLists() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(lists) {
            UserDefaults.standard.set(encoded, forKey: "Lists")
        }
        handleAvailability()
    }
    
    private func updateTasks(newList: List) {
        lists.append(newList)
        tableView.reloadData()
        saveLists()
    }
    
    private func handleAvailability() {
        if lists.count == 0 {
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
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row].title
        
        return cell
    }
    
    //deleting a cell
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            lists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveLists()
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ov = storyboard?.instantiateViewController(withIdentifier: "Second") as! SecondaryViewController
        ov.maketitle = lists[indexPath.row].title
        ov.currentListIndex = indexPath.row
        ov.lists = lists
        ov.update = { lists in
            self.lists = lists
            tableView.reloadData()
        }
        self.navigationController?.pushViewController(ov, animated: true)
    }
}

