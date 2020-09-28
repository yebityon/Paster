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
   
    
    
    func monitorClipBoard() {
        let monitorInterval = Observable<Int>.interval(.milliseconds(1000), scheduler: scheduler)
        
        monitorInterval
            // check the Pastedboard counter
            .map { _ in  NSPasteboard.general.changeCount}
            .withLatestFrom(AppEnvironment.properties.cachedChangeCount) {($0, $1)}
            .filter({(lst: Int, cst: Int) -> Bool in
                return lst != cst
            })
            // following function execute only if chache value and current value is differ.
            .subscribe(onNext: {[weak self] changeCount, _ in
                let currentState = AppEnvironment.properties.menuManager.isPasterActive
            
                guard let str = AppEnvironment.properties.clipboardManager.getStr() else { return }
                print("-----------------------------------------------")
                print(str)
                print("-----------------------------------------------")
                print("")
                AppEnvironment.properties.clipboardManager.storeClipbordStr()
                //remove CRLF
                if currentState {
                    let removedStr = self?.removeCRLF.removeCRLF(str: str) as! String
                    AppEnvironment.properties.clipboardManager.setStr(str: removedStr)
                    AppEnvironment.properties.cachedChangeCount.accept(changeCount + 1)
//                  print(changeCount + 1)
                   print("--------------------------removed-------------")
                   print(removedStr)
                   print("-------------------------gigegiga----------------")
                   print("\n\n")
                }
                
                //wordCnt
                if let wordCount = self?.wordCount {
                    let strType = wordCount.launguageType(str: str)
                    let wordCounter = wordCount.countWord(str: str, strType: strType)
                    AppEnvironment.properties.menuManager.updateWordCnt(newcnt: wordCounter, strType: strType)
                    
                }
                
            })
            .disposed(by: disposeBag)
    }
}
