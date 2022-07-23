//
//  FireThread.swift
//  Meetings
//
//  Created by Yu on 2022/07/23.
//

import Firebase

class FireThread {
    
    static func createThread(title: String) {
        // UIDの有無を確認
        if FireAuth.uid() == nil {
            return
        }
        
        // ドキュメントを追加
        let db = Firestore.firestore()
        db.collection("threads")
            .addDocument(data: [
                "createdAt": FieldValue.serverTimestamp(),
                "userId": FireAuth.uid()!,
                "title": title
            ]) { error in
                if let error = error {
                    print("HELLO! Fail! Error adding new document. Error: \(error)")
                } else {
                    print("HELLO! Success! Added 1 Thread.")
                }
            }
    }
    
}