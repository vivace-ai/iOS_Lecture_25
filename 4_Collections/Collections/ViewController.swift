//
//  ViewController.swift
//  Collections
//
//  Created by Kim Young Hee on 2025-02-18.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var toDoItems = ["Buy Groceries", "Go to the Gym", "Practice Coding", "Play wth Cat"]
    
    
    @IBOutlet weak var tableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
 
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for : indexPath)
        cell.textLabel?.text = toDoItems[indexPath.row]
        return cell
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Item", message: "Add your to-do items", preferredStyle: .alert)
    }
    
}


