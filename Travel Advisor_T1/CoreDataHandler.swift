//
//  CoreDataHandler.swift
//  Travel Advisor_T1
//
//  Created by Ahmed Tarek on 6/2/20.
//  Copyright © 2020 Ahmed Tarek. All rights reserved.
//

import UIKit
import Foundation
import CoreData

func isAttributeExist(name: String) -> Bool {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourites")
    fetchRequest.predicate = NSPredicate(format: "name == %@" , name)
    let res = try! managedContext.fetch(fetchRequest)
    if res.count > 0{
        print("Data Exist")
        return true
    }else{
        print("Data Not Exist")
        return false
    }
}

func CDInsertion(name: String, rate: Float, prices: Float, phone: String, coordinates: [Double], Image: UIImage, address: String, town: String){
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Favourites" , in: managedContext)
    let favObject = NSManagedObject(entity: entity!, insertInto: managedContext)
    
    favObject.setValue(name, forKey: "name")
    favObject.setValue(rate, forKey: "rate")
    favObject.setValue(phone, forKey: "phone")
    favObject.setValue(coordinates, forKey: "coordinates")
    favObject.setValue(address, forKey: "address")
    favObject.setValue(prices, forKey: "prices")
    favObject.setValue(town, forKey: "town")
    
    let imgData = Image.jpegData(compressionQuality: 1)
    favObject.setValue(imgData, forKey: "image")
    do{
        try managedContext.save()
    }catch{print("error")}
    
    print("Data Inserted")
}

func CDDeletion(name: String){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest : NSFetchRequest<Favourites> = Favourites.fetchRequest()
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.predicate = NSPredicate(format: "name == %@" , name)
    let objs = try! managedContext.fetch(fetchRequest)
    for i in objs{
        managedContext.delete(i)
    }
    do{
        try managedContext.save()
    }catch{print("error")}
    print("Data Deleted")
}

func CDFetching() -> ([Place]){
    
    var places : [Place] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourites")
    fetchRequest.returnsObjectsAsFaults = false
    let Objects = try! managedContext.fetch(fetchRequest)
    
    for i in 0..<Objects.count{
        
        let coordinates = (Objects[i] as AnyObject).value(forKey: "coordinates") as! [NSNumber]
        let name = (Objects[i] as AnyObject).value(forKey: "name")! as! String
        let rate = (Objects[i] as AnyObject).value(forKey: "rate")! as! NSNumber
        let address = (Objects[i] as AnyObject).value(forKey: "address")! as! String
        let phone = (Objects[i] as AnyObject).value(forKey: "phone")! as! String
        let prices = (Objects[i] as AnyObject).value(forKey: "prices")! as! NSNumber
        let town = (Objects[i] as AnyObject).value(forKey: "town")! as! String
        let image = (Objects[i] as AnyObject).value(forKey: "image")! as! Data
    
        places.append(Place(name: name, phone: phone, address: address, category: "", town: town, image: "", rate: rate, prices: prices, coordinates: coordinates, imageData: image))
        //data.append(["name":(Objects[i] as AnyObject).value(forKey: "name")!,"rate":(Objects[i] as AnyObject).value(forKey: "rate")!,"address":(Objects[i] as AnyObject).value(forKey: "address")!,"image":(Objects[i] as AnyObject).value(forKey: "image")!,"phone":(Objects[i] as AnyObject).value(forKey: "phone")!,"prices":(Objects[i] as AnyObject).value(forKey: "prices")!,"town":(Objects[i] as AnyObject).value(forKey: "town")!,"coordinates":coordinates])
    }
    print("data fitched")
    return places
}
