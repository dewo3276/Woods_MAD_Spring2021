//
//  MapViewController.swift
//  ParkIt!
//
//  Created by Dusty on 2/22/21.
//

import UIKit
import MapKit
import CoreLocation
import UserNotifications

class MapViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var mapViewerWindow: MKMapView!
    @IBAction func recenterButton(_ sender: UIButton) {
        centerViewWindow()
    }
    
    let formatter: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.locale = .current
        return formatter
        
    }()
    
    let locationManagment = CLLocationManager()
    let windowSize = Double(1000)
    var timeInterval = Int(10)
    var movementDetected = false
    var parking = parkingDataLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkServices()
        mapViewerWindow.showsUserLocation = true
        if(Varriables.didAppearFromTableView==true)
        {
            viewPreviousLocation()
            Varriables.didAppearFromTableView=false
        }
    }
    
    func startLocationServices(){
        locationManagment.delegate=self
        locationManagment.desiredAccuracy=kCLLocationAccuracyBest
    }
    
    func centerViewWindow(){
        
        if let location = locationManagment.location?.coordinate{
        
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: windowSize, longitudinalMeters: windowSize)
            mapViewerWindow.setRegion(region, animated: true)
        }
    }
    
    func viewPreviousLocation(){
        
        print(Varriables.selectedCoords[0]+" "+Varriables.selectedCoords[1])
        let location = CLLocationCoordinate2DMake(Double(Varriables.selectedCoords[0])!, Double(Varriables.selectedCoords[1])!)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05,longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapViewerWindow.setRegion(region, animated: true)
        
        let pinDropped = MKPointAnnotation()
        pinDropped.coordinate=location
        pinDropped.title = "Parked Car"
        pinDropped.subtitle = "22 minutes ago"
        
        mapViewerWindow.addAnnotation(pinDropped)
    }
    
    func checkServices(){
        if CLLocationManager.locationServicesEnabled(){
            startLocationServices()
            locationManagment.requestAlwaysAuthorization()
            locationManagment.requestWhenInUseAuthorization()
            centerViewWindow()
            isMoving()
        }
        else
        {
            let alertController = UIAlertController(title: "Location Services Disabled", message:
                    "Please enable location service for this app to perform properly.", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            
            let settingsAction = UIAlertAction(title: "settings", style: .default)
            {
                UIAlertAction in  UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
            
            alertController.addAction(settingsAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: windowSize, longitudinalMeters: windowSize)
        mapViewerWindow.setRegion(region, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkServices()
    }
    
    func parked(detectionStatus: Bool){
        if (detectionStatus == false)
        {
            let lat = locationManagment.location!.coordinate.latitude
            let long = locationManagment.location!.coordinate.longitude
            
            parking.addData(pinCoords: [String(lat),String(long)], dateAndtime: formatter.string(from: Date()))
            let notifications = UNUserNotificationCenter.current()
            notifications.requestAuthorization(options: [.alert, .sound])
                {(granted, error) in}
            let content = UNMutableNotificationContent()
            content.title="Parked car location added to history"
            content.body="tap here to view location"
        }
    }
    
    func isMoving(){
        let speed: Double = CLLocationSpeed()
        let start = Date()
        while(speed>=15)
        {
            if(start.timeIntervalSinceNow>10)
            {
                movementDetected=true
                break
            }
        }
        while(speed<15 && movementDetected==true)
        {
            if(start.timeIntervalSinceNow>600)
            {
                movementDetected=false
                parked(detectionStatus: movementDetected)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
