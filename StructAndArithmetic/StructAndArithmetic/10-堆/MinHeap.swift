//
//  MinHeap.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/30.
//

import Cocoa

/// 最小堆
class MinHeap<E: Comparable>: BinaryHeap<E> {

    convenience init(vals: [E] = []) {
        self.init(vals: vals, compare: { $0 < $1 })
    }
}
