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
    
    let menuManager = MenuManager()
    var item : [NSPasteboardItem?] = []
    private let myStringHandler : stringHandler = stringHandler()
    fileprivate var lstString : String  = ""
    fileprivate let scheduler = SerialDispatchQueueScheduler(qos: .userInteractive)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.menuManager.build()
        print("startMontoring")
        self.startMonitoring()
        print(#function)
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    @objc func manageState(){
        if menuManager.isPasterActive {
            menuManager.isPasterActive = false
            if let stateMenu = menuManager.statusBarMenu.item(at: 0){
                stateMenu.title = "STATE : INACTIVE"
                //MARK:= what is "itemChanged"? does this func need?
                //menuManager.statusBarMenu.itemChanged(stateMenu)
            }
            if let manageMenu = menuManager.statusBarMenu.item(at: 1){
                manageMenu.title = "active"
            }
        } else {
            menuManager.isPasterActive = true
            if let stateMenu = menuManager.statusBarMenu.item(at: 0){
                stateMenu.title = "STATE : ACTIVE"
            }
            if let manageMenu = menuManager.statusBarMenu.item(at: 1){
                manageMenu.title = "inactive"
            }
        }
    }
    func startMonitoring() {
//        let disposeBag = DisposeBag()
        Observable<Int>.interval(0.75,scheduler: scheduler)
            .subscribe({ [weak self]  _ in
                if let str = self?.lstString , let strHandler = self?.myStringHandler,
                    let menuManager = self?.menuManager {
                    let currentStr = strHandler.getStr()
                    if str != currentStr && menuManager.isPasterActive {
                        self?.lstString = currentStr
                        print("updated : lstString")
                        let str = strHandler.removeCRLF()!
                        strHandler.writeToClipBoard(str: str)
                    }
                }
            })
    }
}
