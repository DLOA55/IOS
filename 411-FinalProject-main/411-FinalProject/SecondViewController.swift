//
//  SecondViewController.swift
//  411-FinalProject
//
//  Created by Deangelo Aguilar on 12/7/21.
//

import UIKit
class SecondViewController: UIViewController{
    
    @IBAction func home_button(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //put the add that you deleted in here
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad() //additional setup after loading the view
       // will have to fifure out how to pass information between viewcontrollers
        //self.title = taskLists[indexPath.row]
        if !UserDefaults().bool(forKey: "setup")
            { //if hasn't been set up, set defaults
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
            }
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() //dispose of any resources that can be recreated
    }
    
}
