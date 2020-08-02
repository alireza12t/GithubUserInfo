//
//  UserInfoView.swift
//  GithubUserInfo
//
//  Created by ali on 8/2/20.
//

import SwiftUI
import MessageUI

struct UserInfoView: View {
    private let userModel: User
    @State var presentingModal = false

    
    init(model: User) {
        self.userModel = model
    }
    
    var body: some View {
        Form {
            Section {
                Profile
            }
            
            Section(header: Text("Personal Info")) {
                PersonalInfo
            }
            
            Section(header: Text("Work Info")) {
                WorkInfo
            }
            
            Section(header: Text("Communication Ways")) {
                Communication
            }
        }
    }
    
//    func openEmail(mail: String) {
//           if MFMailComposeViewController.canSendMail() {
//               let mail = MFMailComposeViewController()
//               mail.mailComposeDelegate = self
//               mail.setSubject("Some subject")
//               mail.setToRecipients(["someemail@example.com"])
//               mail.setMessageBody("Some body", isHTML:false)
//
//            self.presentingModal = true
//
//           } else {
//               // show failure alert
//           }
//       }
    
}

private extension UserInfoView {
    var Communication: some View {
        VStack(alignment: .leading, spacing: 15){
            HStack {
                if userModel.twitterUsername != nil {
                    HStack {
                        Image("twitter")
                            .resizable()
                            .frame(width: 40, height: 40)

                        
                        Text("@\(userModel.twitterUsername!)")
                    }
                }
            }
            .padding()
            
            HStack {
                if userModel.websiteURL != nil {
                    HStack {
                        Image(systemName: "safari.fill")
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 40, height: 40)

                        
                        Text("https://\(userModel.websiteURL!)")
                    }
                }
            }
            .padding()
            
            HStack {
                if userModel.email != nil {
                    HStack {
                        Image(systemName: "mail.fill")
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 40, height: 40)

                        
                        Text("\(userModel.email!)")
                    }
                }
            }
            .padding()
        }
    }
    var WorkInfo: some View {
        VStack(alignment: .leading, spacing: 15) {
            if userModel.company != nil {
                HStack {
                    Text("Current Company : ")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                    
                Spacer()
                    if userModel.companyHTML != nil {
                    if let url = URL(string: userModel.companyHTML!) {
                    Link(destination: url) {
                        Text("\(userModel.company!)")
                            .foregroundColor(.blue)
                    }
                    } else {
                        Text("\(userModel.company!)")
                            .foregroundColor(.white)
                    }
                    } else {
                        Text("\(userModel.company!)")
                            .foregroundColor(.white)
                    }
                }
                    .padding()
            }
            
            if userModel.isHireable != nil {
            HStack {
                Text("Is Hireable?")
                    .foregroundColor(.gray)
                    .foregroundColor(.gray)
                    .font(.system(size: 16))

                
                Spacer()
                
                if userModel.isHireable! {
                    Text("✅")
                } else {
                    Text("❌")
                }
            }
            .padding()
            }
        }
    }
    
    var PersonalInfo: some View {
        VStack(alignment: .leading, spacing: 15) {
            if userModel.name != nil {
                HStack {
                    Text("Name : ")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                    
                Spacer()
                    
                Text("\(userModel.name!)")
                }
                    .padding()
            }
            if userModel.createdAt != nil {
                HStack {
                    Text("Created at : ")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                    
                Spacer()
                    
                    Text("\(userModel.createdAt!)")
                }
                    .padding()
            }
            if userModel.location != nil {
                HStack {
                    Text("Location : ")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))

                    
                Spacer()
                    
                    Text("\(userModel.location!.uppercased())")
                }
                    .padding()
            }
            
        }
    }
    
    var Profile: some View {
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
            if userModel.avatarURL != nil {
                Image("h")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color("gold"), lineWidth: 2.5)
                    )
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color("gold"), lineWidth: 2.5)
                    )
                    .redacted(reason: .placeholder)
            }
        }
    }
    
    
}


struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(model: User(
                        avatarURL: nil,
                        company: "mh", companyHTML: "https://google.com", createdAt: "2011-01-12T23:01:02Z", email: "mr.toghyiani@icvks.com", followers: Follow(total: 12), following: Follow(total: 23), isHireable: true, id: "fkfkkhsfhs", location: "tehran", login: "alireza12t", name: "Alireza", twitterUsername: "Aliireza12t", url: "https://github.com/khs", websiteURL: "swiftwithmajid.com"))
        
        UserInfoView(model: User(
                        avatarURL: nil,
                        company: "mh", companyHTML: "https://google.com", createdAt: "2011-01-12T23:01:02Z", email: "mr.toghyiani@icvks.com", followers: Follow(total: 12), following: Follow(total: 23), isHireable: true, id: "fkfkkhsfhs", location: "tehran", login: "alireza12t", name: "Alireza", twitterUsername: "Aliireza12t", url: "https://github.com/khs", websiteURL: "swiftwithmajid.com"))
            .preferredColorScheme(.dark)
    }
}
