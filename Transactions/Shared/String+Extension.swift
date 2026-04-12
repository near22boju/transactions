//
//  String+Extension
//  Transactions
//
//  Created by Sivakumar Boju on 4/12/26.
//  Copyright © 2026 Near 22. All rights reserved.
//

import Foundation

public extension String {
    var localizedApp: String {
        NSLocalizedString(self, bundle: Bundle.main, comment: "")
    }

    func localizedApp(with arguments:CVarArg...)->String {
        return String(format: localizedApp, arguments: arguments)
    }
    
    func localized(with arguments: [CVarArg]) -> String {
        String(format: self.localizedApp, arguments: arguments)
    }
}
