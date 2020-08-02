//
//  UserInfoView.swift
//  GithubUserInfo
//
//  Created by ali on 8/2/20.
//

import SwiftUI

struct UserInfoView: View {
    private let userModel: User
    
    init(model: User) {
        self.userModel = model
    }
    
    var body: some View {
            HStack {
                ProfilePicure
                VStack {
                    Text("\("\(userModel.login)")")
                        .font(.system(size: 16, weight: Font.Weight.bold, design: Font.Design.monospaced))
                        
                    
                    HStack {
                        Followers
                        
                        Following
                    }
                    .padding()
                    
                }
            }
        }

}

private extension UserInfoView {
    var Followers: some View {
        HStack {
            HStack {
                Text("\(userModel.followers.totalCount)")
                    .foregroundColor(.gray)
                    .font(.system(size: 15))

                Text("Followers")
                    .font(.system(size: 13))
            }
        }
    }
    
    var Following: some View {
        HStack {
            Text("\(userModel.following.totalCount)")
                .foregroundColor(.gray)
                .font(.system(size: 15))

            Text("Following")
                .font(.system(size: 13))
        }
    }
    
    var ProfilePicure: some View {
        HStack{
            Image("h")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color("gold"), lineWidth: 2.5)
                )
                
        }
    }
    
    
}


struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(model: User(
                        avatarURL: "https://avatars0.githubusercontent.com/u/561467?u=26a6693a3019abe5e97431278f9a557f34dbce60&v=4",
                        company: "mh", companyHTML: "https://google.com", createdAt: "2011-01-12T23:01:02Z", email: "mr.toghyiani@icvks.com", followers: Follow(total: 12), following: Follow(total: 23), isHireable: true, id: "fkfkkhsfhs", location: "tehran", login: "alireza12t", name: "Alireza", twitterUsername: "Aliireza12t", url: "https://github.com/khs", websiteURL: "swiftwithmajid.com"))
    }
}
