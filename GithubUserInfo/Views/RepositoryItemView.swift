//
//  RepositoryItemView.swift
//  Gitnfo
//
//  Created by ali on 7/30/20.
//

import SwiftUI

struct RepositoryItemView: View {
    private let viewModel: RepositoryItemViewModel
    
    init(viewModel: RepositoryItemViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            
            VStack(spacing: 5) {
                HStack {
                    Text("Owner: ")
                        .foregroundColor(.gray)
                    
                    Text("\(viewModel.ownerName)")
                        .font(.system(size: 17, weight: Font.Weight.bold, design: Font.Design.rounded))
                    
                    Spacer(minLength: 5)
                }
                
                HStack {
                    Text("\(viewModel.name)")
                        .font(.system(size: 16, weight: Font.Weight.bold, design: Font.Design.monospaced))

                        Text("(\(viewModel.mainBranch))")
                        .font(.headline)
                        .foregroundColor(.green)
                    Spacer()
                }
                
                
                Text(viewModel.descriptiion)
                    .padding()
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .frame(minWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
                
                HStack {
                    Text(viewModel.star)
                    Text(viewModel.watch)
                    Spacer()
                    Text(viewModel.language)
                        .foregroundColor(.orange)
                }
                

            }
            
        }

    }
}

//struct RepositoryItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = RepositoryItemViewModel(item: Repository()
//            RepositoryItemViewviewModel: <#RepositoryItemViewModel#>(
//    }
//}
