//
//  datawindow.swift
//  FlowerRecorder
//
//  Created by penghubingzhou on 2021/5/29.
//  Copyright © 2021 penghubingzhou. All rights reserved.
//

import Cocoa

extension String.Encoding {
    static let gb_18030_2000 = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)))
}

class datawindow: NSWindowController {
    @IBOutlet weak var datatable: NSTableView!

    //sql data numbers
    var rows:Int32?
    let cols = 8

    convenience required init?(coder: NSCoder) {
        self.init(coder: coder)
    }
    
    override func showWindow(_ sender: Any?) {
        var datasqlfscore = sqlfscore.init()
        var tmpcellview : NSTableCellView?
        
        super.windowDidLoad()
        
        rows = DynamicCast.getsize()
        
        if rows == 0 {
            return
        }
        
        // initialize the columns
        datatable.beginUpdates()
        
        for i in 0...(rows! - 1) {
            datatable.insertRows(at: IndexSet(integer: IndexSet.Element(i)))
        }
        
        datatable.endUpdates()
        
        // fill the table row cells
        for i in 0...rows! - 1{
            let rowview = datatable.rowView(atRow: Int(i), makeIfNecessary: true)
            
            if (DynamicCast.readdata(Int32(i + 1), withscoredata: UnsafeMutablePointer<sqlfscore>(&datasqlfscore))) != SQLF_OK {
                print("error reading data!\n")
                return
            }
            
            // for num
            tmpcellview = rowview?.view(atColumn: 0) as? NSTableCellView
            tmpcellview?.textField?.stringValue = String(datasqlfscore.num)
            
            // for path and name
            tmpcellview = rowview?.view(atColumn: 1) as? NSTableCellView
            let tmpname = datasqlfscore.name
            let name = withUnsafePointer(to: &datasqlfscore.name) {
                $0.withMemoryRebound(to: UInt8.self, capacity: MemoryLayout.size(ofValue: tmpname)) {
                    String(cString: $0)
                }
            }
            tmpcellview?.textField?.stringValue = name
            
            // for dry time
            tmpcellview = rowview?.view(atColumn: 2) as? NSTableCellView
            let tmptime = datasqlfscore.name
            let time = withUnsafePointer(to: &datasqlfscore.time) {
                $0.withMemoryRebound(to: UInt8.self, capacity: MemoryLayout.size(ofValue: tmptime)) {
                    String(cString: $0)
                }
            }
            tmpcellview?.textField?.stringValue = time
            
            // for each score and grade in fscore struct
            tmpcellview = rowview?.view(atColumn: 3) as? NSTableCellView
            tmpcellview?.textField?.stringValue = String(datasqlfscore.score.browningscore)
            tmpcellview = rowview?.view(atColumn: 4) as? NSTableCellView
            tmpcellview?.textField?.stringValue = String(datasqlfscore.score.fadescore)
            tmpcellview = rowview?.view(atColumn: 5) as? NSTableCellView
            tmpcellview?.textField?.stringValue = String(datasqlfscore.score.transferredscore)
            tmpcellview = rowview?.view(atColumn: 6) as? NSTableCellView
            tmpcellview?.textField?.stringValue = String(datasqlfscore.score.drytimescore)
            tmpcellview = rowview?.view(atColumn: 7) as? NSTableCellView
            tmpcellview?.textField?.stringValue = String(datasqlfscore.score.finalscore)
            tmpcellview = rowview?.view(atColumn: 8) as? NSTableCellView
            tmpcellview?.textField?.stringValue = String(datasqlfscore.score.grade)
        }
        super.showWindow(self)
    }
    
    override func windowDidLoad() {
    }
}
