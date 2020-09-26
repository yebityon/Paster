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
    func removeCRLF( str : String) -> String {
        /*          return String value which is removed CRLF          */
        str.map{(elem : String.Element) -> String in
            return (elem == "\n" || elem == "\r" ? " " : String(elem)) }.reduce(""){ $0 + $1 }
    }
}
