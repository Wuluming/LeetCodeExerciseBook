import UIKit
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
class Solution {
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var queue = [TreeNode]()
        
        queue.append(root!)
        var level = 0
        
        while !queue.isEmpty {
            var tmp = [TreeNode]()
            for node in queue {
                if node.left != nil {
                    tmp.append(node.left!)
                }
                if node.right != nil {
                    tmp.append(node.right!)
                }
            }
            queue = tmp
            level+=1
        }
        
        return level
    }
    
    func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
        if t1 == nil && t2 == nil {
            return nil
        }
        let root: TreeNode = TreeNode((t1 == nil ? 0: t1!.val) + (t2 == nil ? 0 : t2!.val))
        
        root.left = mergeTrees(t1?.left, t2?.left)
        root.right = mergeTrees(t1?.right, t2?.right)
        
        return root
    }
    
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        //层序遍历，每层用数组填充
        if root == nil {
            return nil
        }
        var queue = [TreeNode]()
        queue.append(root!)
        
        while !queue.isEmpty {
            let node = queue.removeFirst()
            //反转二叉树
            let rightNode = node.right
            node.right = node.left
            node.left = rightNode
            
            if node.left != nil {
                queue.append(node.left!)
            }
            if node.right != nil {
                queue.append(node.right!)
            }
            
        }
        return root
    }
}
//343. 整数拆分
/*
 给定一个正整数 n，将其拆分为至少两个正整数的和，并使这些整数的乘积最大化。 返回你可以获得的最大乘积。

 示例 1:

 输入: 2
 输出: 1
 解释: 2 = 1 + 1, 1 × 1 = 1。
 示例 2:

 输入: 10
 输出: 36
 解释: 10 = 3 + 3 + 4, 3 × 3 × 4 = 36。
 说明: 你可以假设 n 不小于 2 且不大于 58。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/integer-break
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution343 {
    var max = 1
    var max0 = 1
    var max1 = 1
    func integerBreak(_ n: Int) -> Int {
        
        if n == 2 {
            return 1
        }
        
        for idx in 2..<n {
            let res = idx * (n - idx)
            if res > max {
                max0 = idx
                max1 = n - idx
                max = res
                integerBreak(max0) * integerBreak(max1)
            }
            
        }
        
        
        return max
    }
}


//let test = Solution343()
//print(test.integerBreak(10))


/* 875. 爱吃香蕉的珂珂
 珂珂喜欢吃香蕉。这里有 N 堆香蕉，第 i 堆中有 piles[i] 根香蕉。警卫已经离开了，将在 H 小时后回来。

 珂珂可以决定她吃香蕉的速度 K （单位：根/小时）。每个小时，她将会选择一堆香蕉，从中吃掉 K 根。如果这堆香蕉少于 K 根，她将吃掉这堆的所有香蕉，然后这一小时内不会再吃更多的香蕉。

 珂珂喜欢慢慢吃，但仍然想在警卫回来前吃掉所有的香蕉。

 返回她可以在 H 小时内吃掉所有香蕉的最小速度 K（K 为整数）。

  

 示例 1：

 输入: piles = [3,6,7,11], H = 8
 输出: 4
 示例 2：

 输入: piles = [30,11,23,4,20], H = 5
 输出: 30
 示例 3：

 输入: piles = [30,11,23,4,20], H = 6
 输出: 23

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/koko-eating-bananas
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution875 {
    func minEatingSpeed(_ piles: [Int], _ H: Int) -> Int {
        
        if piles.count == 0 {
            return 0
        }
        
         let piless = piles.sorted { $0 < $1}
        print(piless)
        
        var min = 1
        var max = Int(pow(10.0, 9.0))
        
        while min <= max {
            var hh = 0
            let mid = (max - min)/2 + min
            for pp in piless {
                if pp%mid == 0 {
                    hh = hh + pp/mid
                } else {
                    hh = hh + pp/mid + 1
                }
            }
            if hh > H {
                min = mid + 1
            } else {
                max = mid
            }
        }
        
        return -1
    }
    
    
}

/*
 给定一个含有 n 个正整数的数组和一个正整数 s ，找出该数组中满足其和 ≥ s 的长度最小的 连续 子数组，并返回其长度。如果不存在符合条件的子数组，返回 0。

  

 示例：

 输入：s = 7, nums = [2,3,1,2,4,3]
 输出：2
 解释：子数组 [4,3] 是该条件下的长度最小的子数组。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/minimum-size-subarray-sum
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution209 {
    func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        var count = 0
        
        for (idx, val) in nums.enumerated() {
            var fast = val
            var slow = val
            
            if slow >= s {
                return 1
            }
            
            let idy = idx + 1
            while idy < nums.count {
                fast = nums[idy]
                
                slow = fast + slow
                
                if slow >= s {
                    if idy - idx + 1 < count {
                        count = idy - idx + 1
                    }
                }
                
            }
        }
        
        
        return count
    }
}


class Solution111x {
    func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0 }

        var length = Int.max
        var sum = 0

        var left = 0
        for right in 0..<nums.count {
            sum += nums[right]
            
            while sum >= s {
                length = min(length, right - left + 1)
                sum -= nums[left]
                left += 1
            }
        }

        return length == Int.max ? 0 : length
    }
}


class Solution111 {
    
    func minDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        if root!.left == nil && root!.right == nil {
            return 1
        }
        var deep = Int.max
        if root!.left != nil {
            deep = min(minDepth(root!.left), deep)
        }
        
        if root!.right != nil {
            deep = min(minDepth(root!.right), deep)
        }
        
        
        return deep + 1
    }
}

/*
 给定一个非空的字符串，判断它是否可以由它的一个子串重复多次构成。给定的字符串只含有小写英文字母，并且长度不超过10000。

 示例 1:

 输入: "abab"

 输出: True

 解释: 可由子字符串 "ab" 重复两次构成。
 示例 2:

 输入: "aba"

 输出: False
 示例 3:

 输入: "abcabcabcabc"

 输出: True

 解释: 可由子字符串 "abc" 重复四次构成。 (或者子字符串 "abcabc" 重复两次构成。)

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/repeated-substring-pattern
 */
