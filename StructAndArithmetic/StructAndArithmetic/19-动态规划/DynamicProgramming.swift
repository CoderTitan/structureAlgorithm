//
//  DynamicProgramming.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/11/6.
//

import Cocoa

/// 动态规划, DP算法
struct DynamicProgramming {
    
    
}

//MARK: 零钱兑换
/**
 * https://leetcode-cn.com/problems/coin-change/
 * 零钱兑换问题: 给你一个整数数组 coins ，表示不同面额的硬币；以及一个整数 amount ，表示总金额。
 * 计算并返回可以凑成总金额所需的 最少的硬币个数 。如果没有任何一种硬币组合能组成总金额，返回 -1
 */
extension DynamicProgramming {
    /// https://leetcode-cn.com/problems/coin-change/
    static func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        if amount < 1 { return 0 }
        var dp = Array(repeating: amount + 1, count: amount + 1)
        dp[0] = 0
        for i in 1...amount {
            for coin in coins {
                if i >= coin {
                    dp[i] = min(dp[i], dp[i - coin] + 1)
                }
            }
        }
        return dp[amount] > amount ? -1 : dp[amount]
    }
    
    /// 暴力递归(自上而下的调用)
    static func coinChange1(_ amount: Int) -> Int {
        if amount < 1 { return Int.max }
        let coins = [25, 20, 5, 1]
        if coins.contains(amount) { return 1 }
        
        let min = min(coinChange1(amount - 25),
                      coinChange1(amount - 20),
                      coinChange1(amount - 5),
                      coinChange1(amount - 1))
        return min + 1
    }
    
    /// 记忆化递归(自上而下的调用)
    static func coinChange2(_ amount: Int) -> Int {
        if amount < 1 { return Int.max }
        
        let coins = [25, 20, 5, 1]
        var dp = Array(repeating: 0, count: amount + 1)
        for item in coins {
            if item > amount { continue }
            dp[item] = 1
        }
        return coinAction(amount, dp: &dp)
    }
    
    static func coinAction(_ amount: Int, dp: inout [Int]) -> Int {
        if amount < 1 { return Int.max }
        if dp[amount] == 0 {
            let min = min(coinAction(amount - 25, dp: &dp),
                          coinAction(amount - 20, dp: &dp),
                          coinAction(amount - 5, dp: &dp),
                          coinAction(amount - 1, dp: &dp))
            dp[amount] = min + 1
        }
        
        return dp[amount]
    }
    
    
    /// 递推(自下而上的调用)
    static func coinChange3(_ amount: Int) -> Int {
        if amount < 1 { return -1 }
        var dp = Array(repeating: 0, count: amount + 1)
        
        for i in 1...amount {
            var minCount = dp[i - 1]
            if i >= 5 { minCount = min(dp[i - 5], minCount) }
            if i >= 20 { minCount = min(dp[i - 20], minCount) }
            if i >= 25 { minCount = min(dp[i - 25], minCount) }
            dp[i] = minCount + 1
        }
        return dp[amount]
    }
}


//MARK: 最大连续子序列的和
/**
 * 2. https://leetcode-cn.com/problems/maximum-subarray/
 * 最大连续子序列
 * 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
 * 输入：nums = [-2,1,-3,4,-1,2,1,-5,4]
 * 输出：6
 * 动态规划, DP算法
 */
extension DynamicProgramming {
    static func maxSubArray(_ nums: [Int]) -> Int {
        if nums.count == 0 { return 0 }
        
//        var dp = Array(repeating: Int.min, count: nums.count)
//        dp[0] = nums[0]
//        var maxSub = nums[0]
//        for i in 1..<nums.count {
//            dp[i] = max(dp[i - 1], 0) + nums[i]
//            maxSub = max(maxSub, dp[i])
//        }
        
        
        // 上一次的最大子序列和
        var dp = nums[0]
        // 最大值
        var maxSub = nums[0]
        for i in 1..<nums.count {
            dp = max(dp, 0) + nums[i]
            maxSub = max(maxSub, dp)
        }
        return maxSub
    }
    
