//
//  StringExt.swift
//  WunderApp
//
//  Created by Vladimir Gnatiuk on 10/1/18.
//  Copyright © 2018 WunderApp. All rights reserved.
//

import Foundation

extension String {
    
    func encodeURLQuery() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
