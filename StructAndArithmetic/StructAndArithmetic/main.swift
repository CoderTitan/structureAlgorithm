//
//  main.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/7.
//

import Foundation

let tree = BinaryBalanceSearchTree()
let arr = [33, 23, 45, 10, 28, 19, 56, 34, 8, 5, 4]
for i in arr {
    tree.add(i)
}
BinaryTreesPrint.println(tree)

let r = tree.root
