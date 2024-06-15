//
//  ContentView.swift
//  CatsUI
//
//  Created by Zakhar Litvinchuk on 19.05.2024.
//

import SwiftUI
import CatsNetworking
import FirebaseCrashlytics



struct AnimalsListView: View {
    let animal: Animal
    @State private var alertPresented = UserDefaults.standard.value(forKey: "CrashlyticsCollectionEnabled") == nil
    @ObservedObject var catsListViewModel: AnimalsListViewModel
    init(animal: Animal) {
        self.animal = animal
        self.catsListViewModel = AnimalsListViewModel(animal: animal)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(Array(catsListViewModel.animalsImages.enumerated()), id: \.element.id){ index, catImage in
                        NavigationLink(value: catImage) {
                            Text("\(animal == .cat ? "Cat" : "Dog") # \(index + 1)")
                        }
                    }
                }
                .accessibilityIdentifier("AnimalsList")
                .navigationTitle("\(animal == .cat ? "Cats" : "Dogs") List")
                
                Button(action: {
                    Crashlytics.crashlytics().setCustomValue("CRASH_REASON",forKey: "fatal error")
                    fatalError("Error was triggered")
                }, label: {
                    Text("Crash")
                        .foregroundStyle(.black)
                        .font(.title2)
                        .bold()
                        .frame(width: 100, height: 50)
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                })
                Button(action: {
                    Crashlytics.crashlytics().setCustomValue("CRASH_REASON",forKey: "index out of range")
                    let array = [1, 2, 3]
                    print(array[3])
                }, label: {
                    Text("Crash")
                        .foregroundStyle(.black)
                        .font(.title2)
                        .bold()
                        .frame(width: 100, height: 50)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                })
                Button(action: {
                    Crashlytics.crashlytics().setCustomValue("CRASH_REASON",forKey: "force unwrap")
                    let optional: Int? = nil
                      print(optional!)
                }, label: {
                    Text("Crash")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .bold()
                        .frame(width: 100, height: 50)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                })
            }
            .navigationDestination(for: AnimalImage.self, destination: { AnimalView(animal: animal, catImage: $0)} )
        }
        .navigationTitle("List of pretty \(animal == .cat ? "Cats" : "Dogs")")
        .alert(isPresented: $alertPresented) {
            Alert(title: Text("Crashlytics collection permission"),
                  message: Text(Bundle.main.infoDictionary?["CrashAnalyticsUsageDescription"] as! String),
                  primaryButton: .default(Text("Allow"), action: {
                UserDefaults.standard.set(true, forKey: "CrashlyticsCollectionEnabled")
                Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
            }), secondaryButton: .default(Text("Don't allow"), action: {
                UserDefaults.standard.set(false, forKey: "CrashlyticsCollectionEnabled")
                Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
            }))
        }

        
        
       
    }
}

