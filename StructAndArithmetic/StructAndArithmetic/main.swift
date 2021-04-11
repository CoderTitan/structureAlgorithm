//
//  main.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/7.
//

import Foundation


/// 单向链表
//singleLink()

let doubleLink = DoubleLinkList<Int>()
doubleLink.add(0)
doubleLink.add(1)
doubleLink.add(2)
//doubleLink.add(by: 3, element: 10)
//let element = doubleLink.remove(3)
let index = doubleLink.indexOf(5)
print(index)
print(doubleLink.toString())



/// 单向链表
func singleLink() {
    let single = SingleLinkList<Int>()
    single.add(10)
    single.add(11)
    single.add(12)
    single.add(13)
//    let element = single.get(index: 4)
//    let element = single.set(by: 3, element: 3)
//    single.add(by: 1, element: 21)
//    single.add(by: 0, element: 22)
//    single.add(by: 4, element: 22)
//    let element = single.remove(4)
//    single.clear()
//    print(element)
    print(single.toString())
}


let a = NSObject()
let b = NSObject()

if a == b {
    
}

