//
//  main.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/7.
//

import Foundation


let str: NSObject = "s12" as NSObject


struct Person: Hashable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return true
    }
    
    
}



struct ListAction: Hashable {
    static func == (lhs: ListAction, rhs: ListAction) -> Bool {
        return lhs.label == rhs.label
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
    }

    let label: String
    let action: (() -> Void)? = nil
}
