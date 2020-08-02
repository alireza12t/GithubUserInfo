//
//  MainViewModel.swift
//  GithubUserInfo
//
//  Created by ali on 8/2/20.
//

import SwiftUI
import Combine



class MainViewModel: ObservableObject, Identifiable {
    @Published var userName: String = ""
    @Published var dataSource: [RepositoryItemViewModel] = []
    @Published var userData: User?
    
    private let githubFetcher: APIFetcher
    private var disposables = Set<AnyCancellable>()
    
    init(githubFetcher: APIFetcher,
         scheduler: DispatchQueue = DispatchQueue(label: "MainViewModel")
    ) {
        self.githubFetcher = githubFetcher
        
        $userName
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: fetchRepositories(forUserName: ))
            .store(in: &disposables)
        
//        $userName
//            .dropFirst(1)
//            .debounce(for: .seconds(0.5), scheduler: scheduler)
//            .sink(receiveValue: fetchUser(forUserName:))
//            .store(in: &disposables)
    }
    
    func fetchRepositories(forUserName userName: String) {
        githubFetcher.repositories(userName: userName)
            .map { response in
                response.map(RepositoryItemViewModel.init)
            }
            .map(Array.removeDuplicates)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (value) in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.dataSource = []
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (repositories) in
                guard let self = self else { return }
                
                self.dataSource = repositories
            })
            .store(in: &disposables)
    }
    
//    func fetchUser(forUserName userName: String) {
//        githubFetcher.user(userName: userName)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [weak self] (value) in
//                guard let self = self else { return }
//                switch value {
//                case .failure:
//                    self.userData = nil
//                case .finished:
//                    break
//                }
//            }, receiveValue: { [weak self] (user) in
//                guard let self = self else { return }
//
//                self.userData = UserViewModel(item: user)
//            })
//            .store(in: &disposables)
//    }
}

