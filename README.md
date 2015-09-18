YRJSONAdapter
=============

A simple category for Objective-C  to make JSON easier

支持Cocoapods安装

	   pod 'YRJSONAdapter', '~> 1.0.1'


最新更新20150918：  
增加了对JSONKit的常用方法拦截，解决由于第三方库中使用JSONKit导致应用闪退的问题。

---
之前一直很喜欢JSONKit中的category，使用起来更加的简单快捷。

在iOS5.0以后，系统JSON解析库的产生，尤其是6.0以后性能上的优化，使得我们在使用JSON时可以不再导入其他库，直接使用系统库，但是系统的使用方式略显麻烦，一般需要如下：

	//把一个数组转换成JSON格式
	data=[NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
	//把这个数组恢复回来
	array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
	
	
相比上面这种写法，我更喜欢下面这种：  

	//把一个数组转换成JSON格式
	data=[array JSONData];
	//把这个数组恢复回来
	array=[data objectFromJSONData];
	
或者转成string也很方便：  

	//把一个数组转换成JSON格式
	string=[array JSONString];
	//把这个数组恢复回来
	array=[string objectFromJSONString];
	


因此做了这个小的Category，可以使我们在使用系统JSON库的时候也可以用简洁的语法完成相同的工作，无须再导入其他库。  
这里顺便感谢JSONKit，是我最喜欢的第三方JSON库。

此category功能简单，但一般来说足以满足日常使用。