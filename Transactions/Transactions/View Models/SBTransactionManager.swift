//
//  SBTransactionManager
//  Transactions
//
//  Created by Sivakumar Boju on 4/12/26.
//  Copyright © 2026 Near 22. All rights reserved.
//

import Foundation
import Combine
import SBDomain

@MainActor
public final class SBTransactionManager: ObservableObject {

    //  MARK: - Properties
    @Published public private(set) var transactions: [SBTransaction] = []
    @Published public private(set) var isLoading = false
    @Published public private(set) var errorMessage: String?

    private let repository: SBTransactionRepository

    //  MARK: - init
    public init(repository: SBTransactionRepository) {
        self.repository = repository
    }

    //  MARK: - Helper Methods
    public func fetchTransactions() async {
        isLoading = true
        errorMessage = nil

        do {
            transactions = try await repository.fetchTransactions()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    public func fetchTransactions(since postedDate: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let newTransactions = try await repository.fetchTransactions(since: postedDate)
            transactions = merge(current: transactions, incoming: newTransactions)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    public func refresh() async {
        await fetchTransactions()
    }

    private func merge(
        current: [SBTransaction],
        incoming: [SBTransaction]
    ) -> [SBTransaction] {
        var merged = current

        for transaction in incoming {
            if let index = merged.firstIndex(where: { $0.id == transaction.id }) {
                merged[index] = transaction
            } else {
                merged.append(transaction)
            }
        }

        return merged
    }
}
