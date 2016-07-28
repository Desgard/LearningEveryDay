![](/background.png)

---


## 2016-07-28

### Today's leetcode

[229. Majority Element II](https://leetcode.com/problems/majority-element-ii/)

这题是我接触的新的类型，需要运用**多数投票算法（Majority Vote Algorithm）**。其实可以根据*统计超过一半数字问题*迁移过来。在统计超过一半数字问题中，我的思路是利用歌巢原理来进行计数计算，其实对于长度为`len`的数组来说，如果想找出`len / n`的数字，我们可以存`n - 1`个数来统计出现频率。

逆推一下，`(n - 1) * len / n < len`，而`n * len / n = len`。所以我们对其向下取整，可以判断出数量最多为`n - 1`个。

具体可以见[这里](http://www.cs.utexas.edu/users/moore/best-ideas/mjrty/index.html)。

> **A Linear Time Majority Vote Algorithm**

> This algorithm, which Bob Boyer and I invented in 1980 decides which element of a sequence is in the majority, provided there is such an element. 



```c++
class Solution {
public:
    vector<int> majorityElement(vector<int>& nums) {
        vector<int> res;
        if (nums.size() == 0) return res;
        int num1, num2, cnt1, cnt2;
        num1 = num2 = cnt1 = cnt2 = 0;
        for (int i = 0; i < nums.size(); ++ i) {
            if (num1 == nums[i]) cnt1 ++;
            else if (num2 == nums[i]) cnt2 ++;
            else if (cnt1 == 0) {
                cnt1 = 1; 
                num1 = nums[i];
            } 
            else if (cnt2 == 0) {
                cnt2 = 1;
                num2 = nums[i];
            }
            else {
                cnt1 --;
                cnt2 --;
            }
        }
        cnt1 = cnt2 = 0;
        for (int i = 0; i < nums.size(); ++ i) {
            if (nums[i] == num1) cnt1 ++;
            if (nums[i] == num2) cnt2 ++;
        }
        
        if (cnt1 > nums.size() / 3) res.push_back(num1);
        if (cnt2 > nums.size() / 3 && num1 != num2) res.push_back(num2);
        return res;
    }
};
```


