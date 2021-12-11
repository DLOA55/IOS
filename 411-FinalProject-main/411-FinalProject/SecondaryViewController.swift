//
//  SecondViewController.swift
//  411-FinalProject
//
//  Created by Deangelo Aguilar on 12/7/21.
//

import UIKit
class SecondaryViewController: UIViewController, UITableViewDelegate{
    var index = -1
    var element = [[String]()]
    @IBOutlet var tableView: UITableView!
    
    /*
    @IBAction func home_button(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    */
    
     override func viewDidLoad() {
        super.viewDidLoad()
         
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
         
         //setup
         if !UserDefaults().bool(forKey: "setup2") {
             UserDefaults().set(true, forKey: "setup2")
             UserDefaults().set(0, forKey: "count2")
             print("count")
             print("count2")
             
         }
         
         updateTasks()
    }
    /*
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
     */
    


    
    func updateTasks() {
        //remove all before resetting
        element[index].removeAll()
        
        guard let count = UserDefaults().value(forKey: "count2") as? Int else {
            return
        }
        //my issue with updating the amount of tasks is in this for loop
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                //print("task")
                print(task)
                element[index].append(task)
            }
        }
        //load new tasks
        tableView.reloadData()
    }
    
    
    /*
    func taskRemoved(sending: String) {

        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }

        // if the value in UserDefaults matches what was removed from the array
        // then remove that (issues with duplicate list titles)
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                if task == sending {
                    UserDefaults().removeObject(forKey: "task_\(x+1)")
                    return
                }
            }
        }
    }
    */
    
    @IBAction func didTapAdd() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "secondentry") as! SecondEntryViewController
        vc.title = "New Task"
        
        vc.update = { //reload the tables
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
         
        navigationController?.pushViewController(vc, animated: true)
    }


}




extension SecondaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return element[index].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskcell", for: indexPath)
        cell.textLabel?.text = element[index][indexPath.row]
        
        return cell
    }
    /*
    //deleting a cell
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            //delete from the array
            let sending: String = element[index][indexPath.row]
            print(sending)
            
            element[index].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            taskRemoved(sending: sending)
        
            tableView.endUpdates()
        }
    }
     */
}

