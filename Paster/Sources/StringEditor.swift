//
//  MonitorClipboard.swift
//  Paster
//
//  Created by Seong on 2020/03/06.
//  Copyright © 2020 Seong. All rights reserved.
//¥
import Foundation

class StringEditor{
    func EnstrtoDictionary(str : String ) -> [String]{
        
        let wordvec : [String] = str.components(separatedBy: " ").filter( { (str : String) -> Bool in
            return str != " "
        })
        let cnt = wordvec.count
        return wordvec
    }
    func removeCRLF( str : String) -> String {
        /*          return String value which is removed CRLF          */
        str.map{(elem : String.Element) -> String in
        return (elem == "\n" || elem == "\r" ? " " : String(elem)) }.reduce(""){ $0 + $1 }
    }
    
}
