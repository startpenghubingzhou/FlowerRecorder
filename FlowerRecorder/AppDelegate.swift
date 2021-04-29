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

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var dst: NSTextField!
    @IBOutlet weak var src: NSTextField!
    @IBOutlet weak var runbutton: NSButton!
    @IBOutlet weak var Browser_dst: NSButton!
    @IBOutlet weak var Browser_src: NSButton!
    @IBOutlet weak var kbsetbutton: NSButton!
    
    var openPanel:NSOpenPanel?
    public static var k : Double?, b : Double?
    
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
    
    @IBAction func set_kbvalue(_ sender: NSButton) {
        var array : NSArray?
        var ptr : AutoreleasingUnsafeMutablePointer<NSArray?>?
        var ptrtmp : UnsafeMutablePointer<NSArray>
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

