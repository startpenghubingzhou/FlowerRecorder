//
//  AppDelegate.swift
//  FlowerRecorder
//
//  Created by penghubingzhou on 2021/4/27.
//  Copyright © 2021 penghubingzhou. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    //main window outlet
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var dst: NSTextField!
    @IBOutlet weak var src: NSTextField!
    @IBOutlet weak var runbutton: NSButton!
    @IBOutlet weak var Browser_dst: NSButton!
    @IBOutlet weak var Browser_src: NSButton!
    @IBOutlet weak var setting: NSMenuItem!
    
    var openPanel:NSOpenPanel?
    
    var a : kbset = kbset(windowNibName: NSNib.Name(rawValue: "kbset"))
    
    var actrl : NSWindowController?
    
    open static var k_value : Double?, b_value : Double?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        runbutton.alphaValue = 0.4
        runbutton.isEnabled = false
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func Browser_dst_push(_ sender: NSButton) {
        //open a panel to choose path of destination file
        openPanel = NSOpenPanel()
        
        //set some properties for necessary
        openPanel!.canChooseFiles = true
        openPanel!.canChooseDirectories = false
        openPanel!.allowsMultipleSelection = false
        openPanel!.allowedFileTypes = ["jpg", "jpeg"]
        openPanel!.message = "请选择目标图片文件:"

        //callbaak function to save filepath to string
        func savestringtotext(result: NSApplication.ModalResponse) {
            if(result == NSApplication.ModalResponse.OK){
                let str:NSURL = openPanel!.urls[0] as NSURL
                let tmp = str.absoluteString
                let filepath = tmp?.replacingOccurrences(of: "file://", with: "")
                dst.placeholderString = filepath
            }
        }
        
        openPanel!.beginSheetModal(for: window, completionHandler: savestringtotext)
    }
    
    
    @IBAction func Browser_src_push(_ sender: NSButton) {
        //open a panel to choose path of destination file
        openPanel = NSOpenPanel()
        
        //set some properties for necessary
        openPanel!.canChooseFiles = true
        openPanel!.canChooseDirectories = false
        openPanel!.allowsMultipleSelection = false
        openPanel!.allowedFileTypes = ["jpg", "jpeg"]
        openPanel!.message = "请选择样本图片文件:"
        
        //callbaak function to save filepath to string
        func savestringtotext(result: NSApplication.ModalResponse) {
            if(result == NSApplication.ModalResponse.OK){
                let str:NSURL = openPanel!.urls[0] as NSURL
                let tmp = str.absoluteString
                let filepath = tmp?.replacingOccurrences(of: "file://", with: "")
                src.placeholderString = filepath
            }
        }
        
        openPanel!.beginSheetModal(for: window, completionHandler: savestringtotext)
    }
    
    @IBAction func setting_set(_ sender: NSMenuItem) {
        
        self.actrl = (a.window?.windowController)!
        
        self.actrl?.showWindow(self)
        
        self.actrl?.window?.makeKeyAndOrderFront(self)
    }
    
    @IBAction func runpush(_ sender: NSButton) {
        let srcpath = src.placeholderString
        
        let dstpath = dst.placeholderString

        let argstr = ["DynamicCast", srcpath, dstpath]
        
        var cargs = argstr.map{strdup($0)}

        _ = DynamicCast.exec(3, withargv: &cargs)
        
        for ptr in cargs {
            free(ptr)
        }
    }
}

