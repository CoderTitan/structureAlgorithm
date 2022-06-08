//
//  RecallSecord.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/10/29.
//

import Cocoa


/// 八皇后问题优化, 成员变量
class RecallSecord {

    /// 皇后所在的行列, 索引为行, 元素为列
    var queens = [Int]()
    /// 某一列是否有皇后
    var cols = [Bool]()
    /// 左对角线上是否有皇后(左上角-->右下角)
    var leftTops = [Bool]()
    /// 右对角线上是否有皇后(右上角-->左下角)
    var rightTops = [Bool]()
    /// 一共有多少中摆法
    var ways = 0
    
    /// n皇后摆法
    func quaceQueens(_ number: Int) {
        if number < 1 { return }
        queens = Array(repeating: -1, count: number)
        cols = Array(repeating: false, count: number)
        leftTops = Array(repeating: false, count: (number << 1) - 1)
        rightTops = Array(repeating: false, count: leftTops.count)
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
        
        for col in 0..<cols.count {
            if cols[col] { continue }
            let leftIndex = row - col + cols.count - 1
            if leftTops[leftIndex] { continue }
            let rightIndex = row + col
            if rightTops[rightIndex] { continue }
            
            queens[row] = col
            cols[col] = true
            leftTops[leftIndex] = true
            rightTops[rightIndex] = true
            place(row: row + 1)
            /// 回溯, 重置状态
            cols[col] = false
            leftTops[leftIndex] = false
            rightTops[rightIndex] = false
        }
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

