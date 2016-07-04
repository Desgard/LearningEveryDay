![](/background.png)

---


## 2016-07-05

### Today's leetcode

[367. Valid Perfect Square](https://leetcode.com/problems/valid-perfect-square/)

一道很套路的题目。判断是否为平方数。基本上，这道题目是所有acmer的素质性题目吧。一个二分就可以搞定。我们先写一个复杂度估计程序。

```cpp
int main () {
    cout << LLONG_MAX << endl;
    cout << sqrt(LLONG_MAX) << endl;
    cout << log(sqrt(LLONG_MAX)) << endl;
    return 0;
}
```
* 第一个数是测试数据中可能出现的最大值
* 第二个数值是我们二分答案中的最大值，也就是二分上限范围
* 第三个是算法复杂度。

我们可以看出，如果给定数据量是在64位有符号数的范围内，我们使用二分的复杂度为*O(21.8) = O(1)*，基本上是一个常数级别的运算。当然，我们考虑的数是整形数据。在复杂度分析的基础上，我们写出代码：

```cpp
class Solution {
public:
    bool isPerfectSquare(int num) {
        long long l = 1, r = 3.1e9;
            while (l <= r) {
                long long mid = (l + r) >> 1;
                long long sqr = mid * mid;
                if (sqr == num) return true;
                if (sqr > num) r = mid - 1;
                else l = mid + 1;
            }
        return false;
    }
};
```

- [x] 已完成 **Today's leetcode**


### Reading *iOS Core Animation: Advanced Techniques*


- [ ] Finish iOS Core Animation: Advanced Techniques


### Reading *iOS开发进阶* 

- [ ] 已完成 **Reading iOS开发进阶**
