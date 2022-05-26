//
//  ImageAseet.swift
//  UI-569
//
//  Created by nyannyan0328 on 2022/05/26.
//

import SwiftUI
import PhotosUI

struct ImageAseet: Identifiable {
    var id = UUID().uuidString
    var asset : PHAsset
    var thumnail : UIImage?
    var index : Int = -1
}


