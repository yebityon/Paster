
//
//  StringHandler.swift
//
//  Created by Seong on 2020/02/26.
//  Copyright © 2020 Seong. All rights reserved.
//

import Foundation
import Cocoa

class ClipboardManager {
    init() {
    }
    
    private var previousStr : String = ""
    func setStr(str : String){
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        if pasteboard.setString(str, forType: NSPasteboard.PasteboardType.string) {
            
        } else {
            
        }
        
    }
    func getStr() -> String? {
        let pastedBoard = NSPasteboard.general
        guard let str = pastedBoard.string(forType: NSPasteboard.PasteboardType.string) else {return nil}
        return str
    }
    func storeClipbordStr() {
        guard let str = getStr() else { return }
        previousStr = str
    }
    func recoveClipboard(){
//        print("-------yebityonhogehoge------------")
//        print(previousStr)
        setStr(str: previousStr)
    }
}
