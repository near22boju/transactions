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