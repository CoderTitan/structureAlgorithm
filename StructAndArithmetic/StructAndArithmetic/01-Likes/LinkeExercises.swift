//
//  LinkeExercises.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/14.
//

import Cocoa

class LinkeExercises<E: Comparable> {
    
}


extension LinkeExercises {
    /// 判断一个链表是否有环
    func hasCycle(_ head: ListNode<E>?) -> Bool {
        if head == nil || head?.next == nil { return false }
        var slow = head?.next
        var fast = head?.next?.next
        
        while fast != nil && fast?.next != nil {
            if fast == slow {
                return true
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return false
    }
    
    /// 存在一个按升序排列的链表，给你这个链表的头节点 head ，请你删除所有重复的元素，使每个元素 只出现一次 。
    func deleteDuplicates(_ head: ListNode<E>?) -> ListNode<E>? {
        if head == nil || head?.next == nil { return head }
        
        let current = head?.next
        let next = current?.next
        while current != nil && next != nil {
            if current?.element == next?.element {
                current?.next = next?.next
                next?.next = current?.next
            }
        }
        return head
    }
}
