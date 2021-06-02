//
//  AppDelegate.swift
//  FlowerRecorder
//
//  Created by penghubingzhou on 2021/4/27.
//  Copyright © 2021 penghubingzhou. All rights reserved.
//

/* BSD 3-Clause License
 
   Copyright (c) 2021, penghubingzhou
   All rights reserved.
 
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:
 
   1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 
   2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 
   3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.
 
   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
   DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
   CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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

