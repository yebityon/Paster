//
//  debugForPaster.swift
//  Paster
//
//  Created by Taeyong Seong on 2020/10/02.
//  Copyright © 2020 Seong. All rights reserved.

// add HotKey Service to implements DeepL
//


import Foundation
import RxRelay
import RxSwift
import Cocoa
class debugForPaster {
    init(){
        
    }
    private let scheduler = SerialDispatchQueueScheduler(qos: .userInteractive)
    private let disposeBag = DisposeBag()
    
    
    
    func monitorClipBoard() {
        let monitorInterval = Observable<Int>.interval(.milliseconds(1), scheduler: scheduler)
        
        monitorInterval
            // check the Pastedboard counter
            .map { _ in  NSPasteboard.general.changeCount}
            .withLatestFrom(AppEnvironment.properties.cachedChangeCount) {($0, $1)}
            .filter({(lst: Int, cst: Int) -> Bool in
                return lst != cst
            })
            // following function execute only if chache value and current value is differ.
            .subscribe(onNext: {[weak self] changeCount, _ in
//                AppEnvironment.properties.clipboardManager.setStr(str: "remu is god")
                AppEnvironment.properties.cachedChangeCount.accept(changeCount + 1)
            
            })
        
            
            .disposed(by: disposeBag)
        
    }
}
