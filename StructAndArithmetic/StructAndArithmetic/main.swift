//
//  main.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/7.
//

import Foundation

let begin = Date().timeIntervalSince1970
let code = DynamicProgramming.maxValue(10, values: [6, 3, 5, 4, 6], weights: [2, 2, 6, 5, 4])
print(code)


let end = Date().timeIntervalSince1970
print("time = \(end - begin)")


//"mhunuzqrkzsnidwbun"
//"szulspmhwpazoxijwbq"
