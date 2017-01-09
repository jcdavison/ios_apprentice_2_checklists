//
//  ItemDetailViewController.swift
//  ChecklistsJD
//
//  Created by Programming Motha Fucka, Do You Speak It? on 1/5/17.
//  Copyright © 2017 StartupLandia. All rights reserved.
//

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}

import UIKit


class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    
    
    

    
    
    // add the outlet that represents the thingy in the view... (always the same pattern)
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    weak var delegate: ItemDetailViewControllerDelegate?
    
    // add a function that pays attention to the length of the value of the text field
    // and enable the done button in the navigation controller if the value > 0
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // NSString is using type intference and type coercion to take a swift string and replace it with
        // NSString which is the obj-c object and much more powerful, and the source of the replacingChar()
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneButton.isEnabled = (newText.length > 0)
        return true
    }
    
    @IBOutlet weak var newItemTextField: UITextField!
    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            newItemTextField.text = item.text
            doneButton.isEnabled = true
        }
    }
    
    
    
    // note that @IBAction methods as a rule don't return anything
    @IBAction func done() {
        if let item = itemToEdit {
            item.text = newItemTextField.text!
            delegate?.itemDetailViewController(self, didFinishEditing: item)
        } else {
            let item = ChecklistItem()
            item.text = newItemTextField.text!
            item.checked = false
            delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
        
    }
    
    @IBAction func cancel() {
        // delegate method calls frequently take self to be used whene delegate is used in multiple places
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    // i'm kind of still unclear what the IndexPath does
    // the ? or ! on the return indicator () -> Type tells swift that nil is a possibility
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newItemTextField.becomeFirstResponder()
    }
    
}
