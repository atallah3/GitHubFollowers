//
//  UIViewController+EXT.swift
//  GitHubFollowers
//
//  Created by Abd Elrahman Atallah on 07/02/2024.
//

import UIKit

extension UIViewController{
    func presentGFAlertOnMainThread(title : String, message : String, buttonTitle : String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, massege: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
