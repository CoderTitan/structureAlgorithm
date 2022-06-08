//
//  RecallLeetCode.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/10/29.
//

import Cocoa

/// 力扣相关练习题
class RecallLeetCode {
    
    /**
     * 1. https://leetcode-cn.com/problems/permutations/
     * 给定一个不含重复数字的数组 nums ，返回其 所有可能的全排列
     * 输入：nums = [1,2,3]
     * 输出：[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
     */
    func permute(_ nums: [Int]) -> [[Int]] {
        var results = [[Int]]()
        var paths = [Int]()
        var useds = Array(repeating: false, count: nums.count)
        
        permuteGroup(nums, index: 0, useds: &useds, paths: &paths, results: &results)
        return results
    }
    
    fileprivate func permuteGroup(_ nums: [Int], index: Int, useds: inout [Bool], paths: inout [Int], results: inout [[Int]]) {
        if index == nums.count {
            results.append(paths)
            return
        }
        
        for i in 0..<nums.count {
            if useds[i] { continue }
            paths.append(nums[i])
            useds[i] = true
            permuteGroup(nums, index: index + 1, useds: &useds, paths: &paths, results: &results)
            useds[i] = false
            if !paths.isEmpty {
                paths.removeLast()
            }
        }
    }
    
    /**
     * 2. https://leetcode-cn.com/problems/permutations-ii/
     * 给定一个可包含重复数字的序列 nums ，按任意顺序 返回所有不重复的全排列
     * 输入：nums = [1,1,2]
     * 输出：[[1,1,2], [1,2,1], [2,1,1]]
     */
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var results = [[Int]]()
        var useds = Array(repeating: false, count: nums.count)
        var paths = [Int]()
        
        let newNums = nums.sorted(by: <)
        permuteGroup(newNums, index: 0, useds: &useds, paths: &paths, results: &results)
        return results
    }
    
    fileprivate func permuteUniqueGroup(_ nums: [Int], index: Int, useds: inout [Bool], paths: inout [Int], results: inout [[Int]]) {
        if index == nums.count {
            results.append(paths)
            return
        }
        
        for i in 0..<nums.count {
            if useds[i] || (i > 0 && !useds[i - 1] && nums[i] == nums[i - 1]) {
                continue
            }
            paths.append(nums[i])
            useds[i] = true
            permuteGroup(nums, index: index + 1, useds: &useds, paths: &paths, results: &results)
            useds[i] = false
            if !paths.isEmpty {
                paths.removeLast()
            }
        }
    }
    
    /**
     * 3. https://leetcode-cn.com/problems/combination-sum/
     * 给定一个无重复元素的正整数数组 candidates 和一个正整数 target ，找出 candidates 中所有可以使数字和为目标数 target 的唯一组合
     * 输入：candidates = [2,3,6,7], target = 7
     * 输出：[[7],[2,2,3]]
     */
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var results = [[Int]]()
        var combines = [Int]()
        let nums = candidates.sorted(by: <)
        combinationSum(nums, target: target, sum: 0, index: 0, combines: &combines, results: &results)
        return results
    }
    
    fileprivate func combinationSum(_ candidates: [Int], target: Int, sum: Int, index: Int, combines: inout [Int], results: inout [[Int]]) {
        if target == sum {
            results.append(combines)
            return
        }
        
        for i in index..<candidates.count {
            let current = candidates[i]
            let res = sum + current
            if res <= target {
                combines.append(current)
                combinationSum(candidates, target: target, sum: res, index: i, combines: &combines, results: &results)
                if !combines.isEmpty {
                    combines.removeLast()
                }
            } else {
                break
            }
        }
    }
    
    /**
     * 4. https://leetcode-cn.com/problems/combination-sum-ii/
     * 给定一个无重复元素的正整数数组 candidates 和一个正整数 target ，找出 candidates 中所有可以使数字和为目标数 target 的唯一组合
     * candidates 中的每个数字在每个组合中只能使用一次
     * 输入: candidates = [10,1,2,7,6,1,5], target = 8,
     * 输出：[[1,1,6],[1,2,5],[1,7],[2,6]]
     */
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var results = [[Int]]()
        var combines = [Int]()
        
        let nums = candidates.sorted(by: <)
        combinationSum2(nums, target: target, sum: 0, index: 0, combines: &combines, results: &results)
        return results
    }
    
    fileprivate func combinationSum2(_ candidates: [Int], target: Int, sum: Int, index: Int, combines: inout [Int], results: inout [[Int]]) {
        if target == sum {
            results.append(combines)
            return
        }
        
        for i in index..<candidates.count {
            if i > index && candidates[i] == candidates[i - 1] {
                continue
            }

            let res = sum + candidates[i]
            if res <= target {
                combines.append(candidates[i])
                combinationSum2(candidates, target: target, sum: res, index: i + 1, combines: &combines, results: &results)
                if !combines.isEmpty {
                    combines.removeLast()
                }
            } else {
                break
            }
        }
    }
    
    /**
     * 5. https://leetcode-cn.com/problems/subsets/
     * 一个整数数组 nums ，数组中的元素 互不相同 。返回该数组所有可能的子集（幂集)
     * 输入: nums = [1,2,3]
     * 输出：[[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
     */
    func subsets(_ nums: [Int]) -> [[Int]] {
        var results = [[Int]]()
        var paths = [Int]()

        subsets(nums, index: 0, paths: &paths, results: &results)
        return results
    }

    fileprivate func subsets(_ nums: [Int], index: Int, paths: inout [Int], results: inout [[Int]]) {
        if index == nums.count {
            results.append(paths)
            return
        }

        paths.append(nums[index])
        subsets(nums, index: index + 1, paths: &paths, results: &results)
        if !paths.isEmpty {
            paths.removeLast()
        }
        subsets(nums, index: index + 1, paths: &paths, results: &results)
    }
    
    /**
     * 6. https://leetcode-cn.com/problems/subsets-ii/
     * 一个整数数组 nums ，其中可能包含重复元素，请你返回该数组所有可能的子集（幂集）
     * 输入: nums = [1,2,2]
     * 输出：[[],[1],[1,2],[1,2,2],[2],[2,2]]
     */
    func subsets2(_ nums: [Int]) -> [[Int]] {
        var results = [[Int]]()
        var paths = [Int]()

        subsetsTwo(nums, index: 0, paths: &paths, results: &results)
        return results
    }

    fileprivate func subsetsTwo(_ nums: [Int], index: Int, paths: inout [Int], results: inout [[Int]]) {
        if index == nums.count {
            if !results.contains(paths) {
                results.append(paths)
            }
            return
        }

        paths.append(nums[index])
        subsetsTwo(nums, index: index + 1, paths: &paths, results: &results)
        if !paths.isEmpty {
            paths.removeLast()
        }
        subsetsTwo(nums, index: index + 1, paths: &paths, results: &results)
    }
}

