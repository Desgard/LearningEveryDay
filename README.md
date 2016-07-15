![](/background.png)

---


## 2016-07-15

### Today's leetcode

[299. Bulls and Cows](https://leetcode.com/problems/bulls-and-cows/)

经典的猜数字游戏。

假设你正在玩猜数字游戏（Bulls and Cows）：你写出4个数字让你的朋友猜，每次你的朋友猜一个数字，你给出一条线索，这个线索告诉你的朋友，有多少个数字位置是正确的（被称为Bulls），有多少个数字位置是不正确的（被称为Cows），你的朋友需要根据这些线索最终猜出正确的数字。

例如，给出的数字是1807，你的朋友猜的是7810，这里用A代表Bulls，B代表Cows，则给出的线索是1A3B。

题目中给出的secret（被猜测数字）和guess（猜测的数字）长度一定是一样的。

个人思路：要注意一个问题，就是出现数字出现的总个数统计。这是一个坑，其他没有别的，注意写代码就可以。

ps. 虽然A掉了，但是觉得这次代码很丑。

```cpp
class Solution {
public:
    int num[20];
    bool vis[1000001];
    string getHint(string secret, string guess) {
        memset(num, 0, sizeof(num));
        memset(vis, 0, sizeof (vis));
        for (int i = 0; i < secret.size(); ++ i) {
            num[secret[i] - '0'] ++;
        }
        int A = 0, B = 0;
        for (int i = 0; i < guess.size(); ++ i) {
            if (secret[i] == guess[i]) {
                A ++;
                num[guess[i] - '0'] --;
                vis[i] = 1;
            }
        }

        for (int i = 0; i < guess.size(); ++ i) {
            if (vis[i]) continue;
            if (num[guess[i] - '0'] > 0) {
                B ++;
                num[guess[i] - '0'] --;
            }
        }
        string As = std :: to_string(A);
        string Bs = std :: to_string(B);

        return As + 'A' + Bs + 'B';
    }
};
```