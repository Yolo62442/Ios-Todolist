//
//  EditViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by Zhansaya on 20.01.2021.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var deadlineField: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var statusSlider: UISlider!
    var delegate: SecondViewControllerDelegate?
    var title1 = ""
    var deadline1 = ""
    var status1 = 0
    
    var editCallback: ((_ title: String, _ deadline: String, _ status: Int)-> Void)?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.text = title1
        deadlineField.text = deadline1
        statusSlider.value = Float(status1)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func changeAction(_ sender: UIButton) {
        let title = self.titleField.text
        let deadline = self.deadlineField.text
        if deadline == "" || title == "" {return}
        editCallback?( title!, deadline!, Int(statusSlider.value))
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
