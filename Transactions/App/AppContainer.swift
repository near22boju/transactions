//
//  AppContainer
//  Transactions
//
//  Created by Sivakumar Boju on 4/11/26.
//  Copyright © 2026 Near 22. All rights reserved.
//

import Foundation
import Combine
import SBLocal
import SBNetwork
import SBProcess

@MainActor
final class AppContainer: ObservableObject {

    let transactionManager: SBTransactionManager

    init() {
        let localRepository = SBInMemoryTransactionLocalRepository()
        let remoteService = SBStubTransactionRemoteService()

        let repository = SBTransactionRepositoryImpl(
            remoteService: remoteService,
            localRepository: localRepository
        )

        self.transactionManager = SBTransactionManager(repository: repository)
    }
}
