//
//  NetworkError.swift
//  WunderApp
//
//  Created by Volodymyr Gnatiuk on 05.10.18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Foundation

enum NetworkError: String, Error {
    case noData
    case invalidInput
    case requestFailed
    case defaultError
    
    func description() -> String {
        switch self {
        case .noData: return "No results found"
        case .invalidInput: return "Wrong input data"
        case .requestFailed: return "Please check you connection"
        case .defaultError: return "Something went wrong"
        }
    }
}
