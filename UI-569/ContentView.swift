//
//  ContentView.swift
//  UI-569
//
//  Created by nyannyan0328 on 2022/05/26.
//

import SwiftUI
import Photos

struct ContentView: View {
    @State var show : Bool = false
    @State var pickedImage : [UIImage] = []
    var body: some View {
      
        NavigationView{
            
            TabView{
                
                
                ForEach(pickedImage,id:\.self){image in
                    
                    
                    GeometryReader{proxy in
                        
                        let size = proxy.size
                        
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                          
                    }
                    .padding()
                    
                }
                
                
            }
            .frame(height: 500)
            .tabViewStyle(.page(indexDisplayMode: pickedImage.isEmpty ? .never :.always))
            .navigationTitle("PopUp")
            .toolbar {
                
                Button {
                    show.toggle()
                } label: {
                    
                    
                    Image(systemName: "plus")
                }

            }
            .popupImagePicker(show: $show) { asset in
                
                let manager = PHCachingImageManager.default()
                
                let options = PHImageRequestOptions()
                
                options.isSynchronous = true
                
                DispatchQueue.global(qos: .userInteractive).async {
                    
                    
                    asset.forEach { asset in
                        
                        
                        manager.requestImage(for: asset, targetSize: .init(), contentMode: .default, options: options) { image, _ in
                            
                            
                            guard let image = image else {
                                return
                            }
                            
                            DispatchQueue.main.async {
                                self.pickedImage.append(image)
                                
                            }

                        }
                    }
                    
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