class Solution459 {
    func repeatedSubstringPattern(_ s: String) -> Bool {
        let length = s.count
        if length == 1 {
            return false
        }
        var count = 2
        let firstC = NSString(string: s).substring(with: NSRange(location: 0, length: 1))
        while count <= length {
            let tempS = s
            let temp = NSString(string: s).substring(with: NSRange(location: count - 1, length: 1))
            
            print("temp=",temp)
            if temp == firstC {
                let sub =  NSString(string: tempS).substring(with: NSRange(location: 0, length: count - 1))
                let res = tempS.replacingOccurrences(of: sub, with: "")
                print("sub=",sub)
                if res == "" {
                    return true
                }
            }
            count += 1
        }
        
        return false
    }
}

let solution459 = Solution459()
print(solution459.repeatedSubstringPattern("bb"))


class Solution17 {
    var result = [String]()
    func letterCombinations(_ digits: String) -> [String] {
        
        let arr = digits.map { (c) in
            return c
        }
        let all = [
            "2":["a","b","c"],
            "3":["d","e","f"],
            "4":["g","h","i"],
            "5":["j","k","l"],
            "6":["m","n","o"],
            "7":["p","q","r","s"],
            "8":["t","u","v"],
            "9":["w","x","y","z"]
        ]
        
        for val in arr {
            
            if result.count == 0 {
                for cc in all[String(val)]! {
                    result.append(cc)
                }
            } else {
                var temp:[String] = []
                for first in result {
                    
                    for second in all[String(val)]! {
                        temp.append(first + second)
                    }
                }
                result = temp
            }
        }
        
        
        return result
    }
}

let solution17 = Solution17()

print(solution17.letterCombinations("2345"))

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
//剑指 Offer 32 - I. 从上到下打印二叉树
class Solution32 {
    func levelOrder(_ root: TreeNode?) -> [Int] {
        var quenu: [TreeNode] = []
        var arr: [Int] = []
        if root == nil {
            return []
        }
        quenu.append(root!)

        while(!quenu.isEmpty) {
            let node = quenu.removeFirst()
            arr.append(node.val)
            if node.left != nil {
                quenu.append(root!.left!)
            }
            if node.right != nil {
                quenu.append(root!.right!)
            }
        }
        return arr
    }
}

