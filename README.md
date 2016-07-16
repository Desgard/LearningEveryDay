![](/background.png)

---


## 2016-07-16

### Today's leetcode

[60. Permutation Sequence](https://leetcode.com/problems/permutation-sequence/)

给出1~n的全排列数字，让求出在全排列的所有方式中第k个排列什么。

自己按照组合数的方式推了一下，最后发现按每一位(n - x)!来逆推即可。其实，这种全排列背景的算法叫[康托展开(https://zh.wikipedia.org/zh/%E5%BA%B7%E6%89%98%E5%B1%95%E5%BC%80)。

```cpp
class Solution {
public:
    string getPermutation(int n, int k) {
        vector<int> v;
        int cnt = 1;
        for (int i = 0; i < n; ++ i) {
            v.push_back(i + 1);
            cnt = cnt * (i + 1);
        }
        k = k - 1;
        string ans = "";
        for (int i = 0; i < n; ++ i) {
            cnt = cnt / (n - i);
            int ind = k / cnt;
            ans += std :: to_string(v[ind]);
            v.erase(v.begin() + ind);
            k %= cnt;
        }
        return ans;
    }
};
```