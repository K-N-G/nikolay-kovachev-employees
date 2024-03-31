//
//  Storyboard.swift
//  NikolayKovachevEmployees
//
//  Created by KNG on 29.03.24.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
    
    static var dashboard: UIStoryboard {
        return UIStoryboard.init(name: "Dashboard", bundle: nil)
    }

    static var employees: UIStoryboard {
        return UIStoryboard.init(name: "Employees", bundle: nil)
    }

    static var projects: UIStoryboard {
        return UIStoryboard.init(name: "Projects", bundle: nil)
    }
}
