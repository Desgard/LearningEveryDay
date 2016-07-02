![](background.png)

---

## 2016-07-03

### Today's leetcode

[342. Power of Four](https://leetcode.com/problems/power-of-four/)

今天Pick了一道很简单的题目，题干是**判断一个数是否为4的次方数。**我们来解决一下：

![](source/16-07-03-00.png)

当然这只是一个充分条件，我们需要缩小一下`3k+1`的范围。即我们需先判断这个数是否为2的次方数即可，利用二级制的`x & (x - 1)`即可。

代码如下：

```cpp
class Solution {
public:
    bool isPowerOfFour(int num) {
        return num > 0 && !(num & (num - 1)) && (num - 1) % 3 == 0;
    }
};
```