let test = Solution32()

/*
 给定一个二叉树，判断其是否是一个有效的二叉搜索树。

 假设一个二叉搜索树具有如下特征：

 节点的左子树只包含小于当前节点的数。
 节点的右子树只包含大于当前节点的数。
 所有左子树和右子树自身必须也是二叉搜索树。
 示例 1:

 输入:
     2
    / \
   1   3
 输出: true
 示例 2:

 输入:
     5
    / \
   1   4
      / \
     3   6
 输出: false
 解释: 输入为: [5,1,4,null,null,3,6]。
      根节点的值为 5 ，但是其右子节点值为 4 。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/validate-binary-search-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution98 {
    func isValidBST(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        
        return compare(root!, root!.val, root!.val)
        
    }
    
    func compare(_ root: TreeNode?, _ max: Int, _ min: Int) -> Bool {
        if root == nil {
            return true
        }
        if root!.left != nil {
            if root!.left!.val > max {
                return false
            }
        }
        
        if root!.right != nil {
            if root!.right!.val < min {
                return false
            }
        }
        
        return compare(root!.left!, root!.val, root!.val) || compare(root!.right!, root!.val, root!.val)
    }
}

/*
 199. 二叉树的右视图
 给定一棵二叉树，想象自己站在它的右侧，按照从顶部到底部的顺序，返回从右侧所能看到的节点值。

 示例:

 输入: [1,2,3,null,5,null,4]
 输出: [1, 3, 4]
 解释:

    1            <---
  /   \
 2     3         <---
  \     \
   5     4       <---
 */

class Solution199 {
    var res:[Int] = []
    var dic:[Int:[Int]] = [:]
    func rightSideView(_ root: TreeNode?) -> [Int] {
        if root == nil {
           return []
        }
        deep(root!, 0)
        
        
        for key in dic.keys.sorted() {
            let arr = dic[key]
            res.append(arr!.last!)
        }
        return res
    }
    
    func deep(_ root: TreeNode?, _ level: Int) {
        if root == nil {
            return
        }
        if dic[level] != nil {
            var temp:[Int] = []
            temp.append(root!.val)
            dic[level] = temp
        } else {
            dic[level]!.append(root!.val)
        }
        
        deep(root!.left, level + 1)
        
        deep(root!.right, level + 1)
    }
}

let test199 = Solution199()

/*
 给定一组不含重复元素的整数数组 nums，返回该数组所有可能的子集（幂集）。

 说明：解集不能包含重复的子集。

 示例:

 输入: nums = [1,2,3]
 输出:
 [
   [3],
   [1],
   [2],
   [1,2,3],
   [1,3],
   [2,3],
   [1,2],
   []
 ]

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/subsets
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

class Solution78 {
    func subsets(_ nums: [Int]) -> [[Int]] {
        let set = Set(arrayLiteral: nums)
        print(set)
        return []
    }
}

let test78 = Solution78()

print(test78.subsets([1,2,3,3,2]))

/*
 给定两个二叉树，想象当你将它们中的一个覆盖到另一个上时，两个二叉树的一些节点便会重叠。

 你需要将他们合并为一个新的二叉树。合并的规则是如果两个节点重叠，那么将他们的值相加作为节点合并后的新值，否则不为 NULL 的节点将直接作为新二叉树的节点。

 示例 1:

 输入:
     Tree 1                     Tree 2
           1                         2
          / \                       / \
         3   2                     1   3
        /                           \   \
       5                             4   7
 输出:
 合并后的树:
          3
         / \
        4   5
       / \   \
      5   4   7
 注意: 合并必须从两个树的根节点开始。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/merge-two-binary-trees
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution617 {
    func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
        if t1 == nil && t2 == nil {
            return nil
        }
        let root: TreeNode = TreeNode((t1 == nil ? 0: t1!.val) + (t2 == nil ? 0 : t2!.val))
        
        root.left = mergeTrees(t1?.left, t2?.left)
        root.right = mergeTrees(t1?.right, t2?.right)
        
        return root
    }
}
