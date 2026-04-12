import SwiftUI
import SBViews

struct RootView: View {
    @ObservedObject var container: AppContainer

    var body: some View {
        SBTransactionListView(manager: container.transactionManager)
    }
}