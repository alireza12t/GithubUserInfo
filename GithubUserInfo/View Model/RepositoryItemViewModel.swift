//
//  RepositoryItemViewModel.swift
//  Gitnfo
//
//  Created by ali on 8/1/20.
//

import Foundation


struct RepositoryItemViewModel: Identifiable {
    private let item: Repository

    var id: String {
        return "\(item.id)"
    }
    
    var ownerName: String {
        return item.owner.login
    }
    
    var name: String {
        return item.name
    }
    
    var mainBranch: String {
        return item.defaultBranch
    }
    
    var descriptiion: String {
        return item.repositoryDescription ?? ""
    }
    
    var star: String {
        return "\(item.stargazersCount) ⭐️"
    }
    
    var watch: String {
        return "\(item.watchersCount) 👁"
    }
    
    var language: String {
        return item.language ?? ""
    }
    
    init(item: Repository) {
      self.item = item
    }

}


extension RepositoryItemViewModel: Hashable {
  static func == (lhs: RepositoryItemViewModel, rhs: RepositoryItemViewModel) -> Bool {
    return lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
}

