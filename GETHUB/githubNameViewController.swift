//
//  githubNameViewController.swift
//  GETHUB
//
//  Created by GSM06 on 2021/10/07.
//

import UIKit
import SnapKit
import Then
import OctoKit

class githubNameViewController: UIViewController, UITextFieldDelegate{
    //MARK: -Properties
    let bounds = UIScreen.main.bounds
    let githubLogo = UIImageView(image: UIImage(named: "github logo")) .then{
        $0.backgroundColor = .white
    }
    var userName = UITextField().then{
        $0.backgroundColor = .white
        $0.textColor = .black
        $0.keyboardType = .asciiCapable
        $0.autocapitalizationType = UITextAutocapitalizationType.none
        $0.attributedPlaceholder = NSAttributedString(string: "아이디 입력", attributes:    [NSAttributedString.Key.foregroundColor : UIColor.gray])
        $0.borderStyle = .none
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        $0.layer.masksToBounds = true
        //$0.clearButtonMode = .whileEditing
        $0.backgroundColor = UIColor(red: 0.8784, green: 0.8784, blue: 0.8784, alpha: 1.0)
        $0.setLeftPaddingPoints(20)
        $0.setRightPaddingPoints(20)
    }
    private let okBtn = UIButton().then{
        $0.setTitle("검색", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.delegate = self
        
        addSubview()
        setLayout()
        configureUI()
    }
    //MARK: -Helpers
    func addSubview(){
        view.addSubview(githubLogo)
        view.addSubview(userName)
        view.addSubview(okBtn)
    }
    func setLayout(){
        githubLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bounds.height*0.21)
            make.width.height.equalTo(100)
        }
        userName.snp.makeConstraints { make in
            //make.centerX.equalToSuperview()
            make.left.equalTo(bounds.width*0.1)
            make.top.equalTo(githubLogo.snp.bottom).offset(bounds.height*0.09)
            make.width.equalTo(bounds.width*0.63)
            make.height.equalTo(bounds.height*0.051)
        }
        okBtn.snp.makeConstraints { make in
            make.left.equalTo(userName.snp.right).offset(bounds.width*0.01)
            make.top.equalTo(userName)
            make.height.equalTo(userName)
            make.width.equalTo(bounds.width*0.16)
        }
    }
    func alert(){
        let alert = UIAlertController(title: "오류", message: "아이디를 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "확인", style: .destructive, handler : nil)
        alert.addAction(defaultAction)
        present(alert, animated: false, completion: nil)
    }
    func nextView(){
        let showAPI = showAPIViewController()
        showAPI.username = userName.text!
        showAPI.modalPresentationStyle = .fullScreen
        self.present(showAPI, animated: true, completion: nil)
    }
    func configureUI(){
        view.backgroundColor = .white
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return tapped")
        if (userName.text == "" || userName.text!.contains(" ")){
            alert()
        }
        else {
            nextView()
        }
        userName.text = ""
        return true
    }
    
    //MARK: -Actions
    @objc func buttonTapped(_ button: UIButton){
        print("button Tapped")
        if(userName.text == "" || userName.text!.contains(" ")){
            alert()
        }
        else {
            nextView()
        }
        userName.text = ""
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
func addleftimage(image:UIImage) {
        let leftimage = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        leftimage.image = image
        self.leftView = leftimage
        self.leftViewMode = .always
    }
}
