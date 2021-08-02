//
//  GraphTest.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/29.
//

import Cocoa

struct GraphTest<V: Comparable & Hashable> {

    /// 测试生成图
    static func makeGraph() {
        let graph = ListGraph<String, Int>()
        graph.addEdge(from: "V1", to: "V0", weight: 9)
        graph.addEdge(from: "V1", to: "V2", weight: 3)
        graph.addEdge(from: "V2", to: "V0", weight: 2)
        graph.addEdge(from: "V2", to: "V3", weight: 5)
        graph.addEdge(from: "V0", to: "V4", weight: 6)
        graph.addEdge(from: "V3", to: "V4", weight: 1)
        graph.printString()

        graph.removeVertex(val: "V0")
        graph.printString()
    }
    
    /// 测试有向广度优先搜索
    static func bfsTest(_ begin: V?, data: [[Any]]) {
        var valArr = [V]()
        let graph = directedGraph(data)
        graph.breadthFirstSearch(begin: begin) { val in
            valArr.append(val)
        }
        print(valArr)
    }
    
    /// 测试无向广度优先搜索
    static func unbfsTest(_ begin: V?, data: [[Any]]) {
        var valArr = [V]()
        let graph = undirectedGraph(data)
        graph.breadthFirstSearch(begin: begin) { val in
            valArr.append(val)
        }
        print(valArr)
    }
    
    /// 测试又向深度优先搜索
    static func dfsTest(_ begin: V?, data: [[Any]]) {
        var valArr = [V]()
        let graph = directedGraph(data)
        graph.depthFirstSearch(begin: begin) { val in
            valArr.append(val)
        }
        print(valArr)
    }
    
    /// 测试无向深度优先搜索
    static func undfsTest(_ begin: V?, data: [[Any]]) {
        var valArr = [V]()
        let graph = undirectedGraph(data)
        graph.depthFirstSearch(begin: begin) { val in
            valArr.append(val)
        }
        print(valArr)
    }
    
    /// 测试递归有向深度优先搜索
    static func dfsCycleTest(_ begin: V?, data: [[Any]]) {
        var valArr = [V]()
        let graph = directedGraph(data)
        graph.depthFirstSearchCircle(begin: begin) { val in
            valArr.append(val)
        }
        
        print(valArr)
    }
    
    /// 测试递归无向深度优先搜索
    static func undfsCycleTest(_ begin: V?, data: [[Any]]) {
        var valArr = [V]()
        let graph = undirectedGraph(data)
        graph.depthFirstSearchCircle(begin: begin) { val in
            valArr.append(val)
        }
        print(valArr)
    }
    
    /// 测试拓扑排序
    static func topSortTest(_ data: [[Any]]) {
        let graph = directedGraph(data)
        let array = graph.topologicalSort()
        print(array)
    }
    
    
    /// 测试最小生成树, prim算法
    static func mstPrim(_ data: [[Any]]) {
        let graph = undirectedGraph(data)
        let edgeArr = graph.mstPrim()?.lists() ?? []
        for edge in edgeArr {
            print(edge.toString())
        }
    }
    
    /// 测试最小生成树, prim算法
    static func mstKruskal(_ data: [[Any]]) {
        let graph = undirectedGraph(data)
        let edgeArr = graph.mstKruskal()?.lists() ?? []
        for edge in edgeArr {
            print(edge.toString())
        }
    }
    
    /// 从某一点出发的最短路径(权值最小)
    static func shortPath() {
        let graph = undirectedGraph(GraphData.SP)
        let map = graph.shortestPath("A" as! V)
        map?.keys().forEach({ key in
            let val = map?.get(key: key)
            let keyStr = String(describing: key)
            let valStr = String(describing: val)
            print("A--\(keyStr): \(valStr)")
        })
    }
    
    /// 从某一点出发的最短路径(权值最小)
    static func dijkstraShortPath() {
        let graph = undirectedGraph(GraphData.SP)
        let map = graph.dijkstraShortPath("A" as! V)
        map?.traversal(visitor: { val, path in
            let valStr = String(describing: val)
            if let pathInfo = path {
                print("\(valStr): \(pathInfo.toString())")
            }
            print("------------------------------")
        })
    }
    
    /// 从某一点出发的最短路径(权值最小)
    static func bellmanFordShortPath() {
        let graph = directedGraph(GraphData.BF_SP)
        let map = graph.bellmanFordShortPath("A" as! V)
        map?.traversal(visitor: { val, path in
            let valStr = String(describing: val)
            if let pathInfo = path {
                print("\(valStr): \(pathInfo.toString())")
            }
            print("------------------------------")
        })
    }
    
    /// 从某一点出发的最短路径(权值最小)
    static func floydShortPath() {
        let graph = directedGraph(GraphData.NEGATIVE_WEIGHT1)
        let map = graph.floydShortPath()
        map?.traversal(visitor: { val, pathMap in
            pathMap?.traversal(visitor: { value, path in
                let valStr = String(describing: val)
                let valueStr = String(describing: value)
                if let pathInfo = path {
                    print("\(valStr)--\(valueStr): \(pathInfo.toString())")
                }
            })
            print("------------------------------")
        })
    }
}


extension GraphTest {
    /// 有向图
    static func directedGraph(_ data: [[Any]]) -> ListGraph<V, Double> {
        let graph = ListGraph<V, Double>()
        for edge in data {
            if edge.count == 1 {
                if let val = edge[0] as? V {
                    graph.addVertex(val: val)
                }
            } else if edge.count == 2 {
                if let val0 = edge[0] as? V, let val1 = edge[1] as? V {
                    graph.addEdge(from: val0, to: val1)
                }
            } else if edge.count == 3 {
                let text = String(describing: edge[2])
                let weight = Double(text)
                if let val0 = edge[0] as? V, let val1 = edge[1] as? V {
                    graph.addEdge(from: val0, to: val1, weight: weight)
                }
            }
        }
        return graph
    }
    
    /// 无向图
    static func undirectedGraph(_ data: [[Any]]) -> ListGraph<V, Double> {
        let graph = ListGraph<V, Double>()
        for arr in data {
            if arr.count == 1 {
                if let val = arr[0] as? V {
                    graph.addVertex(val: val)
                }
            } else if arr.count == 2 {
                if let val0 = arr[0] as? V, let val1 = arr[1] as? V {
                    graph.addEdge(from: val0, to: val1)
                    graph.addEdge(from: val1, to: val0)
                }
            } else if arr.count == 3 {
                let text = String(describing: arr[2])
                let weight = Double(text)
                if let val0 = arr[0] as? V, let val1 = arr[1] as? V {
                    graph.addEdge(from: val0, to: val1, weight: weight)
                    graph.addEdge(from: val1, to: val0, weight: weight)
                }
            }
        }
        return graph
    }
}
