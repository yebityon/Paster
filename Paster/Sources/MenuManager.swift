//
//  MenuManager.swift
//
//  Created by Seong on 2019/09/04.
//  Copyright © 2019 Seong. All rights reserved.
//

import Foundation
import Cocoa

class MenuManager : NSObject {
    private var statusBarItem : NSStatusItem?
    private var statusBarMenu = NSMenu()
    
    var isPasterActive: Bool = true
    var itemPasterState  : NSMenuItem = NSMenuItem()
    var itemPasterChangeState : NSMenuItem  = NSMenuItem()
    var itemPasterQuit : NSMenuItem = NSMenuItem()
    var itemPasterWordCnt : NSMenuItem = NSMenuItem()
    var previsouStr : String  = ""
    
    override init(){
        super.init()
    }
    
    func build(){
        statusBarItem = NSStatusBar.system.statusItem(withLength: -1)
        statusBarItem?.button?.title = "🍝"
        statusBarItem?.button?.target = self
        //TODO:= for debug
        createMenu()
        statusBarItem?.menu = self.statusBarMenu
    }
    func changeButtonTitle() {
        if isPasterActive {
            statusBarItem?.button?.title = "🍝"
        } else {
            statusBarItem?.button?.title = "🍽"
        }
    }
    func updateMenuState() {
        if isPasterActive {
            isPasterActive = false
            if let stateMenu = statusBarMenu.item(withTag: 0){
                stateMenu.title = "STATE : INACTIVE"
            }
            if let manageMenu = statusBarMenu.item(withTag: 1){
                manageMenu.title = "active"
            }
            //AppEnvironment.properties.clipboardManager.recoveClipboard()
        } else {
            isPasterActive = true
            if let stateMenu = statusBarMenu.item(withTag: 0){
                stateMenu.title = "STATE : ACTIVE"
            }
            if let manageMenu = statusBarMenu.item(withTag: 1){
                manageMenu.title = "inactive"
            }
        }
    }
    func updateWordCnt(newcnt : Int?, strType : String?) {
        if !isPasterActive { return }
        var updateString : String = ""
        if newcnt == nil || strType == nil {
            updateString = "---/---"
        } else if ( strType == "ja") {
            updateString = "Jp : " + String(newcnt!)  + " 文字"
        } else {
            updateString = "En : " + String(newcnt!)  + " word"
        }
        if let stateMenu = statusBarMenu.item(withTag: 3){
            print(stateMenu.title)
            stateMenu.title = updateString
        }
    }
    private func createMenu(){
        initPasterState()
        initPasterChangeState()
        initPasterQuit()
        initPasterWordCnt()
    }
    private func initPasterState(){
        itemPasterState = NSMenuItem(title: "STATE : ACTIVE ",action : nil, keyEquivalent: "")
        itemPasterState.tag = 0
        statusBarMenu.addItem(itemPasterState)
    }
    private func initPasterChangeState(){
        itemPasterChangeState = NSMenuItem(title:"inactive", action : #selector(AppDelegate.manageState),keyEquivalent: "")
        itemPasterChangeState.tag = 1
        statusBarMenu.addItem(itemPasterChangeState)
    }
    private func initPasterQuit(){
        itemPasterQuit = NSMenuItem(title: "Quit",action: #selector(NSApplication.terminate(_:)),
                                    keyEquivalent: "q")
        itemPasterQuit.tag = 2
        statusBarMenu.addItem(itemPasterQuit)
    }
    private func initPasterWordCnt(){
        itemPasterWordCnt = NSMenuItem(title : "init",action: nil,keyEquivalent: "")
        itemPasterWordCnt.tag = 3
        statusBarMenu.addItem(itemPasterWordCnt)
    }
}



