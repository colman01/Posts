//
//  Dictionary+Extenstions.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 16.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionaryValue:[String: Any?]? {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            else {
                return nil
        }
        return dictionary
    }
}
