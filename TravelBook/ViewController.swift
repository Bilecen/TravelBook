//
//  ViewController.swift
//  TravelBook
//
//  Created by Muhammet Taha Bilecen on 27.10.2021.
//

import UIKit
import MapKit
import CoreData

class ViewController: UIViewController , MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var chosenlatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let gestcureRecongnizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestcureRecongnizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(gestcureRecongnizer)
    }

    @IBAction func saveButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        newPlace.setValue(nameText.text, forKey: "title")
        newPlace.setValue(commentText.text, forKey: "subtitle")
        newPlace.setValue(chosenlatitude, forKey: "latitude")
        newPlace.setValue(chosenLongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        do{
        try context.save()
            print("save")
        }catch{
            print("fail")
        }
    
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude
                                              , longitude: locations[0].coordinate.longitude)
        // Ne kadar küçük olursa o kadar zoomlar
    
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    @objc func chooseLocation(gestureRecognizer : UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began {
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            chosenlatitude = touchedCordinates.latitude
            chosenLongitude = touchedCordinates.longitude
            let annotion = MKPointAnnotation()
            annotion.coordinate = touchedCordinates
            annotion.title = nameText.text
            annotion.subtitle = commentText.text
            self.mapView.addAnnotation(annotion)
        }
    }

}

