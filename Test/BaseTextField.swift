//
//  BaseTextField.swift
//  Test
//
//  Created by 邝子涵 on 2018/8/16.
//  Copyright © 2018年 ss. All rights reserved.
//

import UIKit



@objc protocol BaseTextFieldDelegate:NSObjectProtocol {
    // 键盘将要出现
    @objc optional func keyboardWillShowDelegate(textField:BaseTextField, duration:TimeInterval)
    // 键盘将要消失
    @objc optional func keyboardWillHideDelegate(textField:BaseTextField, duration:TimeInterval)
}

class BaseTextField: UITextField {
    
    weak var baseDelegate: BaseTextFieldDelegate?
    
    
    /// 是否执行键盘弹出代理 默认执行
    var isExecuteKeyboard = true
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setNotification()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    func setNotification() {
        // 键盘将要弹出
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        // 键盘将要回弹
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    // MARK: - 键盘将要弹出
    @objc func keyboardWillShow(notification: Notification) {        
        if self.isFirstResponder == false || baseDelegate == nil {
            return
        }
        
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }

        baseDelegate?.keyboardWillShowDelegate?(textField: self, duration: duration)
    }
    
    // MARK: - 键盘将要回收
    @objc func keyboardWillHide(notification: Notification) {
        if self.isFirstResponder == false || baseDelegate == nil {
            return
        }

        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }

        baseDelegate?.keyboardWillHideDelegate?(textField: self, duration: duration)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
}
