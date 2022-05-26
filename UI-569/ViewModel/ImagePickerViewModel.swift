//
//  ImagePickerViewModel.swift
//  UI-569
//
//  Created by nyannyan0328 on 2022/05/26.
//

import SwiftUI
import PhotosUI

class ImagePickerViewModel: ObservableObject {
    @Published var fetchedImage : [ImageAseet] = []
    @Published var selectedImages : [ImageAseet] = []
    
    
    init() {
        
        fetchImages()
    }
    
    func fetchImages(){
        
        let options = PHFetchOptions()
        options.includeHiddenAssets = false
        options.includeAssetSourceTypes = [.typeUserLibrary]
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        PHAsset.fetchAssets(with: .image, options: options).enumerateObjects { asset,_, _ in
            
            let imageAseet : ImageAseet = .init(asset: asset)
            
            self.fetchedImage.append(imageAseet)
            
        }
        
    }
}


