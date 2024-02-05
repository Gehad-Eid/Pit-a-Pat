//  Created by Faizah Almalki on 19/07/1445 AH.

//import Foundation
import CloudKit

struct Player: Identifiable {
    let id: CKRecord.ID
    let Name: String
    let score: Int
    
    init(record: CKRecord) {
        self.id = record.recordID
        self.Name = record["Name"] as? String ?? "N/A"
        self.score = record["score"] as? Int ?? 0
    }
}
