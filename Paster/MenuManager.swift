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
    
    var isLipsyActive: Bool = true
    var itemLipsyState  : NSMenuItem = NSMenuItem()
    var itemLipsyChangeState : NSMenuItem  = NSMenuItem()
    var itemLipsyQuit : NSMenuItem = NSMenuItem()

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
    private func createMenu(){
        initLipsyState()
        initLipsyChangeState()
        initLipsyQuit()
    }
    private func initLipsyState(){
        itemLipsyState = NSMenuItem(title: "STATE : ACTIVE ",action : nil, keyEquivalent: "")
        itemLipsyState.tag = 0
        statusBarMenu.addItem(itemLipsyState)
    }
    private func initLipsyChangeState(){
        itemLipsyChangeState = NSMenuItem(title:"inactive", action : #selector(AppDelegate.manageState),keyEquivalent: "")
        itemLipsyState.tag = 1
        statusBarMenu.addItem(itemLipsyChangeState)
    }
    private func initLipsyQuit(){
        itemLipsyQuit = NSMenuItem(title: "Quit",action: #selector(NSApplication.terminate(_:)),
        keyEquivalent: "q")
        itemLipsyQuit.tag = 2
        statusBarMenu.addItem(itemLipsyQuit)
    }
}



