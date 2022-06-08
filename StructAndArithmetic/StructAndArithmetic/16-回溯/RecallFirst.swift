//
//  RecallFirst.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/10/28.
//

import Cocoa

/// 八皇后问题
class RecallFirst {

    /// 皇后所在的行列, 索引为行, 值为列
    var queens = [Int]()
    /// 一共有多少中摆法
    var ways = 0
    
    /// n皇后摆法
    func quaceQueens(_ number: Int) {
        if number < 1 { return }
        queens = Array(repeating: -1, count: number)
        place(row: 0)
        print("\(number)皇后共有\(ways)种摆法")
    }
    
    /// 从第row行开始摆放
    fileprivate func place(row: Int) {
        if row == queens.count {
            ways += 1
            showArrannge()
            return
        }
        
        for i in 0..<queens.count {
            if isVaild(row: row, col: i) {
                queens[row] = i
                place(row: row + 1)
            }
        }
    }
    
    /// 判断第row行第col列是否可以摆放
    fileprivate func isVaild(row: Int, col: Int) -> Bool {
        for i in 0..<row {
            if queens[i] == col {
                return false
            }
            if (row - i) == abs(col - queens[i]) {
                return false
            }
        }
        return true
    }
    
    /// 打印n皇后排列
    fileprivate func showArrannge() {
        for row in 0..<queens.count {
            for col in 0..<queens.count {
                if queens[row] == col {
                    print("1 ", terminator: "")
                } else {
                    print("0 ", terminator: "")
                }
            }
            print("")
        }
        print("-----------------")
    }
}

