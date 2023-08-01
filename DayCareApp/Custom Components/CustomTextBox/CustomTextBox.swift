//
//  ViewWithTextField.swift
//  Scholarship
//
//  Created by Appiskey
//  Copyright © 2017 Appiskey. All rights reserved.
//

import UIKit
import Foundation

class CustomTextBox: UIView, NibFileOwnerLoadable {
    
    // Outlets and Variables
    var view: UIView!
    
    
    @IBOutlet weak var showPass: UIButton!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak  var errorLbl: UILabel!
    @IBOutlet weak var lblTop: UILabel!
    
    var isFilled: Bool {
        get {
            
            if textField.text! == "" {
               
                return false
                
            } else {
               
                return true
            }
        }
    }
    
    //    var textBoxViewModel = TextBoxViewModel(delegate: self)
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
        self.textField.autocorrectionType = .no
    }
    
    func xibSetup() {
        
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        
       
        self.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.textField.addTarget(self, action: #selector(textFieldDidEnd(_:)), for: .editingDidEnd)
        
        addSubview(view)
        
        self.setFont()
        self.viewModel.delegate = self
    }
    
    @objc func textFieldDidEnd(_ textField: UITextField) {
        
        let _ = viewModel.validate()
        
    }
    private func setFieldType() {
        
        self.textField.autocorrectionType = .no
        //self.mainView.backgroundColor = UIColor(named: "TextFieldBackground")
        self.textField.backgroundColor = UIColor(named: "TextFieldBackground")
        
        switch viewModel.fieldValidation {
        case .email:
            self.textField.keyboardType = .emailAddress
            textField.autocapitalizationType = .none
        case .password:
            self.showPass.isHidden = false
            self.textField.isSecureTextEntry = true
            textField.autocapitalizationType = .none
       
        case .general, .none:
            self.textField.autocapitalizationType = .words
            
            
        }
    }
    
    @IBAction func iconAction(sender: AnyObject) {
        
        self.textField.isSecureTextEntry =  !self.textField.isSecureTextEntry
        showPass.isSelected = !showPass.isSelected
        
    }
    
    func setFont(placeholder: String = "",
                 placeHolderColor: UIColor = UIColor.red,
                 textColor: UIColor = .white){
        
        let font = UIFont.boldSystemFont(ofSize: 18)
        //        self.textField.placeholder = placeholder
        self.textField.textColor = textColor
        
        self.textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key .foregroundColor: placeHolderColor, NSAttributedString.Key.font : font])
        self.textField.font = font
        
    }
    enum Validation {
        case none
        case general
        case email
        case password
    }
    
    var maxLength: Int = 150
    var viewModel: TextBoxViewModel = TextBoxViewModel()
    
    // Function for load Nib on TextBox
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomTextBox", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    // Function for shake view when not valid
    func shakeView() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 10, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))
        view.layer.add(animation, forKey: "position")
    }
    
    // Function for sest image
    func setImage(string: String){
        
        self.rightImageView.image = UIImage(named:string)
    }
    
    func setTitle(string: String) {
        
    }
    
    override func draw(_ rect: CGRect) {
        // self.mainView.backgroundColor = UIColor(named: "TextFieldBackGround")
//        self.mainView.layer.cornerRadius = 5
//        self.mainView.layer.borderWidth = 0.2
//        self.mainView.layer.borderColor = UIColor.gray.cgColor
//        self.mainView.layer.opacity = 0.8
        
        
    }
    // Function for setting textFieldView
    func setTextFieldView(placeholder: String = "",
                          title: String? = nil,
                          imageName: String? = nil,
                          placeHolderColor: UIColor = .lightGray,
                          textColor: UIColor = UIColor.black,
                          topLabelText: String? = nil,
                          validation: Validation = .general){
        
        self.textField.textColor = textColor//placeHolderColor
        self.textField.backgroundColor = .yellow
        
        
        //        self.lblTop.text = topLabelText
        viewModel.fieldValidation = validation
        self.setFieldType()
        
        self.setFont(placeholder: placeholder,
                     placeHolderColor: placeHolderColor,
                     textColor: textColor)
        if let name = imageName, name != "" , let image = UIImage(named:name) {
            self.rightImageView.image = image
        } else {
            self.rightImageView.image = nil
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let t = textField.text
        self.viewModel.setFieldText(txt: t?.safelyLimitedTo(length: maxLength) ?? "")
        
    }
    
}

