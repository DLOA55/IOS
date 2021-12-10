//
//  SecondViewController.swift
//  411-FinalProject
//
//  Created by Deangelo Aguilar on 12/7/21.
//

import UIKit
class SecondaryViewController: UIViewController, UITableViewDelegate{
    var index = -1
    var inList = 0
    var maketitle = "Task"
    var element = [[String]()]
    @IBOutlet var tableView: UITableView!
    
    
    @IBAction func home_button(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()
         
        self.title = maketitle
        tableView.delegate = self
        tableView.dataSource = self
         
         if UserDefaults().value(forKey: "list_\(2)") == nil{
             UserDefaults().set(false,forKey: "setup")
             print ("changedBool in 2VC")
         }
         if !UserDefaults().bool(forKey: "setup") { //if hasn't been set up, set defaults
             UserDefaults().set(true, forKey: "setups")
             UserDefaults().set(0, forKey: "counts")
         }
         updateTasks()
         
     }
    
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
     




    func updateTasks() {
        //remove all before resetting
        
        guard let arrAmount = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        guard let counts = UserDefaults().value(forKey: "counts") as? Int else {
            return
            }
        print("in second vc")
        print(counts)
        print(arrAmount)
        //index = arrAmount
        element[counts].removeAll()
        //my issue with updating the amount of tasks is in this for loop
       var tempArr = [[String]()]
        for _ in 0..<arrAmount {
                    tempArr.append([String]())
                    print("appended")
                }
        element  = tempArr
        for x in 0..<counts {
            print("in the counts for loop")
            if let task = UserDefaults().value(forKey: "lists_\(x+1)") as? String {
                print("task")
                print(task)
                element[x].append(task)
                
            }
        }
        //load new tasks
        tableView.reloadData()
    }
    
    
    
    func taskRemoved(sending: String) {

        guard let count = UserDefaults().value(forKey: "counts") as? Int else {
            return
        }

        // if the value in UserDefaults matches what was removed from the array
        // then remove that (issues with duplicate list titles)
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "lists_\(x+1)") as? String {
                if task == sending {
                    UserDefaults().set(count-1,forKey: "counts")
                    UserDefaults().removeObject(forKey: "lists_\(x+1)")
                    return
                }
            }
        }
    }
    
    @IBAction func didTappAdd() {
        
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
        return inList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = element[index][indexPath.row]
        
        return cell
    }
    
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
}


