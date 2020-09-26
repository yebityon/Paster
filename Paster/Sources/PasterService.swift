//
//  PasterService.swift
//  Paster
//
//  Created by Taeyong Seong on 2020/09/25.
//  Copyright © 2020 Seong. All rights reserved.
//

import Foundation
import Cocoa
import RxCocoa
import RxSwift

class PasterService{
    init(){
        
    }
    private let removeCRLF : RemoveCRLFService = RemoveCRLFService()
    private let wordCount  : WordCntService = WordCntService()
    private let scheduler = SerialDispatchQueueScheduler(qos: .userInteractive)
    private let disposeBag = DisposeBag()
    private var cachedChangeCount = BehaviorRelay<Int>(value: 0)
    private var clipboard : ClipboardManager = ClipboardManager()
    private var menuManager : MenuManager = MenuManager()
    
    
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
                guard let clipboard = self?.clipboard else {
                    return
                }
                guard let currentState = self?.menuManager.isPasterActive else {
                    return
                }
                let str = clipboard.getStr()
                //remove CRLF
                if currentState {
                    let removedStr = self?.removeCRLF.removeCRLF(str: str) as! String
                    clipboard.setStr(str: removedStr)
                    self?.cachedChangeCount.accept(changeCount + 1)
                }
                //wordCnt
                if let wordCount = self?.wordCount {
                    let strType = wordCount.launguageType(str: str)
                    let wordCounter = wordCount.countWord(str: str, strType: strType)
                    print(wordCounter)
                    self?.menuManager.updateWordCnt(newcnt: wordCounter, strType: strType)
                    
                }
                
            })
            .disposed(by: disposeBag)
    }
}
