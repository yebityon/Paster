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
    
    let debug : Bool = false
    let menuManager = MenuManager()
    
    private let myStringHandler : stringHandler = stringHandler()
    private let scheduler = SerialDispatchQueueScheduler(qos: .userInteractive)
    private let disposeBag = DisposeBag()
    private var cachedChangeCount = BehaviorRelay<Int>(value: 0)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if debug {
            self.mydebug()
        } else {
            self.menuManager.build()
            self.monitorClipBoard()
        }
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    @objc func manageState(){
        menuManager.updateMenuState()
        menuManager.changeButtonTitle()
    }
    func monitorClipBoard() {
        let monitorInterval = Observable<Int>.interval(.milliseconds(750), scheduler: scheduler)
        
        monitorInterval
            // check the Pastedboard counter
            .map { _ in  NSPasteboard.general.changeCount}
            .withLatestFrom(cachedChangeCount) {($0, $1)}
            .filter({(lst: Int, cst: Int) -> Bool in
                return lst != cst
            })
            // following function execute only if chache value and current value is differ.
            .subscribe(onNext: {[weak self] changeCount, _ in
                if self?.menuManager.isPasterActive ?? false ,
                    let strHandler = self?.myStringHandler {
                    let str = strHandler.removeCRLF()
                    if let s = str {
                        strHandler.writeToClipBoard(str: s)
                        //TODO:= use altenative way
                        self?.cachedChangeCount.accept(changeCount + 1)
                    }
                }
            })
        .disposed(by: disposeBag)
    }
    
    func mydebug(){
        let object = BehaviorRelay<Int>(value: 0)
        object.subscribe(onNext: { elem in
            print(elem)
        })
        object.accept(114514)
        let e = {  (elem : Int) -> Int in
            return elem + 2
            
        }
    }

}
