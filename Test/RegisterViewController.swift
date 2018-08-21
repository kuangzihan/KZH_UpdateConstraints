//
//  RegisterViewController.swift
//  Test
//
//  Created by 邝子涵 on 2018/8/16.
//  Copyright © 2018年 ss. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textF)
        
        print(textF)
        
        textF.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.height.equalTo(50)
            make.top.equalTo(view.snp.top).offset(200)
        }
    }
    
    
    // MARK: - ----------------- lazy ---------------------
    lazy var textF: BaseTextField = {
        let textF = BaseTextField()
        textF.isExecuteKeyboard = false
        textF.backgroundColor = UIColor.yellow
        return textF
    }()
    

    deinit {
        print("释放")
    }
}
