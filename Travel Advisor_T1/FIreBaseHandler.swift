//
//  FIreBaseDataInsertion.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 5/27/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import Foundation
import UIKit
import Firebase

func insertData(){
    let db = Firestore.firestore()
    db.collection("towns").document("Sharm El Sheikh").collection("Hotels").document("H1").setData([
        "name": "Los Angeles"
    ]) { err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
            print("Document successfully written!")
        }
    }
}

func deleteData(){
    let db = Firestore.firestore()
    db.collection("towns").document("Sharm El Sheikh").collection("Hotels").document("H1").delete() { err in
        if let err = err {
            print("Error removing document: \(err)")
        } else {
            print("Document successfully removed!")
        }
    }
}

func readData(town:String,category:String,completion: @escaping (_ data : Array<Dictionary<String,Any>>) -> ()){
    
    var data : Array<Dictionary<String,Any>> = []
    let db = Firestore.firestore()
    db.collection(town).whereField("category", isEqualTo: category)
        .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let docData = document.data()
                data.append(["name":docData["name"]!,"rate":docData["rate"]!,"phone":docData["phone"]!,"image":docData["image"]!,"address":docData["address"]!,"town":docData["town"]!,"coordinates":docData["coordinates"]!])
                }
                //print(data)
                completion(data)
            }
    }
}

