//
//  AppDelegate.swift
//
//  Created by Seong on 2019/09/02.
//  Copyright © 2019 Seong. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        AppEnvironment.properties.menuManager.build()
        AppEnvironment.properties.pasterService.monitorClipBoard()
        
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    @objc func manageState(){
        AppEnvironment.properties.menuManager.updateMenuState()
        AppEnvironment.properties.menuManager.changeButtonTitle()
    }
    
}
