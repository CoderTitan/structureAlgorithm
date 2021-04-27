//
//  Extension.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/19.
//

import Cocoa

extension String {
    static func tk_blank(count: Int) -> String {
        return " ".tk_repeat(count: count)
    }
    
    
    func tk_repeat(count: Int) -> String {
        var size = count
        var string = ""
        while size > 0 {
            string.append(self)
            size -= 1
        }
        return string
    }
    
    public func substring(location: Int, length: Int) ->String? {
        if location < 0 && location >= self.count {
            return nil
        }
        
        if length <= 0 || length > self.count {
            return nil
        }
        
        if location + length > self.count {
            return nil
        }
        
        return (self as NSString).substring(with: NSMakeRange(location, length))
    }
    
    /// 只能输入由26个英文字母组成的字符串
    var isLetter: Bool {
        return isMatch("^[A-Za-z]+$")
    }
    
    private func isMatch(_ pred: String ) -> Bool {
        let pred = NSPredicate(format: "SELF MATCHES[c] %@", pred)
        let isMatch: Bool = pred.evaluate(with: self)
        return isMatch
    }
}
