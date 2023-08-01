//
//  DCButtonView.swift
//  DayCareApp
//
//  Created by Ahzam Ghori on 28/06/2023.
//

import UIKit

class DCButtonView: CustomNibView, CAAnimationDelegate {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgRightView: UIImageView!
    @IBOutlet weak var imgLeftView: UIImageView!
    @IBOutlet weak var button: AppButton!
    @IBOutlet weak var textLabel: BasisGrotesqueProBoldBlack16!
    
    
    private var action : (() -> Void)? = nil

    override func setupView() {
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.makeEdgesCircular()
    }
    
    func makeEdgesCircular(){
        self.bgView.layer.cornerRadius = 10
        self.bgView.clipsToBounds = true
    }
    
    func setAction(actionP: @escaping (() -> Void)){
        self.action = actionP
    }
    
    func setTextColor(color: UIColor){
        self.textLabel.textColor = color.withAlphaComponent(1.0)
    }
    
    func setRightImage(string: String){
        self.imgRightView.image = UIImage(named: string)
    }
    func setLeftImage(string: String){
        self.imgLeftView.image = UIImage(named: string)
    }
    
    func setUIImage(image: UIImage){
        self.button.setUIImage(image: image)
    }
    
    func setTitleLbl(string : String){
        self.textLabel.text = string
        self.textLabel.textAlignment = .center
        self.makeEdgesCircular()
    }
    
    func setBackgroudColor(color: UIColor) {
        self.bgView.backgroundColor = color.withAlphaComponent(1.0)
    }
    
    func setTextSmall(string : String) {
        self.textLabel.text = string
        self.textLabel.textAlignment = .center
        self.textLabel.font = UIFont(name: "BasisGrotesquePro-Bold", size: 12)
        self.textLabel.textColor = UIColor.black
        self.makeEdgesCircular()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if self.action != nil{
            self.action!()
        }
    }
}
