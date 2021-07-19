//
//  main.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/7.
//

import Foundation

var arr = [51, 30, 39, 92, 74, 25, 16, 93, 91,
           19, 54, 47, 73, 62, 76, 63, 35, 18,
           90, 6, 65, 49, 3, 26, 61, 21, 48]



let sort1 = RadixSorted<Int>()
sort1.sorted(by: arr)
print(sort1.dataArray)
print(sort1.toString())


