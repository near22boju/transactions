//
//  SBTransaction+Extension
//  SBViews
//
//  Created by Sivakumar Boju on 4/12/26.
//  Copyright © 2026 Near 22. All rights reserved.
//

import Foundation
import SBDomain

public extension SBTransaction {
    
    //  MARK: - Computed Properties
    var displayAmount: String {
        let value = amount.value

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let formattedValue = formatter.string(from: NSNumber(value: value)) ?? "\(value)"

        return "\(formattedValue) \(amount.currency)"
    }
    
    var displaySignedAmount: String {
        let sign = type.isCredit ? "+" : "-"
        return "\(sign)\(displayAmount)"
    }
}
