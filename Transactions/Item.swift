//
//
//  Item
//  Transactions
//
//  Created by Sivakumar Boju on 4/11/26.
//  Copyright © 2026 Near 22. All rights reserved.
//
    

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
