![](/background.png)

---


## 2016-07-25

### Today's leetcode

[347. Top K Frequent Elements](https://leetcode.com/problems/top-k-frequent-elements/)

题意，给一个数组，返回出现次数最多的k歌元素。

思路：先扫一遍数组得出每个数的次数。然后建个堆就好了，插入操作为O(log(k))。这里我用的stl的优先队列，最后再做一次判断即可。当然写个二叉堆也用不了几行。

```c++
typedef pair<int, int> P;
class Solution {
public:
	vector<int> topKFrequent(vector<int>& nums, int k) {
		unordered_map<int, int> cnt;
		for (int i = 0; i < nums.size(); ++ i) {
		    cnt[nums[i]] ++;
		}
		priority_queue<pair<int, int>, vector<pair<int, int> >, greater<pair<int, int> > > q;
		for (auto &x : cnt) {
			if (q.size() < k)
				q.push(make_pair(x.second, x.first));
			else {
				if (q.top().first < x.second) {
					q.pop();
					q.push(make_pair(x.second, x.first));
				}
			}
		}
		vector<int> ans;
		while (!q.empty()) {
			ans.push_back(q.top().second);
			q.pop();
		}
		return ans;
	}
};
```

最近再写python，用python再写一版吧。查完heap的api后，发现姿势好美。

```python
class Solution(object):
    def topKFrequent(self, nums, k):
        cnts = collections.Counter(nums)
        heap = []
        for kk, cnt in cnts.items():
            if len(heap) < k:
                heapq.heappush(heap, (cnt, kk))
            else:
                if heap[0][0] < cnt:
                    heapq.heappop(heap)
                    heapq.heappush(heap, (cnt, kk))
        return [x[1] for x in heap]
```
