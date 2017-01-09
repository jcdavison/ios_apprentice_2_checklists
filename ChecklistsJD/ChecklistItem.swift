//
//  CheckListItem.swift
//  ChecklistsJD
//
//  Created by Programming Motha Fucka, Do You Speak It? on 1/5/17.
//  Copyright © 2017 StartupLandia. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
    var text = "foo"
    var checked = false
    
    func toggleChecked()  {
        checked = !checked
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
    
    override init() {
        super.init()
    }
}
