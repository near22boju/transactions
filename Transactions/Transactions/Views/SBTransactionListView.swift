//
//  SBTransactionListView
//  SBViews
//
//  Created by Sivakumar Boju on 4/11/26.
//  Copyright © 2026 Near 22. All rights reserved.
//

import SwiftUI
import SBProcess
import SBDomain
import SBViews

public struct SBTransactionListView: View {

    //  MARK: - Properties
    @StateObject private var manager: SBTransactionManager

    //  MARK: - Init
    public init(manager: SBTransactionManager) {
        _manager = StateObject(wrappedValue: manager)
    }

    //  MARK: - Main View
    public var body: some View {
        NavigationStack {
            contentView
                .navigationTitle("transaction.list.title".localizedApp)
                .task {
                    await manager.fetchTransactions()
                }
        }
    }

    //  MARK: - Sub Views
    @ViewBuilder
    private var contentView: some View {
        ZStack {
            transactionListView
                .disabled(manager.isLoading)

            if manager.isLoading {
                loadingOverlayView
            }
        }
    }

    private var transactionListView: some View {
        List {
            ForEach(groupedTransactions, id: \.date) { section in
                transactionSectionView(section)
            }
        }
    }

    private func transactionSectionView(_ section: TransactionSection) -> some View {
        Section {
            ForEach(section.transactions, id: \.id) { transaction in
                transactionRowNavigationView(transaction)
            }
        } header: {
            sectionHeaderView(section.date)
        }
    }

    private func transactionRowNavigationView(_ transaction: SBTransaction) -> some View {
        NavigationLink {
            SBTransactionDetailView(transaction: transaction)
        } label: {
            transactionRowView(transaction)
        }
        .buttonStyle(.plain)
    }

    private func transactionRowView(_ transaction: SBTransaction) -> some View {
        SBTransactionRowView(
            title: transaction.displayDescription,
            amountText: transaction.displaySignedAmount,
            amountColor: amountColor(for: transaction),
            subtitle: transaction.merchantName,
            trailingText: transaction.type.rawValue
        )
    }

    private func sectionHeaderView(_ date: String) -> some View {
        Text(displayDate(date))
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundStyle(.secondary)
    }

    @ViewBuilder
    private var loadingOverlayView: some View {
        Color.black.opacity(0.1)
            .ignoresSafeArea()

        ProgressView()
            .controlSize(.large)
    }

    private func amountColor(for transaction: SBTransaction) -> Color {
        transaction.type == .credit ? .green : .primary
    }

    private var groupedTransactions: [TransactionSection] {
        let grouped = Dictionary(grouping: manager.transactions) { $0.postedDate }

        return grouped
            .map { date, transactions in
                TransactionSection(
                    date: date,
                    transactions: transactions.sorted { $0.postedDate > $1.postedDate }
                )
            }
            .sorted { $0.date > $1.date }
    }

    private func displayDate(_ raw: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, yyyy"

        guard let date = inputFormatter.date(from: raw) else {
            return raw
        }

        return outputFormatter.string(from: date)
    }
}

//  MARK: - Helper
private struct TransactionSection {
    let date: String
    let transactions: [SBTransaction]
}
