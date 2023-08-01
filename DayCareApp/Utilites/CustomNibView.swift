////
////  CustomNibView.swift
////  DayCareApp
////
////  Created by Ahzam Ghori on 28/06/2023.
////
//
//
//import UIKit
//
//class CustomNibView: UIView {
//
//    private(set) var contentView: UIView!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.setupXIB()
//        self.setupView()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//        self.setupXIB()
//        self.setupView()
//    }
//    
//    func setupView() {
//     //Print Setup:
//    }
//    
//    private func setupXIB() {
//        
//        self.contentView = self.loadView()        
//        self.contentView.frame = self.bounds
//        self.contentView.translatesAutoresizingMaskIntoConstraints = true
//        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.addSubview(self.contentView)
//        
//    }
//    
//    private func loadView() -> UIView {
//        
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: String.init(describing: type(of: self)), bundle: bundle)
//        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
//            return UIView()
//        }
//        return view
//    }
//
//}
