//
//  ImageLoader.swift
//  Gitnfo
//
//  Created by ali on 8/2/20.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func load() {
        
    }
    
    func cancell() {
        
    }
    
}
