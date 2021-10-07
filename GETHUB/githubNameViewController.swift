//
//  githubNameViewController.swift
//  GETHUB
//
//  Created by GSM06 on 2021/10/07.
//

import UIKit
import SnapKit
import Then

class githubNameViewController: UIViewController{
    //MARK: -Properties
    let bounds = UIScreen.main.bounds
    let githubLogo = UIImageView(image: UIImage(named: "github logo")) .then{
        $0.backgroundColor = .orange
    }
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setLayout()
        configureUI()
    }
    //MARK: -Helpers
    func addSubview(){
        view.addSubview(githubLogo)
    }
    func setLayout(){
        githubLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bounds.height*0.5)
            make.width.height.equalTo(300)
        }
    }
    func configureUI(){
        view.backgroundColor = .white
    }
    //MARK: -Actions
}
