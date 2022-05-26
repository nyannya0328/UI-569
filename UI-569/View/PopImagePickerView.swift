//
//  PopImagePickerView.swift
//  UI-569
//
//  Created by nyannyan0328 on 2022/05/26.
//

import SwiftUI
import PhotosUI

struct PopImagePickerView: View {
    @StateObject var model : ImagePickerViewModel = .init()
    @Environment(\.self) var env
    
    let deviceSize = UIScreen.main.bounds.size
    var onend : ()->()
    var onSelect : ([PHAsset]) ->()
    var body: some View {
      
        VStack(spacing:0){
            
            HStack{
                
                Text("Selected Images")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.primary)
                }

            }
            
            ScrollView(.vertical, showsIndicators: false) {
                
                let columns = Array(repeating: GridItem(.flexible(),spacing: 10), count: 4)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    
                    ForEach($model.fetchedImage){$thamnailImage in
                        
                        
                        GridContent(imageAseet: thamnailImage )
                            .onAppear {
                                
                                if thamnailImage.thumnail == nil{
                                    
                                    let maneger = PHCachingImageManager.default()
                                    
                                    maneger.requestImage(for: thamnailImage.asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil) { image, _ in
                                        
                                        thamnailImage.thumnail = image
                                    }
                                    
                                    
                                }
                            }
                        
                    }
                    
                }
                .padding()

                
            }
            .safeAreaInset(edge: .bottom) {
                
                Button {
                    
                    let imageAsset = model.selectedImages.compactMap { imageAsset -> PHAsset? in
                        
                        return imageAsset.asset
                        
                    }
                    
                    onSelect(imageAsset)
                    
                    
                } label: {
                    
                    Text("Add\(model.selectedImages.isEmpty ? "" : "\(model.selectedImages.count)Images")")
                        .font(.callout.weight(.semibold))
                        .foregroundColor(.white)
                        .padding(.vertical,15)
                        .padding(.horizontal,100)
                        .background{
                         
                            Capsule()
                                .fill(.blue)
                            
                        }
                }
                .disabled(model.selectedImages.isEmpty)
                .opacity(model.selectedImages.isEmpty ? 0.5 : 1)
                .padding(.vertical)

                
            }
            
            
        }
        .frame(height: deviceSize.height / 1.8)
        .frame(width: (deviceSize.width - 40) > 350 ? 350 : (deviceSize.width - 40))
        .background{
         
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(env.colorScheme == .dark ? .black : .white)
            
        }
        .frame(width: deviceSize.width, height: deviceSize.height)
    }
    @ViewBuilder
    func GridContent(imageAseet : ImageAseet)->some View{
        
        GeometryReader{proxy in
            
            let size = proxy.size
            
            
            ZStack{
                
                if let thmnail = imageAseet.thumnail{
                    
                    Image(uiImage: thmnail)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    
                }
                else{
                    
                ProgressView()
                        .frame(width: size.width, height: size.height)
                }
                
                ZStack{
                    
                    
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.black.opacity(0.25))
                    
                    Circle()
                        .fill(.white.opacity(0.3))
                    
                    Circle()
                        .stroke(.white,lineWidth: 2)
                    
                    
                    if let index = model.selectedImages.firstIndex(where: { asset in
                        
                        asset.id == imageAseet.id
                    }) {
                        
                        
                        Circle()
                            .fill(.blue)
                        
                        Text("\(model.selectedImages[index].index + 1)")
                            .font(.callout)
                            .foregroundColor(.white)
                        
                        
                    }
                    
                    
                }
                .frame(width: 20, height: 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment:.topTrailing)
                .padding(5)
            }
            .clipped()
            .onTapGesture {
                
                withAnimation(.easeInOut){
                    
                    if let index = model.selectedImages.firstIndex(where: { asset in
                        
                        asset.id == imageAseet.id
                    }){
                        
                        
                        model.selectedImages.remove(at: index)
                        model.selectedImages.enumerated().forEach { item in
                            
                            model.selectedImages[item.offset].index = item.offset
                            
                        }
                        
                    }
                    
                    else{
                        
                        var newAsset = imageAseet
                        newAsset.index = model.selectedImages.count
                        model.selectedImages.append(newAsset)
                        
                    }
                    
                    
                }
            }
        }
        .frame(height: 80)
       
    }
}

struct PopImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

