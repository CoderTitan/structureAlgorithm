//
//  CoinExchange.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/11/4.
//

import Cocoa

/// 零钱兑换问题
struct CoinExchange {

    /**
     * 假设有25分, 10分, 5分, 1分的硬币, 给客户41分的零钱, 让硬币个数最少
     */
    static func changeMoney1(_ coins: [Int], money: Int) -> [Int] {
        let coinArr = coins.sorted(by: >)
        var array = [Int]()
        var max = money
        var index = 0
        
        while index < coinArr.count {
            while max >= coinArr[index] {
                max -= coinArr[index]
                array.append(coinArr[index])
            }
            index += 1
        }
        
        return array
    }
    
    /**
     * 假设有25分, 10分, 5分, 1分的硬币, 给客户41分的零钱, 让硬币个数最少
     */
    static func changeMoney2(_ coins: [Int], money: Int) -> [Int] {
        let coinArr = coins.sorted(by: >)
        var array = [Int]()
        var max = money
        var index = 0
        
        while index < coinArr.count {
            while max >= coinArr[index] {
                max -= coinArr[index]
                array.append(coinArr[index])
            }
            index += 1
        }
        
        return array
    }
}
