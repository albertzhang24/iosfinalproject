//
//  Info.swift
//  FinalProject
//
//  Created by Albert Zhang on 11/28/18.
//  Copyright © 2018 org.iosdecal. All rights reserved.
//

import Foundation
import UIKit

class Info {
    /// Username of the poster
    let username: String

    /// The ID of the post, generated automatically on Firebase
    let postId: String
    
    /// Designated initializer for posts
    ///
    /// - Parameters:
    ///   - username: The name of the user making the post
    ///   - postImage: The image that will show up in the post
    ///   - thread: The thread that the image should be posted to
    init(id: String, username: String) {
        self.username = username
        let dateFormatter = DateFormatter()
        self.postId = id
    }
    
}
