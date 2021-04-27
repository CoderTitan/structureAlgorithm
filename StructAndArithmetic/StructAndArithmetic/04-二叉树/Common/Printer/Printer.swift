//
//  Printer.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/19.
//

import Cocoa

class Printer {
    
    var tree: BinaryTreeProtocol?
    
    func printTree(_ tree: BinaryTreeProtocol) -> Printer {
        let print = Printer()
        print.tree = tree
        return print
    }
    
    func printIn() {
        printOut()
        print("\n")
    }
    
    func printOut() {
        print(printString() ?? "")
    }
    
    func printString() -> String? {
        return nil
    }
}
