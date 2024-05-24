//
//  TabBarController.swift
//  TcellTasks
//
//  Created by Boboev Saddam on 23/05/24.
//

import UIKit

class TabBarController: UITabBarController {

    static func storyboardInstance() -> TabBarController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: String(describing: self)) as! TabBarController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