    static func maxSubArray1(_ nums: [Int]) -> Int {
        if nums.count == 0 { return 0 }
        
        var dp = Array(repeating: Int.min, count: nums.count)
        dp[0] = nums[0]
        var maxSub = nums[0]
        for i in 1..<nums.count {
            dp[i] = max(dp[i - 1], 0) + nums[i]
            maxSub = max(maxSub, dp[i])
        }
        return maxSub
    }
}


//MARK: 最大上升子序列的长度
/**
 * 2. https://leetcode-cn.com/problems/longest-increasing-subsequence/
 * 给你一个整数数组 nums ，找到其中最长严格递增子序列的长度。
 * 输入：nums = [10,9,2,5,3,7,101,18]
 * 输出：4
 * 动态规划, DP算法
 */
extension DynamicProgramming {
    /// 个数
    static func lengthOfLIS(_ nums: [Int]) -> Int {
        if nums.count == 0 { return 0 }
                
        var dp = Array(repeating: 0, count: nums.count)
        dp[0] = 1
        var maxCount = 1
        for i in 1..<nums.count {
            dp[i] = 1
            for j in 0..<i {
                if nums[i] <= nums[j] { continue }
                dp[i] = max(dp[i], dp[j] + 1)
            }
            maxCount = max(maxCount, dp[i])
        }

        return maxCount
    }
}


//MARK: 最长公共子序列
/**
 * 3. https://leetcode-cn.com/problems/longest-common-subsequence/
 * 给定两个字符串 text1 和 text2，返回这两个字符串的最长 公共子序列 的长度。如果不存在 公共子序列 ，返回 0
 * 输入：text1 = "abcde", text2 = "ace"
 * 输出：3
 */
extension DynamicProgramming {
    /// 递归实现
    static func longestCommonSubsequence1(_ text1: String, _ text2: String) -> Int {
        let textArr1 = Array(text1).map({ $0.description })
        let textArr2 = Array(text2).map({ $0.description })
        if textArr1.isEmpty || textArr2.isEmpty { return 0 }
        return lcs(textArr1, textArr2, textIndex1: textArr1.count, textIndex2: textArr2.count)
    }
    
    static func lcs(_ textArr1: [String], _ textArr2: [String], textIndex1: Int, textIndex2: Int) -> Int {
        if textIndex1 == 0 || textIndex2 == 0 { return 0 }
        if textArr1[textIndex1 - 1] == textArr2[textIndex2 - 1] {
            return lcs(textArr1, textArr2, textIndex1: textIndex1 - 1, textIndex2: textIndex2 - 1) + 1
        }
        return max(lcs(textArr1, textArr2, textIndex1: textIndex1 - 1, textIndex2: textIndex2),
                   lcs(textArr1, textArr2, textIndex1: textIndex1, textIndex2: textIndex2 - 1))
    }
    
    /// 非递归(有重复计算)
    static func longestCommonSubsequence2(_ text1: String, _ text2: String) -> Int {
        let textArr1 = Array(text1).map({ $0.description })
        let textArr2 = Array(text2).map({ $0.description })
        if textArr1.isEmpty || textArr2.isEmpty { return 0 }
        
        var dp = Array(repeating: Array(repeating: 0, count: textArr2.count + 1), count: textArr1.count + 1)
        for i in 1...textArr1.count {
            for j in 1...textArr2.count {
                if textArr1[i - 1] == textArr2[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + 1
                } else {
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
                }
            }
        }
        
        return dp[textArr1.count][textArr2.count]
    }
    
    /// 非递归(滚动数组)
    static func longestCommonSubsequence3(_ text1: String, _ text2: String) -> Int {
        let textArr1 = Array(text1).map({ $0.description })
        let textArr2 = Array(text2).map({ $0.description })
        if textArr1.isEmpty || textArr2.isEmpty { return 0 }
        
        var dp = Array(repeating: Array(repeating: 0, count: textArr2.count + 1), count: 2)
        for i in 1...textArr1.count {
            let row = i & 1
            let preRow = (i - 1) & 1
            for j in 1...textArr2.count {
                if textArr1[i - 1] == textArr2[j - 1] {
                    dp[row][j] = dp[preRow][j - 1] + 1
                } else {
                    dp[row][j] = max(dp[preRow][j], dp[row][j - 1])
                }
            }
        }
        
        return dp[textArr1.count & 1][textArr2.count]
    }
    
