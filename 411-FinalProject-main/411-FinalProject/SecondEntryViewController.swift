//
//  SecondEntryViewController.swift
//  411-FinalProject
//
//  Created by Juan Cocina on 12/8/21.
//

import UIKit

class SecondEntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var field: UITextField!
    var update: (() -> Void)?

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
    
    @IBAction func saveNewTask() {
        
        guard let text = field.text, !text.isEmpty else {
            return
        }

        guard let count = UserDefaults().value(forKey: "count2") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count2")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }

    
}
