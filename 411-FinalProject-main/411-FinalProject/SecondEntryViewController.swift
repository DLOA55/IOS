//
//  SecondEntryViewController.swift
//  411-FinalProject
//
//  Created by Juan Cocina and Deangelo Aguilar on 12/8/21.
//

import UIKit

class SecondEntryViewController: UIViewController, UITextFieldDelegate {
    
    var update: ((_ task: String)-> Void)?
    
    @IBOutlet var field: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNewTask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveNewTask()
        
        return true
    }
    
    @objc func saveNewTask() {
        guard let text = field.text, !text.isEmpty else {
            return
        }
        update?(text)
        navigationController?.popViewController(animated: true)
    }

    
}
