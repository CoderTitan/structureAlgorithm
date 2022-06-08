//
//  DivideConquer.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/11/4.
//

import Cocoa

/// 分治
struct DivideConquer {

    /**
     * 1. https://leetcode-cn.com/problems/maximum-subarray/
     * 最大连续子序列
     * 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
     * 输入：nums = [-2,1,-3,4,-1,2,1,-5,4]
     * 输出：6
     * 暴力方式
     */
    static func maxSubArray1(_ nums: [Int]) -> Int {
        if nums.count == 0 { return 0 }
        
        var maxNum = Int.min
        var sum = 0
        for begin in 0..<nums.count {
            sum = 0
            for end in begin..<nums.count {
                sum += nums[end]
                maxNum = max(maxNum, sum)
            }
        }
        return maxNum
    }
    
    /**
     * 2. https://leetcode-cn.com/problems/maximum-subarray/
     * 最大连续子序列
     * 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
     * 输入：nums = [-2,1,-3,4,-1,2,1,-5,4]
     * 输出：6
     * 分治方式
     */
    static func maxSubArray(_ nums: [Int]) -> Int {
        if nums.count == 0 { return 0 }
        return maxSubArray(nums, begin: 0, end: nums.count)
    }
    
    static func maxSubArray(_ nums: [Int], begin: Int, end: Int) -> Int {
        if end - begin < 2 { return nums[begin] }
        let mid = (begin + end) >> 1
        
        var midNum = 0
        // 中间左半部分最大值
        var leftMidMax = Int.min
        for i in (0..<mid).reversed() {
            midNum += nums[i]
            leftMidMax = max(midNum, leftMidMax)
        }
        
        // 中间右半部分最大值
        var rightMidMax = Int.min
        midNum = 0
        for i in mid..<nums.count {
            midNum += nums[i]
            rightMidMax = max(midNum, rightMidMax)
        }
        
        // 左半部分最大值
        let leftMax = maxSubArray(nums, begin: begin, end: mid)
        // 右半部分最大值
        let rightMax = maxSubArray(nums, begin: mid, end: end)

        return max(leftMax, rightMax, leftMidMax + rightMidMax)
    }
}
