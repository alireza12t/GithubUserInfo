//
//  User.swift
//  Gitnfo
//
//  Created by ali on 7/30/20.
//
import Foundation

// MARK: - User
class User: Codable {
    let data: DataClass?
    
    init() {
        data = DataClass()
    }
}

// MARK: - DataClass
class DataClass: Codable {
    let user: UserClass?
    
    init() {
        self.user = UserClass()
    }
}

// MARK: - UserClass
class UserClass: Codable {
    let avatarURL: String? = ""
    let company: String? = ""
    let companyHTML: String? = ""
    let createdAt: String? = ""
    let email: String? = ""
    let followers, following: Follow
    let isHireable: Bool? = false
    let id: String? = ""
    let location: String? = ""
    let login: String? = ""
    let name: String? = ""
    let twitterUsername: String? = ""
    let url: String? = ""
    let websiteURL: String? = ""

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatarUrl"
        case websiteURL = "websiteUrl"
        case company, companyHTML, createdAt, email, followers, following, isHireable, id, location, login, name, twitterUsername, url
    }
    
    init() {
        self.followers = Follow(total: 0)
        self.following = Follow(total: 0)
    }
    
}

// MARK: - Follow
class Follow: Codable {
    var totalCount: Int
    
    init(total: Int) {
        self.totalCount = total
    }
}
