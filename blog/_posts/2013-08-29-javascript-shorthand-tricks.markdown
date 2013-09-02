---
layout: post
title:  "JavaScript Tricks I Like"
date:   2013-08-29 00:45:30
categories: blog
page_id: blog
tags: javascript tricks development
---

JavaScript is perhaps one of my favorite languages. And after working with JavaScript for about 3 to 4 years as of my initial writing of this post (I'll probably add more as I learn more stuff), I've picked up a few tricks that I use quite a bit.

###1. Ternary Operators###

If you ever find yourself writing conditionals like this:

{% highlight javascript %}
	if(glassEmpty) {
		action = 'fill-with-beer';
	}
	else {
		action = 'drink-beer';
	}
{% endhighlight %}
	
You can write it like this:

{% highlight javascript %}
	action = glassEmpty ? 'fill-with-beer' : 'drink-beer';
{% endhighlight %}

Some things to remember:

- The value after the question mark is returned when the condition is true, the value after the colon is returned when the condition is false.

- These values are returned. You should not use this as an if statement to run code that is not trying to return a value.

###2. Triple Equals###

Usually, when you are writing a conditional statement, you probably use "==" or "!=" to check the value of variables.
Unfortunately, sometimes this may bite you in the ass if the types don't match and you want them to. Also, using "===" has a possible speed benefit because your values do not need to go through the process of type conversion.

When possible, you should be using "===" in place of "==" and "!==" in place of "!=". Triple equals not only check for value equality, but also type equality. The code below will log to the console: "Equal!" because when using the "==" operator, JavaScript attempt to convert the values so that they match and compare the values.

{% highlight javascript %}
	if(100 == '100') {
		console.log('Equal!');
	}
	else {
		console.log('Not Equal!');
	}
{% endhighlight %}

However, this below will log to the console: "Not Equal!" because the types do not match despite them both saying 100.

{% highlight javascript %}
	if(100 === '100') {
		console.log('Equal!');
	}
	else {
		console.log('Not Equal!');
	}
{% endhighlight %}

All in all, if type equality is definitely important, you probably already use these. If you're not sure if type equality is important, you should probably use these to make sure your data stays consistent!

###3. Boolean value shorthand###

Instead of writing:

{% highlight javascript %}
	var glassEmpty = true,
		isDrunk = false;
{% endhighlight %}

The following would be equivalent:

{% highlight javascript %}
	var glassEmpty = !0,
		isDrunk = !1;
{% endhighlight %}

###4. Null/Undefined Checking Shorthand###

Sometimes you probably write an if statement to check the value of a variable, and verify if the variable is null or undefined like so:

{% highlight javascript %}
	if(cashAmount !== undefined && cashAmount !== null && cashAmount > 0) {
		moneyForBeer = cashAmount;
	}
	else {
		moneyForBeer = 0;
	}
{% endhighlight %}

But instead, this nice easy short hand makes your life easier, and your JS file smaller:

{% highlight javascript %}
	moneyForBeer = cashAmount || 0;
{% endhighlight %}

###5. jQuery Document Ready shorthand###

If you're a JS developer, you know what jQuery is. And so I am sure you know this, but instead of writing:

{% highlight javascript %}
	$(document).ready(function(){
		//Your code here
	});
{% endhighlight %}

You should be writing:

{% highlight javascript %}
	$(function(){
		//Your code here
	});
{% endhighlight %}

Also, keep in mind here that waiting for the $(document).ready(); to execute your code may not always be the best thing to do. There are times when your code doesn't need to wait for the document to be ready (hint: look at jQuery's [on()][jquery_on_function] function).


Thanks for reading and feel free to follow my [Twitter][twitter] for random tweets and updates on my blog and my [Github][github] for some of my projects.

[jquery_on_function]: http://api.jquery.com/on/
[github]: https://github.com/chienhungchen
[twitter]:    http://twitter.com/jeffchen330