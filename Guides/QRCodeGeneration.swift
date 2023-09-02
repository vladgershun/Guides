//
//  QRCodeGeneration.swift
//  Guides
//
//  Created by Vlad Gershun on 9/2/23.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct QRCodeGeneration: View {
    
    /// CIImage -> CGImage -> UIImage -> Image
    
    @State private var name = "Vlad"
     
    /// Generates image data.
    let context = CIContext()
    /// QR code generator filter.
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                Image(uiImage: generateQRCode(from: name))
                    ///Turns off blending algorithm to not blur image.
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            .navigationTitle("QR Code Generator")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        
        /// Convert `string` into data object.
        filter.message = Data(string.utf8)
        /// Attempts to create UIImage from data.
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct QRCodeGeneration_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeGeneration()
    }
}
