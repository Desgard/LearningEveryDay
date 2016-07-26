![](/background.png)

---


## 2016-07-26

### Today's leetcode

[25. Reverse Nodes in k-Group](https://leetcode.com/problems/reverse-nodes-in-k-group/)

题意，一个链表，从表头到表末每k个值进行翻转，如果不够k个数就不翻转。

明明写着**hard**，但是好水啊。。扫k个做个翻转，然后做个递归，over。

```c++
class Solution {
public:
    ListNode* reverseKGroup(ListNode* head, int k) {
        auto node = head;
        for (int i = 0; i < k; ++ i)  {
            if (!node) return head;
            node = node -> next;
        }
        
        auto ahead = reverse(head, node);
        head -> next = reverseKGroup(node, k);
        return ahead;
    }
    
    ListNode* reverse(ListNode* st, ListNode* ed) {
        auto head = ed;
        while (st != ed) {
            auto tmp = st -> next;
            st -> next = head;
            head = st;
            st = tmp;
        }
        return head;
    }
};
```
