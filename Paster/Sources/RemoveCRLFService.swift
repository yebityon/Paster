//
//  removeCRLFService.swift
//  Paster
//
//  Created by Taeyong Seong on 2020/09/25.
//  Copyright © 2020 Seong. All rights reserved.
//

import Foundation

class RemoveCRLFService {
    init(){
        
    }
    let removeCRLFPattern = ""
    func removeCRLF( str : String) -> String {
        let res = str.replacingOccurrences(of:"\n\r|\n|\r", with:"",options: .regularExpression)
        return res
        
    }
}