extension CustomTextBox: TextBoxViewModelDelegate{
    func setError(with message:String) {
        errorLbl.isHidden = false
        errorLbl.text = message
        mainView.layer.borderColor = UIColor.gray.cgColor
    }
    
    func setTextField(with text:String) {
        DispatchQueue.main.async {
            self.textField.text = text
        }
    }
    func setField() {
        errorLbl.isHidden = true
        mainView.layer.borderColor = UIColor.gray.cgColor
    }
}

extension String {
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
}
protocol TextBoxViewModelDelegate:AnyObject {
    func setError(with message:String)
    func setTextField(with text:String)
    func setField()
    
}
class TextBoxViewModel {
    
    weak var delegate:TextBoxViewModelDelegate?
    
    var textFieldText: String = ""{
        didSet{
            self.delegate?.setTextField(with: textFieldText)
        }
    }
    
    var errorMsgText: String = ""{
        didSet{
            self.delegate?.setError(with: errorMsgText)
        }
    }
    
    func setFieldText(txt: String){
        self.textFieldText = txt
        if self.textFieldText == "" {
            self.delegate?.setError(with: "Field is required")
        } else {
            self.delegate?.setField()
        }
    }
    
    
    func setErrorText(txt: String){
        self.errorMsgText = txt
    }
    
    var fieldValidation : CustomTextBox.Validation = .general
 
    func validate() -> Bool{
        guard fieldValidation != .none else {
            return true
        }
        guard textFieldText != "" else {
            switch fieldValidation {
            case .none:
                errorMsgText = ""
            case .general:
                errorMsgText = "Field is required!"
            case .email:
                errorMsgText = "Email is required!"
            case .password:
                errorMsgText = "Password is required!"
         
         
            }
            
            return false
        }
        
        switch fieldValidation {
        case .none:
            
            return true
        case .general:
            if textFieldText.isEmpty {
                errorMsgText = "Field is required"
                return false
            }
            if (textFieldText.trimmingCharacters(in: .whitespaces).isEmpty) {
                errorMsgText = "Field is required"
                return false
            }
            return true
        case .email:
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            if !emailTest.evaluate(with: self.textFieldText) {
                errorMsgText = "Enter correct email address"
                return false
            }
            
        case .password:
            if textFieldText.count < 8 {
                errorMsgText = "Must contain 8 or more characters"
                return false
                
            } else if !self.contains(case: .uppercase, in: textFieldText){
                errorMsgText = "Must contain uppercase letter"
                return false
                
            } else if !self.contains(case: .lowercase, in: textFieldText){
                errorMsgText = "Must contain lowercase letter"
                return false
                
            } else if !self.contains(case: .number, in: textFieldText){
                errorMsgText = "Must contain number"
                return false
                
            } else if !self.contains(case: .special, in: textFieldText){
                errorMsgText = "Must contain special character"
                return false
            }
        }
        self.delegate?.setField()
        return true
    }
    
    func validateForAnother(text:String) -> Bool {
        return self.textFieldText == text
    }
    
    private enum PasswordCase: String {
        case uppercase = ".*[A-Z]+.*"
        case lowercase = ".*[a-z]+.*"
        case number = ".*[0-9]+.*"
        case special = "^(?=.*[-_!?/<>;:{}()*@#$%^&+=])(?=\\S+$).{4,}$"
    }
    private func contains(case pCase:PasswordCase, in searchTerm: String) -> Bool {
        
        do {
            let regex = try NSRegularExpression(pattern: pCase.rawValue)
            if let _ = regex.firstMatch(in: searchTerm, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, searchTerm.count)) {
                return true
            } else {
                return false
            }
            
        } catch {
            debugPrint(error.localizedDescription)
            return false
        }
    }
}

//extension CustomTextBox : UITextFieldDelegate {
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        if self.viewModel.fieldValidation == .email {
//            if range.location == 0, string != "", string.first! == " " {
//                return false
//            }
//            if string != "" , ((textField.text!.count + (string.count - range.length)) >= 2), textField.text!.last! == " ", string.last! == " " {
//                return false
//            }
//            let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
//            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
//            let typedCharacterSet = CharacterSet(charactersIn: string)
//            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
//            return alphabet
//        }
//        if self.viewModel.fieldValidation == .general{
//            if range.location == 0, string != "", string.first! == " " {
//                return false
//            }
//        }
//        return true
//    }
//}
