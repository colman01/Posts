//
//  PostModel.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 17.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

struct PostModel : Codable {
    var id: Int
    var title: String
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}


