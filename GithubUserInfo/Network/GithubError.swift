//
//  GithubError.swift
//  GithubUserInfo
//
//  Created by ali on 8/2/20.
//

import Foundation

enum GithubError: Error {
    case parsing(description: String)
    case network(description: String)
    case failing(description: String)
}
