//
//
//  pokemon-demo
//
//  Created by Gabriel Augusto Marson on 25/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import Foundation

struct NetworkError {
    var message: String?
    var error: Error?
    var code: Int?
    
    init(message: String? = nil, error: Error? = nil) {
        if let error = error {
            self.error = error
            self.code = error._code
            self.message = (message == nil) ? error.localizedDescription : message
        } else if let message = message {
            self.message = message
        }
        
    }
}
