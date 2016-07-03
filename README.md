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


### Reading *iOS Core Animation: Advanced Techniques*
* Layout
  * The **frame** represents the *orter* coordinates of the layer.
  * The **bounds** property represents the *inner* coordinates
  * The **center** and **position** both represent the location of the **anchorPoint** relative to the superlayer
  * Frame is a virtual property, computed from the bounds, positon, and transform, and therefore changes when any of those properties are modified.
  * The frame width and height may no longer match the bounds.

### Reading *iOS开发进阶* 『Page 85』

```Objective-C
- (BOOL)application: (UIApplication *)application didFinishLauningWithOptions: (NSDictionary *)launchOptions {
	NSObject *object = [[NSObject alloc] init];
	NSLog(@"Reference Count = %u", [object retainCount]);
	[object release];
	NSLog(@"Reference Count = %u", [object retainCount]);
	return YES;
}
```

> 为什么对象被收回后，引用计数是0而不是1？

因为当最后一次执行`release`时，系统知道马上就要回收内存了，就没有必要再将`retainCount`减1了，因为无论减不减1，改对象都肯定会被回收，而对象被回收后，它的所有内存区域包括`retainCount`值也编的没有意义。不将这个值从1变回0，**可以减少一次内存的操作，加速对象的回收**。


