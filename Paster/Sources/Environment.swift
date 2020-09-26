//
//  Environment.swift
//  Paster
//
//  Created by Taeyong Seong on 2020/09/25.
//  Copyright © 2020 Seong. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

struct Environment {
    //MARK : -properties
    let menuManager : MenuManager
    let pasterService : PasterService
    let clipboardManager : ClipboardManager
    let cachedChangeCount = BehaviorRelay<Int>(value: 0)
    
    init(menuManager: MenuManager = MenuManager(),
         pasterService: PasterService = PasterService(),
         clipboardManager : ClipboardManager = ClipboardManager()){
        self.menuManager = menuManager
        self.pasterService = pasterService
        self.clipboardManager = clipboardManager
        
    }
    
}
