![](/background.png)

---


## 2016-07-10

### Today's leetcode

这几天刚到上海，忙着租房诸多问题，所以暂停了好几天的学习任务。自己也有些愧疚。今天开始恢复学习状态。

[153. Find Minimum in Rotated Sorted Array](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/)
[154. Find Minimum in Rotated Sorted Array II](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array-ii/)

发现了两道同样描述的题，只不过第二题的数据要考虑相同的情况，属于加强数据，那么我们直接来考虑第二题就好了。

题目大意：对于一个有序数组的翻转数组，我们需要查找当中的最小值是多少。

由于数组是部分有序的，我们可以二分最小值。而二分端界的转换可以通过比较`mid`和`left`、`right`的大小关系来重新确定。具体做法是，**根据比较`mid`值和`right`值来判断右端子数组是否已经排序**。

* 情况一 :** 6** 7 0 **1** 2 4 **5**

此时是`nums[mid] < nums[r]`的情况，说明右边数组是已经排序好的，即排除子数组[1, 2, 3, 4]，剩余[6, 7, 0]。此时修改`mid = r`，重新定义二分范围。

* 情况二：**2** 4 5 **6** 7 0 **1**

此时是`nums[mid] > nums[r]`情况。说明最小值此时已经出现在右边数组内。由于`nums[mid]`肯定不是最小值，所以我们从`nums[mid + 1]`作为新的二分数组右值。

* 情况三：** 3 ** 3 3 ** 3 ** 1 2 ** 3 **

此时是`nums[mid] = nums[r]`的情况。这时，我们所需要做的处理是单一缩小范围，让二分边界变为`[l, ..., r - 1]`。

给出代码：

```cpp
class Solution {
public:
    int findMin(vector<int>& nums) {
        int l = 0, r = nums.size() - 1;
        while(l < r) {
            int mid = l + (r - l) / 2;
            if(nums[mid] < nums[r]) r = mid;
            else if(nums[mid] > nums[r]) l = mid + 1;
            else r --;
        }
        return nums[l];
    }
};
```

- [x] 已完成 **Today's leetcode**