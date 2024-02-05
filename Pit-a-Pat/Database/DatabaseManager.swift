
//  Created by Gehad Eid on 04/02/2024.


import Combine

class DatabaseManager {
    // Singleton pattern (means it would be only one instance of an object)
    static let shared = DatabaseManager()
    private init(){}
    
    //pass values from our view to our AR view
    var DatabaseStream = PassthroughSubject<Actions, Never>()
}
