//
//  Extension + View Controller.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 24/05/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showLoadingVC(){
        let loadingVC = LoadingViewController()
        // Добавляем его как дочерний контроллер
        addChild(loadingVC)
        
        // Устанавливаем размеры и положение его view
        loadingVC.view.frame = view.bounds
        
        // Добавляем view LoadingViewController на главный экран
        view.addSubview(loadingVC.view)
        
        // Сообщаем LoadingViewController о добавлении
        loadingVC.didMove(toParent: self)
    }
    
    func hideLoadingVC() {
        children.forEach { vc in
            if vc is LoadingViewController {
                
                vc.willMove(toParent: nil)
                vc.view.removeFromSuperview()
                vc.removeFromParent()
            }
        }
    }
}
