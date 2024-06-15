//
//  CatView.swift
//  CatsUI
//
//  Created by Zakhar Litvinchuk on 19.05.2024.
//

import SwiftUI
import CatsNetworking
import SDWebImageSwiftUI
import FirebasePerformance
import FirebaseCrashlytics

struct AnimalView: View {
    let animal: Animal
    let catImage: AnimalImage
    let trace = Performance.startTrace(name: "CAT_IMAGE_DOWNLOADING_TIME")
    
    init(animal: Animal, catImage: AnimalImage) {
        self.animal = animal
        self.catImage = catImage
    }
    
    var body: some View {
        WebImage(url: catImage.link)
            .resizable()
            .scaledToFit()
            .navigationTitle("Pretty \(animal == .cat ? "cat" : "dog")")
            .onAppear {
                trace?.stop()
                Crashlytics.crashlytics().log("Image \(self.catImage.link) appeared")
            }
    }

}
