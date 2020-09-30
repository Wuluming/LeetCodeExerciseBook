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
public class Node {
    public var val: Int
    public var left: Node?
    public var right: Node?
      public var next: Node?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
        self.next = nil
    }
}

/*
        定义                      优点                                                                                 缺点
 递归：程序调用自身              大问题转化成小问题，可以减少代码量，同时代码精简，可读性好                      递归调用了浪费了空间，而且递归太深容易造成堆栈的溢出
 迭代：利用变量的原值推出新值      代码运行效率好，因为时间只因循环次数增加而增加，而且没有额外的空间开销            代码不如递归简洁
 
 递归和迭代的关系：1）递归中一定有迭代，但是迭代中不一定有递归，大部分可以相互转换 2）能用迭代的不用递归，递归调用函数，并且递归太深容易造成堆栈的溢出
 */

class Solution0 {
    //前序遍历
    //study :https://www.cnblogs.com/bigsai/p/11393609.html
    var result: [Int] = []
    func qianXu(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return result
        }
        result.append(root!.val)
        _ = qianXu(root!.left)
        _ = qianXu(root!.right)
        
        return result
    }
    
    //非递归
    func qianXu2(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return result
        }
        var stack:[TreeNode] = []
        while !stack.isEmpty {
            let node = stack.removeLast()
            if node.right != nil {
                stack.append(node.right!)
            }
            if node.left != nil {
                stack.append(node.left!)
            }
            result.append(node.val)
        }
        return result
    }
    
    func qianXu3(_ root: TreeNode?) -> [Int] {
        var root = root
        var stack:[TreeNode] = []
        while !stack.isEmpty || root != nil {
            if root != nil {
                result.append(root!.val)
                stack.append(root!)
                root = root!.left
            } else {
                root = stack.removeLast()
                root = root!.right
            }
        }
        return result
    }
    //非递归中序遍历
    func zhongXu(_ root: TreeNode?) -> [Int] {
        var root = root
        
        var stack:[TreeNode] = []
        
        while !stack.isEmpty || root != nil {
            if root != nil {
                stack.append(root!)
                root = root!.left
            } else {
                root = stack.removeLast()
                
                result.append(root!.val)
                
                root = root!.right
                
            }
        }
        return result
    }
    //非递归后续
    func houXu(_ root: TreeNode?) -> [Int] {
        var root = root
        var stack: [TreeNode] = []
        var map: [Int: Int] = [:]
        while !stack.isEmpty || root != nil {
            if root != nil {
                stack.append(root!)
                map[root!.val] = 1
                
                root = root!.left
            } else {
                root = stack.last
                if map[root!.val] == 2 {
                    _ = stack.removeLast()
                    result.append(root!.val)
                    root = nil
                } else {
                    map[root!.val] = 2
                    root = root!.right
                }
            }
        }
        return result
    }
    //双栈实现后续遍历
    func houXu2(_ root: TreeNode?) -> [Int] {
        var stack1:[TreeNode] = []
        var stack2:[TreeNode] = []
        if root == nil {
            return result
        }
        stack1.append(root!)
        while !stack1.isEmpty {
            let node = stack1.last!
            
            stack2.append(node)
            
            if node.left != nil {
                stack1.append(node.left!)
            }
            if node.right != nil {
                stack1.append(node.right!)
            }
        }
        while !stack2.isEmpty {
            let node = stack2.removeLast()
            result.append(node.val)
        }
        return result
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


/*875. 爱吃香蕉的珂珂
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

/*
 给定一个可包含重复数字的序列，返回所有不重复的全排列。

 示例:

 输入: [1,1,2]
 输出:
 [
   [1,1,2],
   [1,2,1],
   [2,1,1]
 ]

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/permutations-ii
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution47 {
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        return []
    }
}

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
        
        return isValidUtil(root, Int.max, Int.min)
        
    }
    
    func isValidUtil(_ root: TreeNode?, _ max: Int, _ min: Int) -> Bool {
        guard let node = root else {
            return true
        }
        guard node.val > min && node.val < max else {
            return false
        }
        return isValidUtil(node.left, node.val, min) && isValidUtil(node.right, max, node.val)
    }
}

/*
 538. 把二叉搜索树转换为累加树
 给定一个二叉搜索树（Binary Search Tree），把它转换成为累加树（Greater Tree)，使得每个节点的值是原来的节点值加上所有大于它的节点值之和。

  

 例如：

 输入: 原始二叉搜索树:
               5
             /   \
            2     13

 输出: 转换为累加树:
              18
             /   \
           20     13

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/convert-bst-to-greater-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution538 {
    var last: Int = 0
    func convertBST(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        let right =  convertBST(root!.right)
        
        last += right!.val
        
        right!.val = last
        
        _ = convertBST(root!.left)
        
        return root
    }
    
}
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
 注意: 合并必须从两个树的根节点开始

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/merge-two-binary-trees
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

class Solution617 {
    func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
        if t1 == nil && t2 == nil {
            return nil
        }
        let root = TreeNode((t1 == nil ? 0 : t1!.val) + (t2 == nil ? 0 : t2!.val))
        
        root.left = mergeTrees(t1?.left, t2?.left)
        
        root.right = mergeTrees(t1?.right, t2?.right)
        
        return root
    }
}


class Solution98_2 {
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard root != nil else {
            return true
        }
        var stack = [TreeNode](), node = root, pre: TreeNode? = nil
        
        while node != nil || !stack.isEmpty {
            while node != nil {
                stack.append(node!)
                node = node!.left
            }
            node = stack.removeLast()
            
            if pre != nil && pre!.val >= node!.val {
                return false
            }
            pre = node
            
            node = node!.right
        }
        return true
    }
    
}

/*
 106. 从中序与后序遍历序列构造二叉树
 根据一棵树的中序遍历与后序遍历构造二叉树。

 注意:
 你可以假设树中没有重复的元素。

 例如，给出

 中序遍历 inorder = [9,3,15,20,7]
 后序遍历 postorder = [9,15,7,20,3]
 返回如下的二叉树：

     3
    / \
   9  20
     /  \
    15   7

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution106 {
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        return nil
    }
    
}

/*
 二叉搜索树中的两个节点被错误地交换。

 请在不改变其结构的情况下，恢复这棵树。

 示例 1:

 输入: [1,3,null,null,2]

    1
   /
  3
   \
    2

 输出: [3,1,null,null,2]

    3
   /
  1
   \
    2
 示例 2:

 输入: [3,1,4,null,null,2]

   3
  / \
 1   4
    /
   2

 输出: [2,1,4,null,null,3]

   2
  / \
 1   4
    /
   3
 进阶:

 使用 O(n) 空间复杂度的解法很容易实现。
 你能想出一个只使用常数空间的解决方案吗？

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/recover-binary-search-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution99 {
    func recoverTree(_ root: TreeNode?) {
        
    }
}

/*
 给定一个二叉树

 struct Node {
   int val;
   Node *left;
   Node *right;
   Node *next;
 }
 填充它的每个 next 指针，让这个指针指向其下一个右侧节点。如果找不到下一个右侧节点，则将 next 指针设置为 NULL。

 初始状态下，所有 next 指针都被设置为 NULL。

  

 进阶：

 你只能使用常量级额外空间。
 使用递归解题也符合要求，本题中递归程序占用的栈空间不算做额外的空间复杂度。
  

 示例：



 输入：root = [1,2,3,4,5,null,7]
 输出：[1,#,2,3,#,4,5,7,#]
 解释：给定二叉树如图 A 所示，你的函数应该填充它的每个 next 指针，以指向其下一个右侧节点，如图 B 所示。
  

 提示：

 树中的节点数小于 6000
 -100 <= node.val <= 100

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/populating-next-right-pointers-in-each-node-ii
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution117 {
    func connect(_ root: Node?) -> Node? {
        if root == nil {
            return nil
        }
        var stack: [Node] = []
        stack.append(root!)
        while(!stack.isEmpty) {
            let count = stack.count
            var pre: Node? = nil
            for idx in 0..<count {
                let node = stack.removeFirst()

                if node.left != nil {
                    stack.append(node.left!)
                }

                if node.right != nil {
                    stack.append(node.right!)
                }
                if idx == 0 {
                    pre = node
                } else {
                    pre!.next = node
                    pre = node

                    if idx == count - 1 {
                        node.next = nil
                    }
                }
            }
        }
        return root
    }

}

/*
 给定一个二叉树，检查它是否是镜像对称的。

  

 例如，二叉树 [1,2,2,3,4,4,3] 是对称的。

     1
    / \
   2   2
  / \ / \
 3  4 4  3
  

 但是下面这个 [1,2,2,null,3,null,3] 则不是镜像对称的:

     1
    / \
   2   2
    \   \
    3    3

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/symmetric-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution101 {
    func isSymmetric(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        return compare(root!.left, root!.right)
    }
    func compare(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
        if left == nil && right == nil {
            return true
        }
        guard let left = left, let right = right else {
            return false
        }
        if left.val != right.val {
            return false
        }

        return compare(left.left, right.right) && compare(left.right, right.left)
    }
}
/*
 701. 二叉搜索树中的插入操作
 给定二叉搜索树（BST）的根节点和要插入树中的值，将值插入二叉搜索树。 返回插入后二叉搜索树的根节点。 输入数据保证，新值和原始二叉搜索树中的任意节点值都不同。

 注意，可能存在多种有效的插入方式，只要树在插入后仍保持为二叉搜索树即可。 你可以返回任意有效的结果。

  

 例如,

 给定二叉搜索树:

         4
        / \
       2   7
      / \
     1   3

 和 插入的值: 5
 你可以返回这个二叉搜索树:

          4
        /   \
       2     7
      / \   /
     1   3 5
 或者这个树也是有效的:

          5
        /   \
       2     7
      / \
     1   3
          \
           4
  

 提示：

 给定的树上的节点数介于 0 和 10^4 之间
 每个节点都有一个唯一整数值，取值范围从 0 到 10^8
 -10^8 <= val <= 10^8
 新值和原始二叉搜索树中的任意节点值都不同

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/insert-into-a-binary-search-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution701 {
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        if root == nil {
            return TreeNode(val)
        }
        if root!.val < val {
            root!.right = insertIntoBST(root!.right, val)
        } else {
            root!.left = insertIntoBST(root!.left, val)
        }
        return root
    }
    
    
}

class SolutionTest {
    /*
     给定两个由小写字母构成的字符串 A 和 B ，只要我们可以通过交换 A 中的两个字母得到与 B 相等的结果，就返回 true ；否则返回 false 。

      

     示例 1：

     输入： A = "ab", B = "ba"
     输出： true
     示例 2：

     输入： A = "ab", B = "ab"
     输出： false
     示例 3:

     输入： A = "aa", B = "aa"
     输出： true
     示例 4：

     输入： A = "aaaaaaabc", B = "aaaaaaacb"
     输出： true
     示例 5：

     输入： A = "", B = "aa"
     输出： false
     */
    func buddyStrings(_ A: String, _ B: String) -> Bool {
        if A.count < 2 || B.count < 2 {
            return false
        }
        if A.count != B.count{
            return false
        }
        
        let arrA = A.map { return $0}
        let arrB = B.map { return $0}
        
        if A == B {
            for idx in 0..<arrA.count {
                for idy in (idx+1)..<arrA.count {
                    if arrA[idx] == arrA[idy] {
                        return true
                    }
                }
            }
        } else {
            var diff:[Int] = []
            for (idx,valA) in arrA.enumerated() {
                let valB = arrB[idx]
                if valA != valB {
                    diff.append(idx)
                }
            }
            if diff.count == 2 {
                let x1 = diff[0]
                let x2 = diff[1]
                if arrA[x1] == arrB[x2] && arrA[x2] == arrB[x1] {
                    return true
                }
            }
            
        }
        return false
    }
    /*
     给定一个整数数组 A，找到 min(B) 的总和，其中 B 的范围为 A 的每个（连续）子数组。

     由于答案可能很大，因此返回答案模 10^9 + 7。

      

     示例：

     输入：[3,1,2,4]
     输出：17
     解释：
     子数组为 [3]，[1]，[2]，[4]，[3,1]，[1,2]，[2,4]，[3,1,2]，[1,2,4]，[3,1,2,4]。
     最小值为 3，1，2，4，1，1，2，1，1，1，和为 17。
     */
    
    func sumSubarrayMins(_ A: [Int]) -> Int {
        return 0
    }
    
    /*
    给定一个由 0 和 1 组成的数组 A，将数组分成 3 个非空的部分，使得所有这些部分表示相同的二进制值。

    如果可以做到，请返回任何 [i, j]，其中 i+1 < j，这样一来：

    A[0], A[1], ..., A[i] 组成第一部分；
    A[i+1], A[i+2], ..., A[j-1] 作为第二部分；
    A[j], A[j+1], ..., A[A.length - 1] 是第三部分。
    这三个部分所表示的二进制值相等。
    如果无法做到，就返回 [-1, -1]。

    注意，在考虑每个部分所表示的二进制时，应当将其看作一个整体。例如，[1,1,0] 表示十进制中的 6，而不会是 3。此外，前导零也是被允许的，所以 [0,1,1] 和 [1,1] 表示相同的值。

     

    示例 1：

    输入：[1,0,1,0,1]
    输出：[0,3]
    示例 2：

    输出：[1,1,0,1,1]
    输出：[-1,-1]
    */
    func threeEqualParts(_ A: [Int]) -> [Int] {
        return []
    }
}
