////
////  TFView.swift
////  Scout App
////
////  Created by Osama Mansoori on 11/30/20.
////  Copyright © 2020 AppiskeyUser. All rights reserved.
////
//
//import UIKit
//
////MARK:- Protocol's
//@objc protocol TFViewDelegate {
//    @objc optional func TFView(_ field: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
//    @objc optional func TFViewShouldEndEditing(_ field: UITextField) -> Bool
//    //@objc optional func textFieldShouldReturn(_ textField: UITextField) -> Bool
//}
//
//@objc protocol TFViewRightImageDelegate {
//    func rightImageButtonAction(tag: Int)
//}
//
//class TFView: CustomNibView {
//    
//    @IBOutlet weak var titleLabel: BasisGrotesqueProBoldGray16!
//    @IBOutlet weak var bigButton: AppButton!
//    @IBOutlet weak var TfField: AppTextField!
//    @IBOutlet weak var rightImage: AppButton!
//    @IBOutlet weak var leftImage: AppButton!
//    @IBOutlet weak var animatablePlaceholderLbl: BasisGrotesqueProBoldGray16!
//    @IBOutlet weak var TfFieldLeadingConstraint: NSLayoutConstraint!
//    @IBOutlet weak var titleHeight: NSLayoutConstraint!
//    @IBOutlet weak var titleLabelTopViewConstraint: NSLayoutConstraint!
//    @IBOutlet weak var bgView: UIView!
//    @IBOutlet weak var animatablePlaceholderLblLeadingConstraint: NSLayoutConstraint!
//    
//    //MARK:- Type Of View:
//    enum TypeOfView{
//        case dropDown
//        case textField
//        case password
//        case numberField
//        case action
//        case none
//        
//    }
//    //MARK:- Validation:
//    enum Validation {
//        case none
//        case general
//        case firstName
//        case lastName
//        case email
//        case password
//        case normal_password
//        case phone
//    }
//    
//    //MARK:- Variables:
//    var rightImageDelegate: TFViewRightImageDelegate?
//    var delegate: TFViewDelegate?
//    //var textBoxViewModel : TextBoxViewModel!
//    private var textViewType : TypeOfView = .textField
//    private var originalTransformOfAnimatedLbl: CGAffineTransform!
//    private var dropDownAction : (() -> Void)? = nil
//    private var rightImageBtnAction : ((UIButton) -> Void)? = nil
//    private var leftImageBtnAction : ((UIButton) -> Void)? = nil
//    private var placerHolderColor: UIColor = UIColor.black
//    var limitOfCharacters : Int = 340
//    var rightImageTintColor = UIColor.gray{
//        didSet{
//            if self.rightImage.imageView != nil{
//                self.rightImage.imageView?.tintColor = rightImageTintColor
//            }
//        }
//    }
//    var leftImageTintColor = UIColor.gray{
//        didSet{
//            if self.leftImage.imageView != nil{
//                self.leftImage.imageView?.tintColor = leftImageTintColor
//            }
//        }
//    }
//    var fieldTag: String?
//    //MARK:- Setup of UIView:
//    internal override func setupView() {
//        
//        super.setupView()
//        self.rightImage.isUserInteractionEnabled = false
//        self.leftImage.isUserInteractionEnabled = false
//        self.titleHeight.constant = 0
//        self.titleLabelTopViewConstraint.constant = 0
//        //self.TfFieldLeadingConstraint.constant = 0
//        self.animatablePlaceholderLblLeadingConstraint.constant = 0
//     //   self.textBoxViewModel = TextBoxViewModel(delegate: self)
//        self.TfField.autocorrectionType = .no
//        self.TfField.autocapitalizationType = .sentences
//        self.TfField.delegate = self
//        self.TfField.setupFont()        
//        self.TfField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        self.rightImage.addTarget(self, action: #selector(self.rightImageButtonTappedAction(_:)), for: .touchUpInside)
//    }
//    
//    @objc func textFieldDidChange(_ textField: UITextField) {
//      //  self.textBoxViewModel.setFieldText(txt: textField.text ?? "")
//    }
//    
//    @objc func rightImageButtonTappedAction(_ button: UIButton){
//        self.rightImageDelegate?.rightImageButtonAction(tag: TfField.tag)
//    }
//    
//    func setCustomFieldView(fieldTag:String? = nil,
//                            titleLabelTxt: String?=nil,
//                            typeOfView: TypeOfView,
//                            placeholder: String,
//                            placeholderColor: UIColor?=nil,
//                            rightImageView: UIImage?=nil,
//                            rightImageTintColor : UIColor?=nil,
//                            rightImageBtnAction: ((UIButton)->Void)?=nil,
//                            rightImageisUserInteractionEnabled : Bool?=nil,
//                            rightImageTag: Int?=nil,
//                            leftImageView: UIImage?=nil,
//                            leftImageTintColor : UIColor?=nil,
//                            leftImageBtnAction: ((UIButton)->Void)?=nil,
//                            leftImageisUserInteractionEnabled : Bool?=nil,
//                            validation : Validation,
//                            dropDownAction: (() -> Void)?=nil){
//        
//        if rightImageTag != nil {
//            self.TfField.tag = rightImageTag ?? 0
//        }
//        
//        if placeholderColor != nil {
//            self.placerHolderColor = placeholderColor!
//        }
//        
//        self.setTextFieldPlaceHolder(string: placeholder)
//        self.titleLabel.alpha = 0.0
//        self.textViewType = typeOfView
//        textBoxViewModel.fieldValidation = validation
//        
//        if leftImageView != nil{
//            self.animatablePlaceholderLblLeadingConstraint.constant = 10
//            //self.TfFieldLeadingConstraint.constant = 50
//        }else{
//            self.animatablePlaceholderLblLeadingConstraint.constant = -30
//            //self.TfFieldLeadingConstraint.constant = 10
//        }
//        
//        if self.textViewType == .numberField{
//            self.bigButton.isUserInteractionEnabled = false
//            self.TfField.keyboardType = .numberPad
//        }else if self.textViewType == .textField || self.textViewType == .password{
//            self.bigButton.isUserInteractionEnabled = false
//            self.TfField.keyboardType = .default
//            if self.textViewType == .password{
//                self.TfField.isSecureTextEntry = true
//            }
//        }else if self.textViewType == .action {
//            self.TfField.isUserInteractionEnabled = false
//        }else if self.textViewType == .none {
//            self.TfField.isUserInteractionEnabled = true
//            self.TfField.keyboardType = .default
//        }else{
//            self.bigButton.isUserInteractionEnabled = true
//            self.TfField.isUserInteractionEnabled = false
//        }
//        if titleLabelTxt != nil{
//            self.fieldTag = titleLabelTxt
//            self.setTitleLbl(string: titleLabelTxt!)
//        }else{
//            self.titleHeight.constant = 0
//            self.titleLabelTopViewConstraint.constant = 0
//        }
//        
//        if leftImageView != nil{
//            self.leftImage.isUserInteractionEnabled = true
//            self.leftImage.isHidden = false
//            self.leftImage.setImage(leftImageView, for: UIControl.State.normal)
//            self.leftImage.imageView?.contentMode = .scaleAspectFit
//            self.leftImage.isUserInteractionEnabled = leftImageisUserInteractionEnabled!
//            self.leftImageTintColor = UIColor.lightGray
//            if leftImageTintColor != nil{
//                self.leftImage.imageView?.tintColor = leftImageTintColor
//                self.leftImageTintColor = leftImageTintColor!
//            }
//        }else{
//            self.leftImage.isUserInteractionEnabled = false
//            self.leftImage.isHidden = true
//        }
//        
//        if leftImageBtnAction != nil{
//            self.leftImageBtnAction = leftImageBtnAction!
//        }
//        
//        if rightImageView != nil{
//            self.rightImage.isUserInteractionEnabled = true
//            self.rightImage.isHidden = false
//            self.rightImage.setImage(rightImageView, for: UIControl.State.normal)
//            self.rightImage.imageView?.contentMode = .center
//            self.rightImage.isUserInteractionEnabled = rightImageisUserInteractionEnabled!
//            self.rightImageTintColor = UIColor.lightGray
//            if rightImageTintColor != nil{
//                self.rightImage.imageView?.tintColor = rightImageTintColor
//                self.rightImageTintColor = rightImageTintColor!
//            }
//        }else{
//            self.rightImage.isUserInteractionEnabled = false
//            self.rightImage.isHidden = true
//        }
//        
//        if rightImageBtnAction != nil{
//            self.TfField.isSecureTextEntry.toggle()
//            self.rightImageBtnAction = rightImageBtnAction!
//        }
//        
//        if dropDownAction != nil{
//            self.dropDownAction = dropDownAction!
//        }
//        
//        self.backgroundColor = .clear
//        self.bgView.layer.masksToBounds = false
//    }
//    
//    //Set Title Label:
//    func setTitleLbl(string : String){
//        self.titleLabel.text = string
//    }
//    func setText(string : String){
//        if textViewType == .action || textViewType == .none {
//            self.setTextFieldPlaceHolder(string: "")
//        }else{
//            if string != "" {
//                self.animatePlaceHolderLabel()
//            }
//        }
//        self.textBoxViewModel.textFieldText = string
//        self.TfField.text = string
//    }
//    //Set Right Image:
//    func setRightImage(image: String){
//        self.rightImage.setImage(UIImage.init(named: image), for: UIControl.State.normal)
//    }
//    //Set Left Image:
//    func setLeftImage(image: String){
//        self.leftImage.setImage(UIImage.init(named: image), for: UIControl.State.normal)
//    }
//    //Set PlaceHolder Text and Font:
//    func setTextFieldPlaceHolder(string: String){
//        self.TfField.attributedPlaceholder = NSAttributedString(string: "",
//                                                                attributes: [NSAttributedString.Key.foregroundColor: placerHolderColor ])
//        
//        self.animatablePlaceholderLbl.textColor = placerHolderColor
//        self.animatablePlaceholderLbl.text = string
//        self.animatablePlaceholderLbl.sizeToFit()
//    }
//    
//    //MARK:- Animations:
//    func animatePlaceHolderLabel(){
//        self.titleLabelTopViewConstraint.constant = 5
//        self.titleHeight.constant = 15
//        self.originalTransformOfAnimatedLbl = self.animatablePlaceholderLbl.transform
//        self.translateView(viewToAnimate: self.animatablePlaceholderLbl,
//                           translationX: 0.0,
//                           translationY: -40,
//                           completion: nil)
//        
//    }
//    func translateView(viewToAnimate: UIView,
//                       translationX: CGFloat,
//                       translationY: CGFloat,
//                       completion: (() -> Void)?){
//        
//        let originalTransform = viewToAnimate.transform
//        let scaledTransform =
//            
//            originalTransform.translatedBy(x: translationX, y: translationY)
//        UIView.animate(withDuration: 0.3, animations: {
//            viewToAnimate.transform = scaledTransform
//            self.titleLabel.alpha = 1.0
//            self.animatablePlaceholderLbl.isHidden = true
//        }) { (isSuccess) in
//            if completion != nil{
//                completion!()
//            }
//        }
//    }
//    
//    func animatedPlaceholderToOriginalPlace(){
//        self.titleHeight.constant = 0
//        self.titleLabelTopViewConstraint.constant = 0
//        UIView.animate(withDuration: 0.2) {
//            self.animatablePlaceholderLbl.isHidden = false
//            self.animatablePlaceholderLbl.transform = self.originalTransformOfAnimatedLbl
//        }
//    }
//    
//    @IBAction func btnEyeTapped(_ sender: Any) {
//        rightImage.isSelected.toggle()
//    }
//}
//
////MARK:- UITextFieldDelegate:
//extension TFView : UITextFieldDelegate{
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        DispatchQueue.main.async {
//            if textField.text == ""{
//                if self.textViewType == .none {
//                    UIView.animate(withDuration: 0.2) {
//                        self.animatablePlaceholderLbl.isHidden = true
//                    }
//                }else{
//                    self.animatePlaceHolderLabel()
//                }
//                
//            }
//        }
//    }
//    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        DispatchQueue.main.async {
//            if textField.text == ""{
//                if self.textViewType == .none {
//                    UIView.animate(withDuration: 0.2) {
//                        self.animatablePlaceholderLbl.isHidden = false
//                    }
//                }else{
//                    self.titleLabel.alpha = 0.0
//                    self.animatedPlaceholderToOriginalPlace()
//                }
//            }
//        }
//        if delegate != nil{
//            return delegate!.TFViewShouldEndEditing!(textField)
//        }
//        return true
//    }
//    
////    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
////        return self.delegate!.textFieldShouldReturn!(textField)
////    }
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let char = string.cString(using: String.Encoding.utf8)!
//        let isBackSpace = strcmp(char, "\\b")
//        
//        if (textField.text!.count + (string.count - range.length) > self.limitOfCharacters) && isBackSpace != -92 {
//            return false
//        }
//        if textViewType == .password {
//            if (string == " ") {
//                return false
//            }
//        }
//        if delegate != nil{
//            return delegate!.TFView!(textField, shouldChangeCharactersIn: range, replacementString: string)
//        }
//        return true
//    }
//}
//
////MARK:- Extension Of TFView:
//extension TFView: FieldViewVMBinding{
//    func textFieldTextChanged(text: String) {
//        
//        if (textBoxViewModel.fieldValidation == .phone) || self.textViewType == .dropDown{
//            if TfField.text == ""{
//                self.animatePlaceHolderLabel()
//            }
//        }
//        self.TfField.text = text
//    }
//    
//    func errorMessageChanged(text: String) {
//        //AlertView().showPopup(message: text)
//    }
//}
//
////MARK:- FieldViewVMBinding:
//protocol FieldViewVMBinding: class{
//    func textFieldTextChanged(text: String)
//    func errorMessageChanged(text: String)
//}
//
////MARK:- TextBoxViewModel:
//class TextBoxViewModel {
//    
//    var normalaizeField : (() -> Void)?
//    
//    var delegate : FieldViewVMBinding!
//    var textFieldText: String = ""
//    {
//        didSet{
//            delegate.textFieldTextChanged(text: textFieldText)
//        }
//    }
//    var errorMsgText: String = ""{
//        didSet{
//            delegate.errorMessageChanged(text: errorMsgText)
//        }
//    }
//    
//    init(delegate: FieldViewVMBinding) {
//        self.delegate = delegate
//    }
//    
//    func setFieldText(txt: String){
//        self.textFieldText = txt
//    }
//    
//    func setErrorText(txt: String){
//        self.errorMsgText = txt
//    }
//    
//    var fieldValidation : TFView.Validation = .general
//    
//    func validate() -> Bool{
//        guard fieldValidation != .none else {
//            return true
//        }
//        guard textFieldText != "" else {
//            errorMsgText = "Field is required."
//            return false
//        }
//        
//        switch fieldValidation {
//        case .none:
//            return true
//        case .general:
//            if textFieldText.isEmpty {
//                errorMsgText = "Field is required."
//                return false
//            }
//            if (textFieldText.trimmingCharacters(in: .whitespaces).isEmpty) {
//                errorMsgText = "Field is required."
//                return false
//            }
//            return true
//            
//        case .firstName:
//            if (textFieldText.count == 0){
//                errorMsgText = "Enter first name"
//                return false
//            }
//            
//            
//        case .lastName:
//            if (textFieldText.count == 0){
//                errorMsgText = "Enter last name"
//                return false
//            }
//            
//        case .email:
//            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//            if !emailTest.evaluate(with: self.textFieldText) {
//
//                errorMsgText = "Please enter a valid email address."
//
//                return false
//            }
//            
//        case .password:
//           
//            if textFieldText.count < 8 {
//                errorMsgText = "Password must be between 8 and 16 characters which include an upper case, lower case, number, and special characters"
//                return false
//                
//            }else if textFieldText.count > 15 {
//                errorMsgText = "Password must be between 8 and 16 characters which include an upper case, lower case, number, and special characters"
//                return false
//            }
//            else if !self.contains(case: .uppercase, in: textFieldText){
//                errorMsgText = "Password must be between 8 and 16 characters which include an upper case, lower case, number, and special characters"
//                return false
//                
//            } else if !self.contains(case: .lowercase, in: textFieldText){
//                errorMsgText = "Password must be between 8 and 16 characters which include an upper case, lower case, number, and special characters"
//                return false
//                
//            } else if !self.contains(case: .number, in: textFieldText){
//                errorMsgText = "Password must be between 8 and 16 characters which include an upper case, lower case, number, and special characters"
//                return false
//                
//            } else if !self.contains(case: .special, in: textFieldText){
//                errorMsgText = "Password must be between 8 and 16 characters which include an upper case, lower case, number, and special characters"
//                return false
//            }
//        case .normal_password:
//            return true
//        case .phone:
//            return true
//        }
//        self.normalaizeField?()
//        return true
//    }
//    
//    func validateForAnother(text:String) -> Bool {
//        return self.textFieldText == text
//    }
//    
//    private enum PasswordCase: String {
//        case uppercase = ".*[A-Z]+.*"
//        case lowercase = ".*[a-z]+.*"
//        case number = ".*[0-9]+.*"
//        case special = "^(?=.*[-_!?/<>;:{}()*@#.$%^&+=])(?=\\S+$).{4,}$"
//    }
//    
//    private func contains(case pCase:PasswordCase, in searchTerm: String) -> Bool {
//        
//        do {
//            let regex = try NSRegularExpression(pattern: pCase.rawValue)
//            if let _ = regex.firstMatch(in: searchTerm, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, searchTerm.count)) {
//                return true
//            } else {
//                return false
//            }
//            
//        } catch {
//            debugPrint(error.localizedDescription)
//            return false
//        }
//    }
//    
//}
