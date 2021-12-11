//
//  SecondEntryViewController.swift
//  411-FinalProject
//
//  Created by Juan Cocina on 12/8/21.
//

import UIKit

class SecondEntryViewController: UIViewController, UITextFieldDelegate {
    
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
    
    @IBAction func saveNewTask() {
        // here you add the saving of the task
    }

    
}
