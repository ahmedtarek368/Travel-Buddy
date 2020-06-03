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
    db.collection("Port Said").document("Restaurant3").setData([
        "name": "Central Perk", "phone": "066 3411131", "rate": 4.5, "category": "Restaurants", "town": "Port Said", "address": "Qesm Ash Sharq, 23rd of July st", "coordinates": [31.249633,32.322203], "image": "Central%20Perk.jpg?alt=media&token=8f4fe8b2-c290-42fc-92e7-0ea44a63e00d"], merge : true)
    { err in
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
                    data.append(["name":docData["name"]!,"rate":docData["rate"]!,"phone":docData["phone"]!,"image":docData["image"]!,"address":docData["address"]!,"town":docData["town"]!,"coordinates":docData["coordinates"]!,"prices":docData["prices"]!])
                }
                //print(data)
                completion(data)
            }
    }
}

