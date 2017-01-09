//
//  ViewController.swift
//  ChecklistsJD
//
//  Created by Programming Motha Fucka, Do You Speak It? on 1/3/17.
//  Copyright © 2017 StartupLandia. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    // the ! below allows the checklist object to have nil value
    // which allows for a nil checklist until one is passed in, dynamic stuff yo
    // the official swifty term for this is 'unwrapped optional' and should be used sparingly
    // so as not to get into nil dereferencing problems
    var checklist: Checklist!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(checklist!)")
        title = checklist.name
        // Do any additional setup after loading the view, typically from a nib.
        // a nib is a storyboard with only one view controller
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        // tell the story board to build 5 rows
        return checklist.items.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // populate each row with a prototype cell, i'm a little unclear on the cell/row explanation
        
        // let cell, cell is a local constant not a variable
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistItem", for: indexPath)
        let item = checklist.items[indexPath.row]
        // const label corresponds to the object in the cell with the numerical tag 1000
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        checklist.items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }
 
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath ) {
        if let cell = tableView.cellForRow(at: indexPath ) {
            let item = checklist.items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    @IBAction func fooThingy () {
    
    }
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        print("cancel foo shit")
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        print("contents of text logged from view controll \(item.text)")
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
        
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = checklist.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    // connect the current controller as a delegat to the ItemDetailViewController
    // the final step in the delegate creation process
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    
    
}
