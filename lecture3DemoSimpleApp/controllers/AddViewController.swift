//
//  AddViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by Zhansaya on 19.01.2021.
//

import UIKit

class AddViewController: UIViewController {

   
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var deadlineField: UITextField!
    @IBOutlet weak var statusSlider: UISlider!
    var delegate: SecondViewControllerDelegate?
    
    var addCallback: ((_ title: String, _ deadline: String, _ status: Int)-> Void)?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        let title = self.titleField.text
        let deadline = self.deadlineField.text
        if deadline == "" || title == "" {return}
        addCallback?( title!, deadline!, Int(statusSlider.value))
        navigationController?.popViewController(animated: true)
    }
    
    

     
     // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
