//
//  LoginViewController.swift
//  Test
//
//  Created by 邝子涵 on 2018/8/16.
//  Copyright © 2018年 ss. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController, BaseTextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textF)
        view.addSubview(btn)
        
        print(textF)
        
        updateWithExpand(isExpanded: false, animated: false)
        
        
    }
    
    
    func updateWithExpand(isExpanded:Bool, animated:Bool, duration:TimeInterval = 1) {
        textF.snp.updateConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.height.equalTo(50)
            
            if isExpanded {
                make.top.equalTo(view.snp.top).offset(200)
            } else {
                make.top.equalTo(view.snp.top).offset(300)
            }
        }
        
        textF.snp.updateConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.height.equalTo(50)
            
            if isExpanded {
                make.top.equalTo(view.snp.top).offset(200)
            } else {
                make.top.equalTo(view.snp.top).offset(300)
            }
        }
        
        btn.snp.updateConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(10)
            make.top.equalTo(textF.snp.bottom).offset(50)
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
        
        if animated == true {
            view.needsUpdateConstraints()
            view.updateConstraintsIfNeeded()
            UIView.animate(withDuration: duration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    @objc func click() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    // MARK: - BaseTextFieldDelegate
    func keyboardWillShowDelegate(textField: BaseTextField, duration: TimeInterval) {
        print("keyboardWillShowDelegate")
        updateWithExpand(isExpanded: true, animated: true, duration: duration)
    }
    
    func keyboardWillHideDelegate(textField: BaseTextField, duration: TimeInterval) {
        print("keyboardWillHideDelegate")
        updateWithExpand(isExpanded: false, animated: true, duration: duration)
    }
    
    
    
    
    // MARK: - ----------------- lazy ---------------------
    lazy var textF: BaseTextField = {
        let textF = BaseTextField()
        textF.baseDelegate = self
        textF.backgroundColor = UIColor.red
        return textF
    }()
    
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.backgroundColor = UIColor.red
        btn.setTitle("注册", for: UIControlState.normal)
        
        btn.addTarget(self, action: #selector(click), for: UIControlEvents.touchUpInside)
        
        return btn
    }()
}
