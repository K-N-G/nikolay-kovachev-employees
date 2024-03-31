//
//  UserData.swift
//  NikolayKovachevEmployees
//
//  Created by KNG on 31.03.24.
//

import Foundation

final class UserData {
    static var loadedFileName: String {
        get {
            return UserDefaults.standard.string(forKey: "loadedFileName") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "loadedFileName")
            UserDefaults.standard.synchronize()
        }
    }
}
