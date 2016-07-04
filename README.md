![](/background.png)

---


## 2016-07-04


### Today's leetcode

[165. Compare Version Numbers](https://leetcode.com/problems/compare-version-numbers/)

题目大意就是给出两个版本号`v1`和`v2`，比较大小。由于版本号的字符串格式都是`xxx.xxx.xxx.xxx`，所以用`.`来分割成多个数字，在分割中每次比较一下之前的数的大小即可。

```cpp
class Solution {
public:
    int compareVersion(string version1, string version2) {
        if (version1.compare(version2) == 0) {
            return 0;
        }
        int len1 = version1.size(), len2 = version2.size();
        int i = 0, j = 0;
        while (i < len1 || j < len2) {
            int t1, t2; t1 = t2 = 0;
            while (i < len1 && version1[i] != '.') {
                t1 = t1 * 10 + (version1[i] - '0');
                i ++;
            }
            while (j < len2 && version2[j] != '.') {
                t2 = t2 * 10 + (version2[j] - '0');
                j ++;
            }
            if (t1 < t2) return -1;
            if (t1 > t2) return 1;
            i ++, j ++;
        }
        return 0;
    }
};
```

- [x] 已完成 **Today's leetcode**


### Reading *iOS Core Animation: Advanced Techniques*

#### Visual Effects

* Rounded Corners
  * [离屏渲染机制](https://www.objc.io/issues/3-views/moving-pixels-onto-the-screen/)
  * A floating-point number that defines the stroke thickness in points.
  * Retained `CGColorRef ` properties must be declared using `assign`


- [x] Finish iOS Core Animation: Advanced Techniques


### Reading *iOS开发进阶* 

读到『Page 117』，无收获。

- [x] 已完成 **Reading iOS开发进阶**

### Reading Blog Post

[POP介绍与使用实践(快速上手动画)](http://adad184.com/2015/03/11/intro-to-pop/)

