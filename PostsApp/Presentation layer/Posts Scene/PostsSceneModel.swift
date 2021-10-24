//
//  PostsSceneModel.swift
//  PostsApp
//

import UIKit
import Foundation

struct PostModel: Codable {
    let userId: Int?
    let id: Int?
    let title: String
    let body: String
}

typealias Posts = [PostModel]
