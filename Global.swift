//
//  Global.swift
//  FinalProject
//
//  Created by Albert Zhang on 11/23/18.
//  Copyright © 2018 org.iosdecal. All rights reserved.
//

import Foundation

enum TopicCategories: Int {
    case entertainment = 0
    case music = 1
    case health = 2
    case travel = 3
    case food = 4
    case fashion = 5
    case politics = 6
    case misc = 7
}

class Global: NSObject {
    static var categoriesIndex: TopicCategories = .food
    static var categories: [String] = ["entertainment", "music", "health", "travel", "food", "fashion", "politics", "misc"]
    
}
