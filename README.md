![](background.png)

---

## 2016-07-03

### Today's leetcode

[342. Power of Four](https://leetcode.com/problems/power-of-four/)

今天Pick了一道很简单的题目，题干是**判断一个数是否为4的次方数。**我们来解决一下：

\begin{align}
4^n = (3 + 1)^n = C_n^0 \cdot 3^0 \cdot 1^n + C_{n-1}^1 \cdot 3^1 \cdot 1^{n - 1} + ...+ C_n^n \cdot 3^n \cdot 1^0
\end{align}

发现$C_n^0 \cdot 3^0 \cdot 1^n = 1$，所以$4^n = 3k+ 1$。当然这只是一个充分条件，我们需要缩小一下$3k+1$的范围。即我们需先判断这个数是否为$2^n$即可，利用二级制的`x & (x - 1)`即可。

代码如下：

```cpp
class Solution {
public:
    bool isPowerOfFour(int num) {
        return num > 0 && !(num & (num - 1)) && (num - 1) % 3 == 0;
    }
};
```
