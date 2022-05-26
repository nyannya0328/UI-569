//
//  Extensions.swift
//  UI-569
//
//  Created by nyannyan0328 on 2022/05/26.
//

import SwiftUI
import Photos

extension View{
    
    @ViewBuilder
    func popupImagePicker(show : Binding<Bool>,translation : AnyTransition = .move(edge: .bottom),onSelect : @escaping([PHAsset]) ->())->some View{
        
        self
            .overlay {
                
                
                let deviceSize = UIScreen.main.bounds.size
                
                ZStack{
                    
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .opacity(show.wrappedValue ? 1 : 0)
                        .onTapGesture {
                            
                            show.wrappedValue = false
                        }
                    
                    
                    if show.wrappedValue{
                        
                        PopImagePickerView {
                            
                        show.wrappedValue = false
                            
                        } onSelect: { asset in
                            
                            onSelect(asset)
                           show.wrappedValue = false
                        }

                    }
                }
                .frame(width: deviceSize.width, height: deviceSize.height)
                .animation(.spring(), value: show.wrappedValue)
                
            }
        
        
        
    }

}
