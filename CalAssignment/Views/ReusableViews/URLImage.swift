//
//  URLImage.swift
//  CalAssignment
//
//  Created by Leeron Ziv on 19/11/2024.
//

import SwiftUI

import SwiftUI

struct URLImage: View {
    let url: URL
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        if let image = imageLoader.image, url == imageLoader.url {
            Image(uiImage: image)
                .resizable()
        } else {
            ProgressView()
                .onAppear {
                    imageLoader.loadImage(from: url)
                }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    var url: URL?
    
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                self?.image = UIImage(named: "image_placeholder")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
                self?.url = url
            }
        }.resume()
    }
}
