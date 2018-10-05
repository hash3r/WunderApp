//
//  SwiftyJSONExt.swift
//  WunderApp
//
//  Created by Volodymyr Gnatiuk on 05.10.18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    static func jsonForPath(_ path: String, aClass: AnyClass) -> JSON? {
        if let path = Bundle(for: aClass).path(forResource: path, ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url, options: .alwaysMapped)
                let json = try JSON(data: data)
                //print("jsonData: \(json)")
                return json
            } catch let error {
                print("stub data parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid stub data filename/path.")
        }
        return nil
    }
}
