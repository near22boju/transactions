//
//  AppContainer
//  Transactions
//
//  Created by Sivakumar Boju on 4/11/26.
//  Copyright © 2026 Near 22. All rights reserved.
//

import Foundation
import SBLocal
import SBProcess

@MainActor
final class AppContainer: ObservableObject {
    let transactionRepository: SBTransactionRepository
    let transactionManager: SBTransactionManager

    init() {
        let repository = SBInMemoryTransactionRepository()
        self.transactionRepository = repository
        self.transactionManager = SBTransactionManager(repository: repository)
    }
}
