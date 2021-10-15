//
//  showAPIViewController.swift
//  GETHUB
//
//  Created by GSM06 on 2021/10/08.
//

import UIKit
import SnapKit
import Then
import OctoKit
import Kingfisher

class showAPIViewController: UIViewController{
    //MARK: -Properies
    private let outBtn = UIButton().then{
        $0.setTitle("뒤로가기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.addTarget(self, action: #selector(dissmissBtn(_:)), for: .touchUpInside)
    }
    private let noUser = UIImageView().then{
        $0.tintColor = UIColor.black
        $0.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
    }
    private let bounds = UIScreen.main.bounds
    
    let notFoundMessage = UILabel().then {
        $0.text = "유저를 찾을 수 없습니다!"
        $0.font = UIFont(name: "Helvetica", size: 18)
        $0.textColor = UIColor.gray
    }
    var username: String?
    var user: (User)?
    private let profileImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.frame = CGRect(x: 0, y: 0, width: 78, height: 78)
        //$0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = $0.frame.width/0.8
        $0.clipsToBounds = true
        $0.layer.masksToBounds = true
    }
    private let nameLabel = UILabel().then {
        $0.font = UIFont(name: "Helvetica", size: 30)
        $0.textColor = .black
    }
    private let follower = UILabel().then{
        $0.font = UIFont(name: "Helvetica", size: 27)
        $0.textColor = .black
    }
    private let following = UILabel().then{
        $0.font = UIFont(name: "Helvetica", size: 27)
        $0.textColor = .black
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        findUser()
        
    }
    func findUser(){
        Octokit().user(name: username!.replacingOccurrences(of: " ", with: "")) { response in
            switch response{
            case .success(let user):
                self.user = user
                DispatchQueue.main.async {
                    self.addsubView()
                    self.configureUI()
                    self.setLayout()
                }
                
            case .failure(let err):
                print(err.localizedDescription)
                DispatchQueue.main.async {
                    self.notFoundUser()
                }
            }
        }
        
    }
    func notFoundUser(){
        view.addSubview(outBtn)
        outBtn.snp.makeConstraints { make in
            make.top.equalTo(bounds.height*0.08)
            make.left.equalTo(bounds.width*0.08)
        }
        view.addSubview(noUser)
        noUser.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bounds.height*0.23)
            make.width.equalTo(bounds.width*0.37)
            make.height.equalTo(bounds.height*0.15)
        }
        view.addSubview(notFoundMessage)
            notFoundMessage.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    func addsubView(){
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(outBtn)
        view.addSubview(follower)
        view.addSubview(following)
    }
    func configureUI(){
        view.backgroundColor = .white
        guard let user = user else {
            return
        }
        profileImageView.kf.setImage(with: URL(string: user.avatarURL!), placeholder: nil, options: nil, completionHandler: nil)
        nameLabel.text = user.name
        
        follower.text = "\(user.numberOfFollowers ?? 0)"
        following.text = "\(user.numberOfFollowing ?? 0)"
    }
    func setLayout(){
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bounds.height*0.17)
            make.width.height.equalTo(200)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bounds.height*0.3)
            make.height.equalTo(bounds.height*0.3)
        }
        outBtn.snp.makeConstraints { make in
            make.top.equalTo(bounds.height*0.08)
            make.left.equalTo(bounds.width*0.08)
        }
        follower.snp.makeConstraints { make in
            make.top.equalTo(bounds.height*0.62)
            make.left.equalTo(bounds.width*0.15)
        }
        following.snp.makeConstraints { make in
            make.top.equalTo(follower)
            make.right.equalToSuperview().inset(bounds.width*0.15)
        }
    }
    @objc func dissmissBtn(_ button: UIButton){
        print("dismiss button Tapped")
        self.dismiss(animated: true, completion: nil)
    }
}
