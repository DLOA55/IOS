//
//  SecondEntryViewController.swift
//  411-FinalProject
//
//  Created by Juan Cocina on 12/8/21.
//

import UIKit

class SecondEntryViewController: UIViewController, UITextFieldDelegate {
    
    var update: (()-> Void)?
    
    @IBOutlet var field: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNewTask))
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveNewTask()
        
        return true
    }
    
    @objc func saveNewTask() {
        guard let text = field.text, !text.isEmpty else {
            return
        }
        //save tasks
        guard let count = UserDefaults().value(forKey: "counts") as? Int else{
            return
        }//keep track of tasks
        let newCounts = count + 1
        
        UserDefaults().set(newCounts, forKey: "counts") //update the count
        UserDefaults().set(text, forKey: "lists_\(newCounts)")
        
        //updates ViewController
        update?()
        navigationController?.popViewController(animated: true)
        
    }

    
}
