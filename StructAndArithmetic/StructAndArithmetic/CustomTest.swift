//
//  CustomTest.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/14.
//

import Cocoa


class CustomTest {

    
}

//MARK: 链表
extension CustomTest {
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

    /// 单向循环链表
    func singleCircleLink() {
        let single = CircleSingleLineList<Int>()
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

    /// 双向链表
    func doubleLink() {
        let doubleLink = DoubleLinkList<Int>()
        doubleLink.add(0)
        doubleLink.add(1)
        doubleLink.add(2)
        //doubleLink.add(by: 3, element: 10)
        //let element = doubleLink.remove(3)
        let index = doubleLink.indexOf(5)
        print(index)
        print(doubleLink.toString())
    }

    /// 双向循环链表
    func doubleCircleLink() {
        let doubleLink = CircleDoubleLinkList<Int>()
        doubleLink.add(0)
        doubleLink.add(1)
        doubleLink.add(2)
        //doubleLink.add(by: 3, element: 10)
        //let element = doubleLink.remove(3)
        let index = doubleLink.indexOf(5)
        print(index)
        print(doubleLink.toString())
    }
    
    
    /// 队列
    func queueAction() {
        let item = SingleLinkList<Int>()
        item.add(1)
        item.add(1)
        item.add(2)
        item.add(3)
        item.add(3)
        print(item.toString())
    }
}
