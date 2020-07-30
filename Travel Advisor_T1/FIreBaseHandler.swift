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
    db.collection("Places").document().setData([
        "name": "Portobello", "phone": "01098612111", "rate": 4.7, "category": "Restaurants", "town": "Port Said", "address": "Qesm Ash Sharq, Atef El-Sadat st", "coordinates": [31.272453,32.293507], "image": "Portobello.jpg?alt=media&token=976995d1-2ca0-4679-a98a-3e99ea02a7c7", "prices": 3], merge : true)
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

func readData(town:String,category:String,completion: @escaping (_ data : [Place]) -> ()){
    
    var places : [Place] = []
    let db = Firestore.firestore()
    db.collection("Places").whereField("category", isEqualTo: category).whereField("town", isEqualTo: town)
        .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let docData = document.data()
                    
                    places.append(Place(name: docData["name"]! as! String, phone: docData["phone"]! as! String, address: docData["address"]! as! String, category: docData["category"]! as! String, town: docData["town"]! as! String, image: docData["image"]! as! String, rate: docData["rate"]! as! NSNumber , prices: docData["prices"]! as! NSNumber, coordinates: docData["coordinates"]! as! [NSNumber], imageData: .init(), placeId: docData["pid"]! as! String))
                }
                //print(data)
                completion(places)
            }
    }
}

