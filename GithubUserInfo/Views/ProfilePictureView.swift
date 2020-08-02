//
//  ProfilePictureView.swift
//  GithubUserInfo
//
//  Created by ali on 8/2/20.
//

import SwiftUI

struct CustomImageView: View {
    @State var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color("gold"), lineWidth: 2.5)
            )
    }
}

struct CustomImageView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageView(image: UIImage(systemName: "person")!)
    }
}
