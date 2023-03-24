//
//  ContentView.swift
//  AsyncImage
//
//  Created by Rehnuma Reza on 24/3/23.
//

import SwiftUI

extension Image {
    func imageModifier() -> some View {
        self.resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self.imageModifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
            .padding()
    }
}

struct ContentView: View {
    let imageURL = "https://credo.academy/credo-academy@3x.png"
    var body: some View {
        //MARK: 1. BASIC
        //AsyncImage(url: URL(string: imageURL))
        
        //MARK: 2. SCALE IMAGE
        /**
         greater the value of scale parameter, smaller the image as outcome
         Default value of scale parameter is 1.0
         */
        //AsyncImage(url: URL(string: imageURL), scale: 2.0)
        
        // MARK: 3. PLACEHOLDER
        /*AsyncImage(url: URL(string: imageURL)) { image in
            image.imageModifier()
        } placeholder: {
            Image(systemName: "photo.circle.fill").iconModifier()
                
        }
         */
        
        // MARK: 4. Phase
        /*AsyncImage(url: URL(string: imageURL)) { phase in
            //SUCCESS: Image has been rendered successfully
            //FAILURE: Image download has been failed
            //EMPTY: NO image found
            
            if let image = phase.image {
                image.imageModifier()
            } else if phase.error != nil {
                Image(systemName: "ant.circle.fill")
                    .iconModifier()
            } else {
                Image(systemName: "photo.circle.fill")
                    .iconModifier()
            }
            
        }.padding(40)
         */
        
        //MARK: 5. ANIMATION
        AsyncImage(url: URL(string: imageURL),
                   transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5))){ phase in
            switch phase {
            case .success(let image):
                image.imageModifier()
                    // .transition(.move(edge: .bottom))
                    // .transition(.slide)
                    .transition(.scale)
            case .failure(_): Image(systemName: "ant.circle.fill").iconModifier()
            case.empty: Image(systemName: "photo.circle.fill").iconModifier()
            @unknown default:
                ProgressView()
            }
        }.padding(40)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
