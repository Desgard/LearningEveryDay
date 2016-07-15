![](/background.png)

---


## 2016-07-14

### Today's leetcode

[328. Odd Even Linked List](https://leetcode.com/problems/odd-even-linked-list/)

将一个链表按照奇偶顺序组织成链表。只要做两个指针就可以了。没有难度。

```cpp
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    ListNode* oddEvenList(ListNode* head) {
        if (!head) return head;
        ListNode *odd = head, *eve = head -> next, *eveHead = eve;
        while (odd -> next && eve -> next) {
            odd -> next = eve -> next;
            odd = odd -> next;
            eve -> next = odd -> next;
            eve = eve -> next;
        }
        odd -> next = eveHead;
        return head;
    }
};