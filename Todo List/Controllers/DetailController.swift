//
//  DetailController.swift
//  Todo List
//
//  Created by David Solis on 8/2/18.
//  Copyright © 2018 Peaking. All rights reserved.
//

import UIKit
import CoreData

class DetailController: UIViewController {
    
    @IBOutlet weak var textFieldBottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var textFieldCenterY: NSLayoutConstraint!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var isCompletedSwitch: UISwitch!
    @IBOutlet weak var backgroundColorPicker: UIPickerView!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let pickerDataSource = ["", "Green", "Blue", "Purple"]
    var item: Item? {
        didSet {
            if let item = item {
                detailTextField.text = item.text
                isCompletedSwitch.isOn = item.isCompleted
                selectPickerViewFor(item)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        backgroundColorPicker.dataSource = self
        backgroundColorPicker.delegate = self
    }
    
    @IBAction func isCompeletedChanged(_ sender: UISwitch) {
        if let item = item {
            item.isCompleted = sender.isOn
            context.saveChanges()
        }
    }
    
    @IBAction func save(_ sender: Any) {
        if let item = item, let newText = detailTextField.text {
            item.text = newText
            context.saveChanges()
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        if let item = item {
            context.delete(item)
            context.saveChanges()
            navigationController?.popViewController(animated: true)
        }
    }
}
