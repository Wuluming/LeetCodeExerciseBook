import UIKit


func sortOne( nums: inout [Int]) -> [Int] {
    
    var j = 0
    var temp = 0
    
    for idx in 1..<nums.count {
        temp = nums[idx]
        j = idx - 1
        while (j >= 0 && nums[j] > temp) {
            //nums[j+1] = nums[j]
            nums[j] = nums[j + 1]
            j-=1
        }
        nums[j + 1] = temp
    }
    return nums
}
//var arr = [2,4,5,1,6]
//print(sortOne(nums: &arr))



public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}
class Solution226 {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        invert(root!)
        
        return root
    }
    //递归
    func invert(_ root: TreeNode?) {
        if root == nil {
            return
        }
        
        let node = root!.left
        root!.left = root!.right
        root!.right = node
        
        invert(root!.left)
        invert(root!.right)
    }
    
}

/*
 在本问题中，有根树指满足以下条件的有向图。该树只有一个根节点，所有其他节点都是该根节点的后继。每一个节点只有一个父节点，除了根节点没有父节点。

 输入一个有向图，该图由一个有着N个节点 (节点值不重复1, 2, ..., N) 的树及一条附加的边构成。附加的边的两个顶点包含在1到N中间，这条附加的边不属于树中已存在的边。

 结果图是一个以边组成的二维数组。 每一个边 的元素是一对 [u, v]，用以表示有向图中连接顶点 u 和顶点 v 的边，其中 u 是 v 的一个父节点。

 返回一条能删除的边，使得剩下的图是有N个节点的有根树。若有多个答案，返回最后出现在给定二维数组的答案。

 示例 1:

 输入: [[1,2], [1,3], [2,3]]
 输出: [2,3]
 解释: 给定的有向图如下:
   1
  / \
 v   v
 2-->3
 示例 2:

 输入: [[1,2], [2,3], [3,4], [4,1], [1,5]]
 输出: [4,1]
 解释: 给定的有向图如下:
 5 <- 1 -> 2
      ^    |
      |    v
      4 <- 3
 注意:

 二维数组大小的在3到1000范围内。
 二维数组中的每个整数在1到N之间，其中 N 是二维数组的大小。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/redundant-connection-ii
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution685 {
    func findRedundantDirectedConnection(_ edges: [[Int]]) -> [Int] {
        var map:[Int: Int] = [:]
        for edge in edges {
            for u in edge {
                if map[u] == nil {
                    map[u] = 1
                } else {
                    map[u]! += 1
                }
            }
        }
        for (key, val) in map {
            let str = "key = " + "\(key)" + "val = " + "\(val)"
            print(str)
        }
        var temp: [[Int]] = []
        for edge in edges.reversed() {
            for (idx,u) in edge.enumerated() {
                if map[u]! == 3 {
                    temp.append(edge)
                }
            }
        }
        
        if temp.count > 0 {
            return temp.last!
        }
        
        for edge in edges.reversed() {
            for (idx,u) in edge.enumerated() {
                if map[u]! == 2 && idx == 0 {
                    temp.append(edge)
                }
            }
        }
        return temp.last!
    }
}

//var s685 = Solution685()
//[[2,1],[3,1],[4,2],[1,4]]
//print(s685.findRedundantDirectedConnection([[5,2],[5,1],[3,1],[3,4],[3,5]]))


class Solution104 {
    var maxDep = 0
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
//        let left = maxDepth(root!.left) + 1
//        maxDep = max(left, maxDep)
//
//        let right = maxDepth(root!.right) + 1
//        maxDep = max(right, maxDep)
        
        
        
        return max(maxDepth(root!.left) + 1, maxDepth(root!.right) + 1)
    }
}
