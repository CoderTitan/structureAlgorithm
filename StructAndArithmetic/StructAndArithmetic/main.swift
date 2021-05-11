//
//  main.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/7.
//

import Foundation

let tree = RedBlackTree()
let arr = [33, 23, 45, 10, 28, 19, 56, 34, 8, 5]
for i in arr {
    tree.add(i)
}
BinaryTreesPrint.println(tree)
print("---------------------")

tree.remove(8)
BinaryTreesPrint.println(tree)
print("---------------------")
tree.remove(19)
BinaryTreesPrint.println(tree)
print("---------------------")
tree.remove(45)
BinaryTreesPrint.println(tree)
print("---------------------")
tree.remove(5)
BinaryTreesPrint.println(tree)
print("---------------------")
tree.remove(10)
BinaryTreesPrint.println(tree)
