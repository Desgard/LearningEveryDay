![](/background.png)

---


## 2016-07-11

### Today's leetcode

[62. Unique Paths](https://leetcode.com/problems/unique-paths/)

又随机了一道大水题。`100 * 100`规模显然无法bfs，那么就`dp`一下呗，反正依赖状态就是上一个单一状态。

> dp[m][n] = dp[m - 1][n] + dp[m][n - 1]

另外，这题在组合数学里面有一个`O(1)`的公式，我突然想不起来了。回来再加一种算法，这次先给出dp代码。

```cpp
class Solution {
public:
    int uniquePaths(int m, int n) {
        int dp[110][110];
        for (int i = 0; i <= 100; ++ i) {
            for (int j = 0; j <= 100; ++ j) {
                dp[i][j] = 1;
            }
        }
        for (int i = 1; i < m; ++ i) {
            for (int j = 1; j < n; ++ j) {
                dp[i][j] = dp[i - 1][j] + dp[i][j - 1];
            }
        }
        return dp[m - 1][n - 1];
    }
};
```

- [x] 已完成 **Today's leetcode**
