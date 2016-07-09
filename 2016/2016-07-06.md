![](/background.png)

---


## 2016-07-06

### Today's leetcode

[128. Longest Consecutive Sequence](https://leetcode.com/problems/longest-consecutive-sequence/)

在一个无序数组中，查找最长连续数字串的长度。

考虑`HashMap`。在第一圈遍历后标记所有数。在第二次遍历后，只需一次最大查询即可完成。思考一下这样问什么能保证效率。倘若数组全部连续，则需要`O(3n)`，倘若有一断点，复杂度为`O(n) + O(n) + O(n - 1) = O(3n - 1) = O(n)`，有两个断点`O(n) + O(n) + O(n - 2) = O(3n - 2) = O(n)`。试想，我们只是在标记非断点数后，继续对其做了一个`O(n)`的遍历处理，而断点越多只会减少复杂度。所以综上复杂度为`O(n)`

另外，通过`HashMap`查询，才能达到以上推导复杂度数。

```cpp
class Solution {
public:
    int longestConsecutive(vector<int>& nums) {
        unordered_map<int, bool> hash;
        for (int i = 0; i < nums.size(); i++) hash[nums[i]] = true;
        int res = 0;
        for (int i = 0; i < nums.size(); i++) {
            int r = nums[i];
            while (hash.find(r) != hash.end()) hash.erase(r ++);
            int l = nums[i] - 1;
            while (hash.find(l) != hash.end()) hash.erase(l --);
            res = max(res, r - l - 1);
        }
        return res;
    }
};
```

- [x] 已完成 **Today's leetcode**


# 专业课考试，书籍停读一天。
