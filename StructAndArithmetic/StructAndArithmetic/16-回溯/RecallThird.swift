//
//  RecallThird.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/10/29.
//

import Cocoa

/// 只是用于八皇后问题, 位运算处理
class RecallThird {

    /// 皇后所在的行列, 索引为行, 元素为列
    var queens = [Int]()
    /// 某一列是否有皇后
    var cols = 0x00000000
    /// 左对角线上是否有皇后(左上角-->右下角)
    var leftTops = 0x000000000000000
    /// 右对角线上是否有皇后(右上角-->左下角)
    var rightTops = 0x000000000000000
    /// 一共有多少中摆法
    var ways = 0
    
    /// n皇后摆法
    func quaceQueens() {
        queens = Array(repeating: -1, count: 8)
        place(row: 0)
        print("8皇后共有\(ways)种摆法")
    }
    
    /// 从第row行开始摆放
    fileprivate func place(row: Int) {
        if row == queens.count {
            ways += 1
            showArrannge()
            return
        }
        
        for col in 0..<8 {
            let cv = 1 << col
            if cols & cv != 0 { continue }
            
            let lv = 1 << (row - col + 7)
            if leftTops & lv != 0 { continue }
            
            let rv = 1 << (row + col)
            if rightTops & rv != 0 { continue }
            
            queens[row] = col
            cols |= cv
            leftTops |= lv
            rightTops |= rv
            place(row: row + 1)
            /// 回溯, 重置状态
            cols &= ~cv
            leftTops &= ~lv
            rightTops &= ~rv
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

