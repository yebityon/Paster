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
        NSLog(#function + "called")
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
            if let stateMenu = statusBarMenu.item(at: 0){
                stateMenu.title = "STATE : INACTIVE"
                //MARK:= what is "itemChanged"? does this func need?
                //menuManager.statusBarMenu.itemChanged(stateMenu)
            }
            if let manageMenu = statusBarMenu.item(at: 1){
                manageMenu.title = "active"
            }
        } else {
            isPasterActive = true
            if let stateMenu = statusBarMenu.item(at: 0){
                stateMenu.title = "STATE : ACTIVE"
            }
            if let manageMenu = statusBarMenu.item(at: 1){
                manageMenu.title = "inactive"
            }
        }
    }
    private func createMenu(){
        initPasterState()
        initPasterChangeState()
        initPasterQuit()
    }
    private func initPasterState(){
        itemPasterState = NSMenuItem(title: "STATE : ACTIVE ",action : nil, keyEquivalent: "")
        itemPasterState.tag = 0
        statusBarMenu.addItem(itemPasterState)
    }
    private func initPasterChangeState(){
        itemPasterChangeState = NSMenuItem(title:"inactive", action : #selector(AppDelegate.manageState),keyEquivalent: "")
        itemPasterState.tag = 1
        statusBarMenu.addItem(itemPasterChangeState)
    }
    private func initPasterQuit(){
        itemPasterQuit = NSMenuItem(title: "Quit",action: #selector(NSApplication.terminate(_:)),
        keyEquivalent: "q")
        itemPasterQuit.tag = 2
        statusBarMenu.addItem(itemPasterQuit)
    }
}



