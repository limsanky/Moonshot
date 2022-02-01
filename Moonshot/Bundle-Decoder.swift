//
//  Bundle-Decoder.swift
//  Moonshot
//
//  Created by Sankarshana V on 2022/02/01.
//

import Foundation

extension Bundle {
    func decode<T>(_ file: String) -> T where T: Codable {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file).")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load the data of \(file).")
        }
        
        guard let loadedData = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to decode the data of \(file).")
        }
        
        return loadedData
    }
}
