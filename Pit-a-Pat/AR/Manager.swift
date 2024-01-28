
//  Created by Gehad Eid on 28/01/2024.

import Combine

class Manager {
    // Singleton pattern (means it would be only one instance of an object)
    static let shared = Manager()
    private init(){}
    
    //pass values from our view to our AR view
    var ARStream = PassthroughSubject<Actions, Never>()
    
    
}
