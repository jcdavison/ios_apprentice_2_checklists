//
//  Checklist.swift
//  ChecklistsJD
//
//  Created by Programming Motha Fucka, Do You Speak It? on 1/7/17.
//  Copyright © 2017 StartupLandia. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
    var name = ""
    var items = [ChecklistItem]()
    init(name: String) {
        self.name = name
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
    }
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }

}
