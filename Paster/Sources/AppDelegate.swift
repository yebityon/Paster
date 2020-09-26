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
    
    public let menuManager = MenuManager()
    
    private let clipboard : ClipboardManager = ClipboardManager()
    private let pasterService : PasterService = PasterService()
    private let scheduler = SerialDispatchQueueScheduler(qos: .userInteractive)
    private let disposeBag = DisposeBag()
    private var cachedChangeCount = BehaviorRelay<Int>(value: 0)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        AppEnvironment.properties.menuManager.build()
        AppEnvironment.properties.pasterService.monitorClipBoard()
        
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    @objc func manageState(){
        menuManager.updateMenuState()
        menuManager.changeButtonTitle()
    }
    func monitorClipBoard() {
        pasterService.monitorClipBoard()
    }
    
}
