import Foundation
import CloudKit

class ViewModel: ObservableObject {
    @Published var players: [Player] = []
    let container = CKContainer(identifier: "iCloud.Pit-a-Pat2")

    func fetchLearners() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Profile", predicate: predicate)

        let operation = CKQueryOperation(query: query)
        operation.recordMatchedBlock = { recordId, result in
            DispatchQueue.main.async {
                switch result {
                case .success(let record):
                    let player = Player(record: record)
                    self.players.append(player)
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            }
        }

        container.publicCloudDatabase.add(operation)
    }

    func addLearner() {
        let record = CKRecord(recordType: "Player")
        record["Name"] = "Reema"
        record["Score"] = 0
        record["level"] = 1

        container.publicCloudDatabase.save(record) { record, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "an unknown error occurred")
                return
            }
        }
    }

    func sortPlayersByScore() {
        players.sort { $0.score > $1.score }
    }
}
