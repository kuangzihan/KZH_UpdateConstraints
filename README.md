> 笔记风格借鉴[Knight_SJ](http://www.jianshu.com/users/3dd433cb3ea1)

# 需求点：
***
通过触发键盘实现更新视图约束的动画效果，网上有很多通过Masonry实现动画更新约束的教程，本人用Swift简单实现了下，新人勿喷~如果有写的不好的地方，请大牛指点。
效果如下：


![效果图.gif](http://upload-images.jianshu.io/upload_images/1955939-f21214b1bfd7e519.gif?imageMogr2/auto-orient/strip)


**特点：**
获取键盘弹出和回收时间，实时更新约束，实现弹出或回收键盘与更新约束动画时间同步。

**更新约束一共分为三个步骤**：
1. 创建键盘弹出和隐藏系统通知
2. 实现通知方法
3. 通过调用needsUpdateConstraints及updateConstraintsIfNeeded实现动画更新


## 示例Demo：

触发弹出或回收键盘通知方法中改变约束

1、首先创建键盘弹出和隐藏系统通知

```
	// 键盘将要弹出
	NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
	        
	// 键盘将要回弹
	NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
```

2、实现通知方法

```
	// MARK: - 键盘将要弹出
	func keyboardWillShow(notification: Notification) {
		  let userInfo = notification.userInfo
	  	  let aValue = userInfo?[UIKeyboardAnimationDurationUserInfoKey]
	  	  SLLog("弹出\(aValue!)")
	        
	  	   // 判断是否是第一次触发开始编辑，如果是第一次则改变约束
	  	   if isUpdataExpand == false {
	  	      updateWithExpand(isExpanded: true, animated: true, duration: aValue! as! TimeInterval)
	  	      isUpdataExpand = true
	  	   }
	}
	
	// MARK: - 键盘将要回收
	func keyboardWillHide(notification: Notification) {
			let userInfo = notification.userInfo
	        let aValue = userInfo?[UIKeyboardAnimationDurationUserInfoKey]
	        SLLog("回收\(aValue!)")
	        updateWithExpand(isExpanded: false, animated: true, duration: aValue! as! TimeInterval)
			// 回收把isUpdataExpand设置为false
	        isUpdataExpand = false
	}

```

3.更新约束

```
    // MARK: - 更新约束
    func updateWithExpand(isExpanded:Bool, animated:Bool, duration:TimeInterval = 0.25) {
        // 重要：更新约束需要调用updateConstraints闭包
        soolifeImg.snp.updateConstraints { (make) in
            if isExpanded == false{
                make.centerX.equalTo(self)
                make.width.equalTo(SCREEN_W/4)
                make.top.equalTo(self.snp.top).offset(AD_HEIGHT(90))
                make.height.equalTo(AD_HEIGHT(120))
            }else{
                make.centerX.equalTo(self)
                make.width.equalTo(SCREEN_W/5)
                make.top.equalTo(self.snp.top).offset(AD_HEIGHT(50))
                make.height.equalTo(AD_HEIGHT(80))
            }
        }
        
        accountIT.snp.updateConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(AD_WIDTH(15))
            make.right.equalTo(self.snp.right).offset(AD_WIDTH(-15))
            make.height.equalTo(AD_HEIGHT(45))
            if isExpanded == false{
                make.top.equalTo(soolifeImg.snp.bottom).offset(AD_HEIGHT(60))
            }else{
                make.top.equalTo(soolifeImg.snp.bottom).offset(AD_HEIGHT(40))
            }
        }
        
        passwordIT.snp.updateConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(AD_WIDTH(15))
            make.right.equalTo(self.snp.right).offset(AD_WIDTH(-15))
            make.height.equalTo(AD_HEIGHT(45))
            make.top.equalTo(accountIT.snp.bottom).offset(AD_HEIGHT(5))
        }
        
        loginBtn.snp.updateConstraints { (make) in
            make.top.equalTo(passwordIT.snp.bottom).offset(AD_HEIGHT(40))
            make.left.equalTo(self.snp.left).offset(AD_WIDTH(20))
            make.right.equalTo(self.snp.right).offset(AD_WIDTH(-20))
            make.height.equalTo(AD_HEIGHT(40))
        }
        
        
        if animated == true {
            // 告诉self.view约束需要更新
            self.needsUpdateConstraints()
            // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
            self.updateConstraintsIfNeeded()
            // 更新动画
            UIView.animate(withDuration: duration, animations: {
                self.layoutIfNeeded()
            })
        }
    }
```



[可移步至简书查看](https://www.jianshu.com/p/0b194d331213)