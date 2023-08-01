//
//  helper.swift
//  DayCareApp
//
//  Created by Ahzam Ghori on 28/06/2023.
//

import Foundation
import UIKit
import Swift

open class Helper{
    static public let getInstance = Helper()
    private init(){}
    
    public func showAlert(title : String ,
                          message : String,
                          actions: [UIAlertAction]?=nil,
                          defaultActionTitle: String?="Ok",
                          isDefaultActionReq: Bool?=true,
                          vc: UIViewController?=nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions != nil {
            for action in actions!{
                alertController.addAction(action)
            }
        }
        if isDefaultActionReq!{
            let alertAction = UIAlertAction(title: defaultActionTitle, style: .default, handler: nil)
            alertController.addAction(alertAction)
        }
        DispatchQueue.main.async {
            if let rootWindow = UIApplication.getTopViewController(){
                rootWindow.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
