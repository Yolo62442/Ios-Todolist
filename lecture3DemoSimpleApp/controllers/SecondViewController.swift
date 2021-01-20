//
//  SecondViewController.swift
//  lecture3DemoSimpleApp
//
//  Created by admin on 06.01.2021.
//

import UIKit


protocol SecondViewControllerDelegate {
    func addItem(title: String?, deadline: String?, status: Int? )
}
class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arr = [ToDoItem]()
    let cellId = "TableViewCell"
    var count = 6
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main page"
        self.configureTableView()
    }
    
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(identifier: "AddViewController") as! AddViewController
        vc.delegate = self
        vc.addCallback = {
            title, deadline, status in
            self.addItem(title: title, deadline: deadline, status: status)
        }
        navigationController?.pushViewController(vc, animated: true)
          
    }
    
    
}


extension SecondViewController: SecondViewControllerDelegate{
    
    func addItem(title: String?, deadline: String?, status: Int?)  {
        print("hi there")
        tableView.delegate = self
        self.arr.append(ToDoItem(id: count, title: title, deadLine: deadline, status: status))
        count += 1
        tableView.reloadData()
    }
    
}




extension SecondViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        let item = arr[indexPath.row]
        cell.id = item.id ?? 0
        cell.titleLabel.text = item.title
        cell.subTitleLabel.text = item.deadLine
        cell.statusProgress.progress = Float(item.status!)/100
        
    
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action,view, completionHandler) in
                self.arr.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                completionHandler(true)
            }
            deleteAction.backgroundColor = .systemRed
        
        let editAction = UIContextualAction(style: .destructive, title: "Edit") { (action,view, completionHandler) in
            let vc = self.storyboard?.instantiateViewController(identifier: "EditViewController") as! EditViewController
            vc.delegate = self
            vc.title1 = self.arr[indexPath.row].title ?? ""
            vc.deadline1 = self.arr[indexPath.row].deadLine ?? ""
            vc.status1 = self.arr[indexPath.row].status ?? 0
            vc.editCallback = {
                title, deadline, status in
                let id = self.arr[indexPath.row].id
                self.arr[indexPath.row] = ToDoItem(id: id, title: title, deadLine: deadline, status: status)
                tableView.reloadData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
            completionHandler(true)
        }
        editAction.backgroundColor = .blue
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
            return configuration
    }



}
