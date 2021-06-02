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
    @IBOutlet weak var processbar: NSProgressIndicator!
    @IBOutlet weak var processbartext: NSTextField!
    
    var openPanel:NSOpenPanel?

    //sql db path for operation
    var dbpath:NSString?

    //kbset window info
    var kbwindow : kbset = kbset(windowNibName: NSNib.Name(rawValue: "kbset"))
    var kbwindowctrl : NSWindowController?
    open static var k_value : Double?, b_value : Double?, t_value : Double?

    //data windows info
    var sqldatawindow : datawindow = datawindow(windowNibName: NSNib.Name(rawValue: "datawindow"))
    var sqldatawindowctrl : NSWindowController?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        dbpath = Bundle.main.path(forResource: "Database", ofType: "db")! as NSString
        DynamicCast.dynamicCast_init(dbpath!.utf8String)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        DynamicCast.dynamicCast_deinit();
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

        //callback function to save filepath to string
        func savestringtotext(result: NSApplication.ModalResponse) {
            if(result == NSApplication.ModalResponse.OK){
                let str:NSURL = openPanel!.urls[0] as NSURL
                let tmp = str.absoluteString
                let filepath = tmp?.replacingOccurrences(of: "file://", with: "")
                dst.stringValue = (filepath?.removingPercentEncoding)!
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
                src.stringValue = (filepath?.removingPercentEncoding)!
            }
        }
        
        openPanel!.beginSheetModal(for: window, completionHandler: savestringtotext)
    }
    
    @IBAction func setting_set(_ sender: NSMenuItem) {
        self.kbwindowctrl = (kbwindow.window?.windowController)!
        
        self.kbwindowctrl?.showWindow(self)
        
        self.kbwindowctrl?.window?.makeKeyAndOrderFront(self)
    }
    
    @IBAction func open_datawindow(_ sender: NSMenuItem) {        
        self.sqldatawindowctrl = (sqldatawindow.window?.windowController)!
        
        self.sqldatawindowctrl?.showWindow(self)
        
        self.sqldatawindowctrl?.window?.makeKeyAndOrderFront(self)
    }
    
    @IBAction func runpush(_ sender: NSButton) {
        let srcpath = src.stringValue
        
        let dstpath = dst.stringValue

        let argstr = ["DynamicCast", srcpath, dstpath, ]
        
        var cargs = argstr.map{strdup($0)}

        let k = AppDelegate.k_value
        let b = AppDelegate.b_value
        let t = AppDelegate.t_value
    
        processbar.isHidden = false
        processbartext.isHidden = false
        
        processbar.style = .spinning
        
        processbar.sizeToFit()
        
        processbar.startAnimation(nil)
        
        let basicdata = DynamicCast.getbasedata((srcpath as NSString).utf8String!, kvalue: k!, bvalue: b!, tvalue: t!)
        
        let scoredata = DynamicCast.getscoredata((dstpath as NSString).utf8String!, withflowerdata: basicdata, sqlite_number: 1)

        DynamicCast.writedata(scoredata)
        
        processbar.stopAnimation(nil)
        processbar.isHidden = true
        processbartext.isHidden = true
        
        for ptr in cargs {
            free(ptr)
        }
    }
}

