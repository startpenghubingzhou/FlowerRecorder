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
    @IBOutlet weak var t_text: NSTextField!
    
    convenience required init?(coder: NSCoder) {
        self.init(coder: coder)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func save_and_exit(_ sender: Any) {
        AppDelegate.k_value = Double(k_text.stringValue)
        AppDelegate.b_value = Double(b_text.stringValue)
        AppDelegate.t_value = Double(t_text.stringValue)
        exit()
    }
    
    @IBAction func no_save_and_exit(_ sender: Any) {
        exit()
    }
    
    func exit() {
        self.close()
    }
}
