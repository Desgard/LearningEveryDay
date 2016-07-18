![](/background.png)

---


## 2016-07-19

### Today's leetcode

[48. Rotate Image](https://leetcode.com/problems/rotate-image/)

题意很简单，90°旋转一个矩阵。采用先上下翻转，再按左对角线变换即可。

```bash
1 2 3     7 8 9     7 4 1
4 5 6  => 4 5 6  => 8 5 2
7 8 9     1 2 3     9 6 3
```

个人作答：
```cpp
class Solution {
public:
    void rotate(vector<vector<int>>& matrix) {
        reverse(matrix.begin(), matrix.end());
        for (int i = 0; i < matrix.size(); ++ i) {
            for (int j  = 0; j < i; ++ j) {
                swap(matrix[i][j], matrix[j][i]);
            }
        }
    }
};
```