The main intent of the project is to test user-invoked refresh and
browser�s behavior after that.

In theory F5 should lead to no request (if resource is in the cache and
is fresh) or conditional request (in case when resource is in the cache,
but not fresh anymore). CTRL+F5 on the other hand should lead to
unconditional request, bypassing the cache altogether. Another thing I
noted is that Cache-Control: no-cache and Pragma: no cache headers were
added to requests after pressing CTRL+F5 in Chrome.

My test page contains three .js resources, one of them has
Cache-Control: no-cache in its response header. Another one has
Cache-Control: private, max-age=15. And the last one has no cache
preferences. I preform different actions such as pressing F5, CTRL+F5,
click on refresh button, Back/Forward buttons navigation and so on and
note differences between cache behavior and difference between headers
in conditional/unconditional requests to the server.

All results could be combined in such table

![image][]

You can find more details in [my blog post][]

  [image]: http://podlipensky.com/wp-content/uploads/image_thumb_30.png
  [my blog post]: http://podlipensky.com/2012/03/behind-refresh-button/