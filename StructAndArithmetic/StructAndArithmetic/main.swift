//
//  main.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/7.
//

import Foundation

let tree = BinarySearchTree<Int>()

//let arr = [38, 18, 4, 69, 85, 71, 34, 36, 29, 100]
let arr = [7, 4, 9, 2, 5, 6, 8, 11, 1, 3, 10, 12]
//let arr = [5, 4, 6, 3, 2, 7, 8]
for i in arr {
    tree.add(i)
}
BinaryTreesPrint.println(tree)

//let contains = tree.contains(100)
//print(contains)
//print(tree.preorderForRecursion())
//print(tree.preorderForEach())
//print(tree.infixOrderForRecursion())
print(tree.infixOrderForEach())
//print(tree.epilogueForRecursion())
//print(tree.epilogueForEach())
//print(tree.levelOrderForEach())
//print(tree.widthOfBinaryTree())


