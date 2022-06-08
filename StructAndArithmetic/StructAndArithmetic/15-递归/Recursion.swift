//
//  Recursion.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/10/28.
//

import Cocoa

struct Recursion {

    /**
     * 斐波那契数(自身=前两个数的和)
     * 1, 1, 2, 3, 5, 8, 13, 21, 34
     * 时间复杂度: T(n) = T(n - 1) + T(n - 2) + O(1), 即O(2^n)
     * 空间复杂度O(n)
     * 递归的空间复杂度 = 递归深度 * 每次调用所需的辅助空间
     */
    static func fib1(n: Int) -> Int {
        if n <= 2 { return 1 }
        return fib1(n: n - 1) + fib1(n: n - 2)
    }
    
    /**
     * 斐波那契数(自身=前两个数的和)
     * 避免重复计算优化
     */
    static func fib2(n: Int) -> Int {
        if n <= 2 { return 1 }
        var array = Array(repeating: 0, count: n + 1)
        array[1] = 1
        array[2] = 1
        return fib2(array: &array, n: n)
    }
    
    static func fib2(array: inout [Int], n: Int) -> Int {
        if array[n] == 0 {
            array[n] = fib2(array: &array, n: n - 1) + fib2(array: &array, n: n - 2)
        }
        return array[n]
    }
    
    /**
     * 斐波那契数(自身=前两个数的和)
     * 非递归
     */
    static func fib3(n: Int) -> Int {
        if n <= 2 { return 1 }
        var array = Array(repeating: 0, count: n + 1)
        array[1] = 1
        array[2] = 1
        for i in 3...n {
            array[i] = array[i - 1] + array[i - 2]
        }
        return array[n]
    }
    
    /**
     * 斐波那契数(自身=前两个数的和)
     * 非递归, 滚动数组
     */
    static func fib4(n: Int) -> Int {
        if n <= 2 { return 1 }
        var array = Array(repeating: 1, count: 2)
        for i in 3...n {
            array[i % 2] = array[(i - 1) % 2] + array[(i - 2) % 2]
        }
        return array[n % 2]
    }
    
    /**
     * 斐波那契数(自身=前两个数的和)
     * 非递归, 滚动数组优化, 取余耗性能
     * 位运算代替模运算
     */
    static func fib5(n: Int) -> Int {
        if n <= 2 { return 1 }
        var array = Array(repeating: 1, count: 2)
        for i in 3...n {
            array[i & 1] = array[(i - 1) & 1] + array[(i - 2) & 1]
        }
        return array[n & 1]
    }
    
    /**
     * 斐波那契数(自身=前两个数的和)
     * 非递归, 变量计算
     */
    static func fib6(n: Int) -> Int {
        if n <= 2 { return 1 }
        var first = 1
        var secord = 1
        for _ in 3...n {
            secord = first + secord
            first = secord - first
        }
        return secord
    }
    
    /**
     * 斐波那契数(自身=前两个数的和)
     * 非递归, 栈
     */
    static func fib7(n: Int) -> Int {
        if n <= 2 { return 1 }
        let statck = Statck<Int>()
        statck.push(1)
        statck.push(1)
        for _ in 3...n {
            let first = statck.pop() ?? 0
            let secord = statck.pop() ?? 0
            statck.push(first)
            statck.push(first + secord)
        }
        return statck.pop() ?? 0
    }
}
