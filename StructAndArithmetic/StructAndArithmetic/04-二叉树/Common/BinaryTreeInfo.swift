//
//  BinaryTreeInfo.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/19.
//

import Cocoa


protocol BinaryTreeProtocol  {
    /// 根节点
    func getRoot() -> Any?
    
    /// 左节点
    func left(node: Any?) -> Any?
    
    /// 右节点
    func right(node: Any?) -> Any?
    
    /// 转字符串
    func string(node: Any?) -> String
}
