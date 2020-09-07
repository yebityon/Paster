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
    
    private let myStringHandler : StringEditor = StringEditor()
    private let clipboradManger : clipboardAction = clipboardAction()
    private let scheduler = SerialDispatchQueueScheduler(qos: .userInteractive)
    private let disposeBag = DisposeBag()
    private var cachedChangeCount = BehaviorRelay<Int>(value: 0)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.menuManager.build()
        self.monitorClipBoard()
        
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
                if self?.menuManager.isPasterActive != nil  &&
                self? .clipboradManger != nil{
                    if let str = self?.myStringHandler.removeCRLF(str: (self?.clipboradManger.getStr()) ?? "") {
                        self?.clipboradManger.setStr(str: str)
                        let wordvec = self?.myStringHandler.EnstrtoDictionary(str: str)
                        self?.menuManager.updateWordCnt(newcnt: wordvec?.count ?? 0)
                        //TODO:= use altenative way
                        self?.cachedChangeCount.accept(changeCount + 1)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
}
