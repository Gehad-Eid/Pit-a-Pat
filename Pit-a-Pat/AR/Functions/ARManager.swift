
//  Created by Gehad Eid on 28/01/2024.

import Combine

class ARManager {
    // Singleton pattern (means it would be only one instance of an object)
    static let shared = ARManager()
    private init(){}
    
    //pass values from our view to our AR view
    var ARStream = PassthroughSubject<Actions, Never>()
    
    
}
