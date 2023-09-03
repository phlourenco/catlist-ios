//
//  Environment.swift
//  htv-cat-ios
//
//  Created by Paulo Lourenço on 3/9/23.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        static let apiUrl = "API_URL"
        static let apiKey = "API_KEY"
    }
    
    // MARK: - Plist
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    
    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.apiKey] as? String else {
            fatalError("API_KEY not set in plist for this environment")
        }
        return apiKey
    }()
    
    static let apiUrl: String = {
        guard let apiUrl = Environment.infoDictionary[Keys.apiUrl] as? String else {
            fatalError("API_URL not set in plist for this environment")
        }
        return "https://\(apiUrl)"
    }()
}
