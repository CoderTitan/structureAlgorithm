//
//  BinaryTreesPrint.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/20.
//

import Cocoa

class BinaryTreesPrint {

    static func println(_ tree: BinaryTreeProtocol) {
        let log = InorderPrinter.printTree(tree)
        log.printIn()
    }
}
