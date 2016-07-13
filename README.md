![](/background.png)

---


## 2016-07-13

### Today's leetcode

[208. Implement Trie (Prefix Tree)](https://leetcode.com/problems/implement-trie-prefix-tree/)

题意就是构造一颗字典树，要求实现*insert*、*find*、*startsWith*方法。
连统计字符串都不需要，就是一棵多叉树，其实并没有体现出*Trie*的优势。直接上代码。

```cpp
class TrieNode {
public:
    // Initialize your data structure here.
    TrieNode() {
        isTail = false;
        cnt = 0;
        memset(ch, NULL, sizeof(ch));
    }
    TrieNode *ch[26];
    int cnt;
    bool isTail;
};

class Trie {
public:
    Trie() {
        root = new TrieNode();
    }

    void insert(string s) {
        TrieNode *curr = root;
        for (int i = 0; i < s.size(); ++ i) {
            int index = s[i] - 'a';
            if (curr -> ch[index] == NULL) {
                curr -> ch[index] = new TrieNode();
            }
            curr = curr -> ch[index];
        }
        curr -> isTail = true;
        curr -> cnt ++;
    }

    // Returns if the word is in the trie.
    bool search(string key) {
        TrieNode *curr = root;
        for (int i = 0; i < key.size(); ++ i) {
            int index = key[i] - 'a';
            if (curr -> ch[index] == NULL) return false;
            curr = curr -> ch[index];
        }
        if (curr -> isTail == NULL) return false;
        return true;
    }

    // Returns if there is any word in the trie
    // that starts with the given prefix.
    bool startsWith(string prefix) {
        TrieNode *curr = root;
        for (int i = 0; i < prefix.size(); ++ i) {
            int index = prefix[i] - 'a';
            if (curr -> ch[index] == NULL) return false;
            curr = curr -> ch[index];
        }
        return true;
    }

private:
    TrieNode* root;
};

// Your Trie object will be instantiated and called as such:
// Trie trie;
// trie.insert("somestring");
// trie.search("key");
```