//
//  CatsListViewModel.swift
//  CatsUI
//
//  Created by Zakhar Litvinchuk on 28.05.2024.
//

import SwiftUI
import CatsNetworking

class AnimalsListViewModel: ObservableObject {
    let animalsNetworkingService = CatsNetworkingService()
    @Published var animalsImages: [AnimalImage] = []
    
    func getAnimals(animal: Animal) async -> [AnimalImage]? {
        do {
            let cats = try await animalsNetworkingService.getCatsImages(animal: animal, limit: 10)
            return cats
        } catch NetworkingErrors.invalidData {
            print("Invalid data")
        } catch NetworkingErrors.invalidResponse {
            print("Invalid response")
        } catch NetworkingErrors.invalidURL {
            print("Invalid url")
        } catch {
            print("Other error")
        }
        return nil
    }
    
    init(animal: Animal) {
        Task {
            let cats = await getAnimals(animal: animal)
            await MainActor.run {
                self.animalsImages = cats ?? []
            }
        }
    }
}
