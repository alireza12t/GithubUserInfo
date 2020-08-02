//
//  ContentView.swift
//  GithubUserInfo
//
//  Created by ali on 8/2/20.
//

import SwiftUI

struct ContentView: View {
    @State var showDetail: Bool = false

    @ObservedObject var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    SearchField
                    
                }
                
                Section {
                    NavigationLink(
                        destination: UserInfoView(model: User(
                                                    avatarURL: "https://avatars0.githubusercontent.com/u/561467?u=26a6693a3019abe5e97431278f9a557f34dbce60&v=4",
                                                    company: "mh", companyHTML: "https://google.com", createdAt: "2011-01-12T23:01:02Z", email: "mr.toghyiani@icvks.com", followers: Follow(total: 12), following: Follow(total: 23), isHireable: true, id: "fkfkkhsfhs", location: "tehran", login: "alireza12t", name: "Alireza", twitterUsername: "Aliireza12t", url: "https://github.com/khs", websiteURL: "swiftwithmajid.com")),
                        label: {
                            HStack {
                                Text("UserInfo")
                                
                                Spacer()
                                
                                Image(systemName: "info.circle.fill")
                                    .foregroundColor(.blue)
                            }
                            .padding()
                        })

                }
                
                
                Section {
                    ShowRepositoriesView
                }
                
                if showDetail && viewModel.dataSource.count != 0{
                    Section(header: Text("Public Repositories")) {
                        RepositoryList
                    }
                }
                
            }
            .navigationTitle(Text("GitHub Info"))
        }
    }
}

private extension ContentView {
    var SearchField: some View {
        HStack{
            TextField("Enter username here", text: $viewModel.userName)
                .disableAutocorrection(true)
        }
    }
    
    var RepositoryList: some View {
        ForEach(viewModel.dataSource, content: RepositoryItemView.init(viewModel:))
    }
    
    var ShowRepositoriesView: some View {
        HStack {
            HStack {
                Text("\(viewModel.dataSource.count)")
                
                Text("Public Repositories")
            }
            .padding()
            Spacer()
            if viewModel.dataSource.count != 0 {
                Button(action: {
                    showDetail.toggle()
                }) {
                    Image(systemName: "chevron.right.circle")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                        .animation(.easeInOut)
                }
            }
        }
        .animation(.easeInOut)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MainViewModel(githubFetcher: APIFetcher())
        ContentView(viewModel: viewModel)
        
        ContentView(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
