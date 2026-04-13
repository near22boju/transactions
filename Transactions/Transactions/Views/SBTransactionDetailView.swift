//
//  SBTransactionDetailView.swift
//  SBViews
//
//  Created by Sivakumar Boju on 4/11/26.
//  Copyright © 2026 Near 22. All rights reserved.
//

import SwiftUI
import SBDomain
import SBViews

public struct SBTransactionDetailView: View {

    //  MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    let transaction: SBTransaction
    
    //  MARK: - Init
    public init(transaction: SBTransaction) {
        self.transaction = transaction
    }
    
    //  MARK: - Main View
    public var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            SBCardView {
                VStack(spacing: 0) {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            headerSection
                                .padding(.top, 32)
                                .padding(.horizontal, SBSpacing.large)
                            
                            detailsSection
                                .padding(.top, 32)
                                .padding(.horizontal, SBSpacing.large)
                            
                            SBMoreOrLessView(
                                collapsedMessage: "tooltip.less.message".localizedApp,
                                expandedMessage: "tooltip.more.message".localizedApp
                            )
                            .padding(.top, 32)
                            .padding(.horizontal, SBSpacing.large)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    Spacer(minLength: 0)
                    
                    SBPrimaryButton(title: "transaction.detail.close".localizedApp) {
                        dismiss()
                    }
                    .padding(.horizontal, SBSpacing.large)
                    .padding(.bottom, 28)
                    .padding(.top, SBSpacing.medium)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
            .padding(.bottom, 20)
        }
        .background(Color.black.opacity(0.05))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(uiColor: .systemBackground), for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("transaction.detail.title".localizedApp)
                    .font(.headline)
            }
        }
        .overlay(topDividerOverlay)
    }
    
    //  MARK: - Sub Views
    private var topDividerOverlay: some View {
        VStack {
            Divider()
                .background(Color.black.opacity(0.08))
            Spacer()
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 20) {
            Image("success-icon")
                .renderingMode(.template)
                .foregroundStyle(iconColor)
            
            Text(transaction.type.title)
                .font(.system(size: 28, weight: .regular))
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var detailsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            SBLabelValueSection(
                title: "transaction.detail.from".localizedApp,
                value: fromAccountPrimary,
                secondaryValue: fromAccountSecondary
            )
            
            SBSectionDivider()
            
            SBLabelValueSection(
                title: "transaction.detail.amount".localizedApp,
                value: displayCurrencyAmount
            )
        }
    }
    
    private var iconColor: Color {
        transaction.type.isCredit ? .green : .red
    }
    
    private var displayCurrencyAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: transaction.amount.value))
        ?? "$\(transaction.amount.value)"
    }
    
    private var fromAccountPrimary: String {
        let value = transaction.displayFromAccount
        guard value.count > 6 else { return value }
        return String(value.dropLast(6))
    }
    
    private var fromAccountSecondary: String? {
        let value = transaction.displayFromAccount
        guard value.count > 6 else { return nil }
        return String(value.suffix(6))
    }
}
