////
////  DatabaseClient.swift
////  Movie23
////
////  Created by BS00880 on 9/7/24.
////
//
//import Foundation
//import SwiftData
//
//@available(iOS 17, *)
//class DatabaseClient<T> where T: SwiftData.PersistentModel{
//    private let modelContainer: ModelContainer
//    private let modelContext: ModelContext
//    
//    @MainActor
//    init() {
//        self.modelContainer = try! ModelContainer(for: T.self)
//        self.modelContext = modelContainer.mainContext
//    }
//    
//    func appendItem(item: T) {
//        modelContext.insert(item)
//        do {
//            try modelContext.save()
//        } catch {
//            fatalError(error.localizedDescription)
//        }
//    }
//    
//    func fetchItems() -> [T] {
//        do {
//            return try modelContext.fetch(FetchDescriptor<T>())
//        } catch {
//            fatalError(error.localizedDescription)
//        }
//    }
//    
//    func removeItem(_ item: T) {
//        modelContext.delete(item)
//    }
//}
