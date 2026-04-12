//
//  RootView
//  Transactions
//
//  Created by Sivakumar Boju on 4/11/26.
//  Copyright © 2026 Near 22. All rights reserved.
//

import SwiftUI
import SBViews

struct RootView: View {
    @ObservedObject var container: AppContainer

    var body: some View {
        SBTransactionListView(manager: container.transactionManager)
    }
}
