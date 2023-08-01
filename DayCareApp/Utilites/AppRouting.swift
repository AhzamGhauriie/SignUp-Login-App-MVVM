////
////  AppRouting.swift
////  Mischief Maker
////
////  Created by Muhammad Ali Maniar on 19/06/2018.
////  Copyright © 2018 Appiskey. All rights reserved.
////
//
//import Foundation
//import UIKit
//
///// App class for navigation.
//class AppRouter {
//    
//    // APNS Push Notifications on Device Token:
//    static var imagePicked: Bool = false
//    
//    enum Navigation {
//        case push
//        case present
//        case modal
//        case modalFromBottom
//        case popTo
//        case presentBottom
//    }
//    
//    enum BackNavigation {
//        case dismiss
//        case pop
//        case root
//    }
//    /// Static function which cast class into object type from storyboard
//    /// i.e let vc:SomeClassController = AppRouter.instantiateViewController(storyboard: .stordyboardname)
//    /// This will cast vc automatically to SomeClassController
//    ///
//    /// - Parameters:
//    ///   - storyboard: storyboard from listed storyboards
//    ///   - bundle: can be nil which change to default automatically.
//    /// - Returns: Intialized object of class.
//    static func instantiateViewController<controller: UIViewController>(storyboard: UIStoryboard.Storyboard, bundle: Bundle? = nil ) -> controller {
//        
//        guard let viewController = UIStoryboard(name: storyboard.filename, bundle: bundle).instantiateViewController(withIdentifier: controller.identifier) as? controller else {
//            fatalError("Couldn't instantiate view controller with identifier \(controller.identifier) ")
//        }
//        
//        return viewController
//    }
//    
//    /// Static function which cast class into object of UINib
//    /// i.e let vc:SomeClassController = AppRouter.instantiateViewControllerFromNib()
//    /// This will cast vc automatically to SomeClassController
//    ///
//    /// - Parameter bundle: can be nil which change to default automatically.
//    /// - Returns: Intialized object of class.
//    static func instantiateViewControllerFromNib<controller: UIViewController>(bundle: Bundle? = nil ) -> controller {
//        let viewController = controller(nibName: controller.identifier, bundle: bundle)
//        return viewController
//        
//    }
//    
//    //MARK:- setting initial root view controller:
//    static func decideAndMakeRoot() {
//        
//      
//    
//}
//
//
//
//// MARK: - Storyboards
//extension UIStoryboard {
//    
//    /// Define everystoryboard name here. start your every storyboard name with capitalized string, otherwise it will crash.
//    enum Storyboard : String {
//        
//        case Tabbar
//        case Home
//        case Setting
//        case Tests
//        case MFM
//        case Auth
//        case Task
//        
//        /// Capitalize everyStoryboard name.
//        var filename : String {
//            return rawValue
//        }
//    }
//}
//
//extension UIViewController  {
//    
//    /// Add functionality to every viewController to get string of it's class(viewController) name
//    static var identifier: String {
//        return String(describing: self)
//    }
//}
//
//
//protocol Routeable {
//    func route(to vc: UIViewController, navigation:AppRouter.Navigation)
//    func routeBack(navigation backNavigation:AppRouter.BackNavigation)
//    func setToRoot()
//}
//extension Routeable where Self:UIViewController {
//    
//    func route(to vc: UIViewController, navigation:AppRouter.Navigation) {
//        switch navigation {
//        case .push:
//            DispatchQueue.main.async {
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        case .present:
//            DispatchQueue.main.async {
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true, completion: nil)
//            }
//        case .modal:
//            DispatchQueue.main.async {
//                
//                vc.modalTransitionStyle = .crossDissolve
//                vc.modalPresentationStyle = .overCurrentContext
//                
//                self.present(vc, animated: true, completion: nil)
//            }
//        case .modalFromBottom:
//            DispatchQueue.main.async {
//                vc.modalTransitionStyle = .coverVertical
//                vc.modalPresentationStyle = .overCurrentContext
//                
//                self.present(vc, animated: true, completion: nil)
//            }
//        case .popTo:
//            DispatchQueue.main.async {
//                self.navigationController?.popToViewController(vc, animated: true)
//            }
//        case .presentBottom:
//            vc.modalTransitionStyle = .crossDissolve
//            vc.modalPresentationStyle = .custom
//            self.present(vc, animated: true, completion: nil)
//        }
//    }
//    
//    func setToRoot() {
//        DispatchQueue.main.async {
//            if #available(iOS 13.0, *) {
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                print("appDelegate == \(appDelegate)")
//            } else {
//                // Fallback on earlier versions
//            }
//            
//        }
//    }
//    
//    func routeBack(navigation backNavigation:AppRouter.BackNavigation) {
//        switch backNavigation {
//        case .dismiss:
//            DispatchQueue.main.async {
//                self.dismiss(animated: true, completion: nil)
//            }
//        case .pop:
//            DispatchQueue.main.async {
//                self.navigationController?.popViewController(animated: true)
//            }
//        case .root:
//            DispatchQueue.main.async {
//                self.navigationController?.popToRootViewController(animated: true)
//            }
//        }
//    }
//}
//
