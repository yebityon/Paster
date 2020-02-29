//
//  MenuManager.swift
//
//  Created by Seong on 2019/09/04.
//  Copyright © 2019 Seong. All rights reserved.
//

import Foundation
import Cocoa

class MenuManager : NSObject {
    
    fileprivate var clipMenu : NSMenu?
    fileprivate var snippetMenu: NSMenu?
    var statusBarItem : NSStatusItem?
    var statusBarMenu = NSMenu()
    
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
        print(#function)
    }
    func changeButtonTitle() {
        if isPasterActive {
            statusBarItem?.button?.title = "🍝"
        } else {
            statusBarItem?.button?.title = "🍽"
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



