//
//  kbset.swift
//  FlowerRecorder
//
//  Created by penghubingzhou on 2021/5/1.
//  Copyright © 2021 penghubingzhou. All rights reserved.
//

import Cocoa

class kbset: NSWindowController {
    @IBOutlet weak var OKButton: NSButton!
    @IBOutlet weak var CancelButton: NSButton!
    @IBOutlet weak var k_text: NSTextField!
    @IBOutlet weak var b_text: NSTextField!
    
    convenience required init?(coder: NSCoder) {
        self.init(coder: coder)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        k_text.focusRingType = NSFocusRingType.exterior
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func save_and_exit(_ sender: Any) {
        AppDelegate.k_value = Double((k_text.placeholderString)!)
        AppDelegate.b_value = Double((b_text.placeholderString)!)
        exit()
    }
    
    @IBAction func no_save_and_exit(_ sender: Any) {
        exit()
    }
    
    func exit() {
        self.close()
    }
}