    /// 非递归(一维数组)
    static func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let textArr1 = Array(text1).map({ $0.description })
        let textArr2 = Array(text2).map({ $0.description })
        if textArr1.isEmpty || textArr2.isEmpty { return 0 }
        
        var dp = Array(repeating: 0, count: textArr2.count + 1)
        for i in 1...textArr1.count {
            var tmp = 0
            for j in 1...textArr2.count {
                let leftTop = tmp
                tmp = dp[j]
                if textArr1[i - 1] == textArr2[j - 1] {
                    dp[j] = leftTop + 1
                } else {
                    dp[j] = max(dp[j], dp[j - 1])
                }
            }
        }
        
        return dp[textArr2.count]
    }
}


//MARK: 最长公共子串
/**
 * 给定两个字符串 text1 和 text2，返回这两个字符串的最长 公共子串。如果不存在 公共子串 ，返回 0
 * 输入：text1 = "abcde", text2 = "ace"
 * 输出：1
 */
extension DynamicProgramming {
    /// 非递归(二维数组)
    static func longestCommonSub1(_ text1: String, _ text2: String) -> Int {
        let textArr1 = Array(text1).map({ $0.description })
        let textArr2 = Array(text2).map({ $0.description })
        if textArr1.isEmpty || textArr2.isEmpty { return 0 }
        
        var dp = Array(repeating: Array(repeating: 0, count: textArr2.count + 1), count: textArr1.count + 1)
        var maxLength = 0
        for i in 1...textArr1.count {
            for j in 1...textArr2.count {
                if textArr1[i - 1] != textArr2[j - 1] { continue }
                dp[i][j] = dp[i - 1][j - 1] + 1
                maxLength = max(maxLength, dp[i][j])
            }
        }
        
        return maxLength
    }
    
    /// 非递归(一维数组)
    static func longestCommonSub(_ text1: String, _ text2: String) -> Int {
        let textArr1 = Array(text1).map({ $0.description })
        let textArr2 = Array(text2).map({ $0.description })
        if textArr1.isEmpty || textArr2.isEmpty { return 0 }
        
        var dp = Array(repeating: 0, count: textArr2.count + 1)
        var maxLength = 0
        for i in 1...textArr1.count {
            var cur = 0
            for j in 1...textArr2.count {
                let leftTop = cur
                cur = dp[j]
                if textArr1[i - 1] == textArr2[j - 1] {
                    dp[j] = leftTop + 1
                    maxLength = max(maxLength, dp[j])
                } else {
                    dp[j] = 0
                }
            }
        }
        
        return maxLength
    }
}


//MARK: 背包问题
/**
 * 有n件物品和一个最大承重力为W的背包, 每件物品的重量是w1, 价值是v1, 在保证中重量不超过W的前提下, 选择某些物品装入背包, 背包的最大价值是多少
 * 每个物品只有一件, 也就是每个物品只能选择0件或者1件
 */
extension DynamicProgramming {
    /// 非递归(二维数组)
    static func maxValue1(_ capacity: Int, values: [Int], weights: [Int]) -> Int {
        if values.isEmpty || weights.isEmpty { return 0 }
        if values.count != weights.count { return 0 }
        if capacity <= 0 { return 0 }
        
        var dp = Array(repeating: Array(repeating: 0, count: capacity + 1), count: values.count + 1)
        for i in 1...values.count {
            for j in 1...capacity {
                if j < weights[i - 1] {
                    dp[i][j] = dp[i - 1][j]
                } else {
                    dp[i][j] = max(dp[i - 1][j],
                                   dp[i - 1][j - weights[i - 1]] + values[i - 1])
                }
            }
        }
        
        return dp[values.count][capacity]
    }
    
    /// 非递归(二维数组)
    static func maxValue(_ capacity: Int, values: [Int], weights: [Int]) -> Int {
        if values.isEmpty || weights.isEmpty { return 0 }
        if values.count != weights.count { return 0 }
        if capacity <= 0 { return 0 }
        
        var dp = Array(repeating: 0, count: capacity + 1)
        for i in 1...values.count {
            for j in (1...capacity).reversed() {
                if j < weights[i - 1] { continue }
                dp[j] = max(dp[j], dp[j - weights[i - 1]] + values[i - 1])
            }
        }
        
        return dp[capacity]
    }
}
