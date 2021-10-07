//
//  LoginViewController.swift
//  GETHUB
//
//  Created by GSM06 on 2021/10/06.
//

import UIKit

class LoginViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let lab = UILabel()
        view.backgroundColor = .white
        lab.text = "asd"
        view.addSubview(lab)
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lab.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
