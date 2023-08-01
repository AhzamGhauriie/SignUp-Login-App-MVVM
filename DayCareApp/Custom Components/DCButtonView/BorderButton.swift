//
//  BorderButton.swift
//  DayCareApp
//
//  Created by Ahzam Ghori on 28/06/2023.
//

import Foundation
import UIKit

/// This is default class of this app, Purpose of this class is to set base color.
class BorderButton : UIButton {
    
    @IBInspectable var topColor: UIColor? {
        didSet {
        }
    }
    @IBInspectable var bottomColor: UIColor? {
        didSet {
        }
    }
    var gradientNext = CAGradientLayer()
    var currentGradient : Int = 0
    @IBInspectable var isAnimated: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commmonIntialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commmonIntialize()
    }
    override func draw(_ rect: CGRect) {
        addGradient()
    }
    func commmonIntialize() {
        self.backgroundColor = UIColor.clear
        self.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 18)
        self.setTitleColor(UIColor(named: "DarkYellow"), for: .normal)
        self.layer.borderColor = UIColor(named: "DarkYellow")?.cgColor
        self.layer.borderWidth = 3.5
        
    }
    
    private func addGradient() {
        self.backgroundColor = UIColor.clear
        var gradientSet = [[CGColor?]]()
        gradientSet.append([UIColor.clear.cgColor,UIColor.clear.cgColor])
        gradientNext.frame = self.bounds
        gradientNext.colors = gradientSet[currentGradient]
        gradientNext.drawsAsynchronously = true
        gradientNext.cornerRadius = 25
        self.layer.insertSublayer(gradientNext, at :0)
    }
//
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isAnimated { return }
        self.alpha = 0.3
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isAnimated { return }
        
        UIView.transition(with: self, duration: 0.2, options: .curveEaseInOut, animations: { [weak self]  in
            self?.alpha = 1
        }, completion: { [weak self] completed in
            self?.sendActions(for: .touchUpInside)
        })
    }
    
    
}
