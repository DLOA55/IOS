//
//  EntryViewController.swift
//  411-FinalProject
//
//  Created by Juan Cocina and Deangelo Aguilar on 11/9/21.
//

import UIKit

class EntryViewController: UIViewController,  UITextFieldDelegate{
    
    var update: ((_ newList: List)-> Void)?
    
    @IBOutlet var field: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        // programming the button that saves tasks
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveList))
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveList()
        return true
    }

    @objc func saveList() {
        guard let text = field.text, !text.isEmpty else {
            return
        }
        let newList = List(title: text, tasks: nil)
        update?(newList)
        navigationController?.popViewController(animated: true)
        
        
    }

}
