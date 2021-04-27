//
//  ListNode.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/10.
//

import Cocoa



class ListNode<E: Comparable>: NSObject {

    var element: E?
    var prev: ListNode?
    var next: ListNode?
    
    init(element: E?, next: ListNode?, prev: ListNode? = nil) {
        
        self.element = element
        self.prev = prev
        self.next = next
    }
    
}
