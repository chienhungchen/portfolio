---
layout: post
title:  "Use Jekyll For JavaScript Projects!"
date:   2013-09-21 10:02:00
categories: blog
page_id: blog
page_disqus_id: "blog/use-jekyll-for-javascript-projects"
tags: javascript jekyll jQuery development
---

I love working on JavaScript libraries / jQuery plugins. I love it because it's my favorite language, you can make it look like you're working on a live site on an airplane (which is what I am doing right now), and because of the great open-source community that has grown around it.

However, one of the annoyances with building JavaScript libraries is trying to work on it as if you are working on a live site (especially when you're setting up demos of your JS stuff). Most of the time, when I'm working on a JavaScript library locally, I access it in the browser via some nasty location string that looks like:

{% highlight javascript %}
	file://localhost/Users/yourname/Documents/code/projects/your-script.js/demos/index.html
{% endhighlight %}

But then, especially during those times when you need to access some more scripts or content or something via another path, I'd have to access it via some relative path that just isn't what you would usually use in a live site:

{% highlight html %}
	src="../../../derplocation/script-i-need.js"
{% endhighlight %}

or:

{% highlight html %}
	src="/Users/yourname/Documents/code/projects/your-script.js/demos/derplocation/script-i-need.js"
{% endhighlight %}

In comes Jekyll. It's lightweight, easy to install and get up and running. I've started using it when developing demos for JavaScript libraries and plugins because it is so easy to work with. You can run your site locally, but have the benefits of using it like you would in a live site (when it comes to the issues above).

It compiles your templates, markdown, and html markup into html files that can be served up via the default WebBrick server. And from there, it acts like any site hosted locally at localhost.

Try it out, perhaps it'll make your life easier as a JavaScript developer.


Tweet me at [@jeffchen330][twitter] with your thoughts on using Jekyll this way or if you have better ideas for working with JavaScript locally. Also, check out my [Github][github] for some of my JS stuff.

[github]: http://github.com/chienhungchen
[twitter]:    http://twitter.com/jeffchen330