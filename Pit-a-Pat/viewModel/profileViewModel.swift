//
//  profileViewModel.swift
//  Pit-a-Pat
//
//  Created by Faizah Almalki on 19/07/1445 AH.
//


import CloudKit
import SwiftUI
//import UIKit
//import PhotosUI

class ProfileViewModel: ObservableObject{
    var userRecord: CKRecord? = nil
    var userProfile: CKRecord? = nil
    let container = CKContainer(identifier: "iCloud.Pit-a-Pat2")
    
    @Published var Name: String = ""
    @Published var score: Int = 0
    @Published var level: Int = 1
    
//    @Published var peerName: String = ""

//    @Published var selectedImage: PhotosPickerItem? = nil
    
    init() {
            // Set up a subscription to monitor CloudKit changes
        subscribeToProfileChanges()
        }
    
    func subscribeToProfileChanges() {
            let subscription = CKQuerySubscription(recordType: "Profile", predicate: NSPredicate(value: true), options: [.firesOnRecordCreation, .firesOnRecordUpdate])
            let info = CKSubscription.NotificationInfo()
            info.alertBody = "A player's profile has been updated."
            info.shouldBadge = true
            subscription.notificationInfo = info
            
            container.publicCloudDatabase.save(subscription) { _, error in
                if let error = error {
                    print("Subscription failed with error: \(error.localizedDescription)")
                }
            }
        }


    //Get user record
    func getUserRecord() async {
        do{
            let userRecordID = try await container.userRecordID()
            let userRecord = try await  container.publicCloudDatabase.record(for: userRecordID)
            self.userRecord = userRecord
        }
        catch{
            
        } 
    }
    
    //Create profile record
    func createProfileRecord()->CKRecord{
        let record = CKRecord(recordType: "Profile")
        record["Name"]   = Name
        record["score"]  = score
        record["level"]  = level
        //Set image
        return record
    }
    
    
    //fetch user profile
    func fetchUserProfile() async{
        await getUserRecord()
        guard let  userRecord  else {return}
        guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else {
            //User does not have a profile yet
            return
        }
        do{
            let record = try await container.publicCloudDatabase.record(for: profileReference.recordID)
            userProfile = record
            Name = record["Name"] as? String ?? ""
            score  = record["score"] as? Int ?? 0
            level    = record["level"] as? Int ?? 1
            
        }
        catch{
            print(error)
        }
    }
    
    //
    func saveProfile() async{
        guard let userRecord else {
            //If user has no record, this means he is not logged-in in his phone
            //You might ask him to login into his iCloud
            return
        }
        //Check if user already has a profile
        if let _ = userRecord.value(forKey: "userProfile" ) as? CKRecord.Reference {
            await  updateUserProfile()
            NotificationCenter.default.post(name: NSNotification.Name("ProfileUpdated"), object: nil)
        }
        else{
            let userProfile = createProfileRecord()
            userRecord["userProfile"] = CKRecord.Reference(recordID: userProfile.recordID, action: .none)
            container.publicCloudDatabase.modifyRecords(saving: [userProfile,
                                                                 userRecord], deleting: []) {result in
                switch result {
                case .success(_):
                    //Show success alert
                    NotificationCenter.default.post(name: NSNotification.Name("ProfileUpdated"), object: nil)
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    //Update user profile
    func updateUserProfile() async{
        guard let userProfile else {
            return
        }
        userProfile.setValue(Name, forKey: "Name")
        userProfile.setValue(score, forKey: "score")
        userProfile.setValue(level, forKey: "level")
       
        do{
            try await container.publicCloudDatabase.save(userProfile)
            NotificationCenter.default.post(name: NSNotification.Name("ProfileUpdated"), object: nil)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
}

