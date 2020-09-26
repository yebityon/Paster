//
//  wordCntService.swift
//  Paster
//
//  Created by Seong on 2020/03/06.
//  Copyright © 2020 Seong. All rights reserved.
import Foundation
import NaturalLanguage


class WordCntService{
    private let tokenizer = NLTokenizer(unit: .word)
    private let recognizer = NLLanguageRecognizer()
    
    init(){
        
    }
    func EnstrtoDictionary(str : String ) -> [String]{
        let wordvec : [String] = str.split(whereSeparator: {"!,. ".contains($0)}).map{(elem : Substring) -> String in
            return String(elem)}
        
        let cnt = wordvec.count
        return wordvec
    }
    func launguageType( str : String ) -> String? {
        recognizer.reset()
        recognizer.processString(str)
        print(str)
        guard let launguage = recognizer.dominantLanguage else {
//            print(recognizer.languageHypotheses(withMaximum: 3))
//            print(recognizer.dominantLanguage?.rawValue)
            return nil
        }
        print(launguage.rawValue)
        return launguage.rawValue
    }
    func countWord( str : String?, strType : String?) -> Int? {
        
        var wordCnt : Int = 0
        guard let str = str else { return nil }
        tokenizer.string = str
        if strType == "ja" {
            tokenizer.enumerateTokens(in: str.startIndex ..< str.endIndex){ tokenRange, _ in
                wordCnt += str[tokenRange].count
                return true
            }
        } else {
            tokenizer.enumerateTokens(in: str.startIndex ..< str.endIndex) { tokenRange, _ in
                wordCnt += 1
                return true
            }
        }
        return wordCnt
    }
}

