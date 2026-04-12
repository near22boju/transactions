//
//  TransactionsApp
//  Transactions
//
//  Created by Sivakumar Boju on 4/11/26.
//  Copyright © 2026 Near 22. All rights reserved.
//

import SwiftUI
import SwiftData
import SBLocal
import SBNetwork
import SBDomain

@main
struct TransactionsApp: App {
    private enum StorageMode {
        case inMemory
        case swiftData
    }

    private static var storageMode: StorageMode {
        .inMemory
    }

    private let modelContainer: ModelContainer?
    @StateObject private var container: AppContainer

    init() {
        let remoteService = SBStubTransactionRemoteService()

        switch Self.storageMode {
        case .inMemory:
            self.modelContainer = nil

            let localRepository = SBInMemoryTransactionLocalRepository()

            _container = StateObject(
                wrappedValue: AppContainer(
                    localRepository: localRepository,
                    remoteService: remoteService
                )
            )

        case .swiftData:
            let modelContainer = try! ModelContainer(for: SBTransactionRecord.self)
            self.modelContainer = modelContainer

            let localRepository = SBSwiftDataTransactionLocalRepository(
                modelContext: modelContainer.mainContext
            )

            _container = StateObject(
                wrappedValue: AppContainer(
                    localRepository: localRepository,
                    remoteService: remoteService
                )
            )
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView(container: container)
        }
    }
}
