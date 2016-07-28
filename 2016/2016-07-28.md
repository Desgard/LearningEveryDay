![](/background.png)

---


## 2016-07-27

### Today's leetcode

[338. Counting Bits](https://leetcode.com/problems/counting-bits/)

题意，搜出小于等于num所有数的1的个数。

第一反应，一维分组dp。从1开始将数分为左len - 1位，右边分为1位。我们可以左len - 1位在开始的时候是0，所以它之后的位数再后都可以通过前面的计数来得到。

> dp[i] = dp[i >> 1] + (i) & 1;

```c++
class Solution {
public:
    vector<int> countBits(int num) {
        vector<int> res;
        res.push_back(0);
        
        for (int i = 1; i <= num; ++ i) {
            int x = i & 1;
            int y = i >> 1;
            res.push_back(res[y] + x);
        }
        return res;
    }
};
```
