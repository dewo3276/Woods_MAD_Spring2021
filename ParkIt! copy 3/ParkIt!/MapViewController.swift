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
    
    var timeCounters=0
    var timeCountersStopped=0
    var FinallyParked = false
    
    var parkingData = parkingDataLoader()
    
    @IBOutlet weak var mapViewer: MKMapView!
    
    @IBAction func centeringButton(_ sender: UIButton) {
        centerViewWindow()
    }
    @IBOutlet weak var switchBikeMode: UISwitch!
    
    let formatter: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.locale = .current
        return formatter
        
    }()
    
    let pinDropped = MKPointAnnotation()
    
    let locationManagment = CLLocationManager()
    let windowSize = Double(1000)
    var timeInterval = Int(10)
    var movementDetected = false
    var parking = parkingDataLoader()
    
    override func viewWillDisappear(_ animated: Bool) {
        mapViewer.removeAnnotation(pinDropped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagment.startUpdatingLocation()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        checkServices()
        mapViewer.showsUserLocation = true
        if(UserDefaults.standard.object(forKey: "parked") != nil)
        {
            parkingData.loadData()
            if(Varriables.selectedCoords[0] != "0")
            {
                viewPreviousLocation()
            }
        }
    }
    
    
    func viewPreviousLocation(){
        
        print(Varriables.selectedCoords[0]+" "+Varriables.selectedCoords[1])
        let location = CLLocationCoordinate2DMake(Double(Varriables.selectedCoords[0])!, Double(Varriables.selectedCoords[1])!)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05,longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapViewer.setRegion(region, animated: true)
        
        pinDropped.coordinate=location
        pinDropped.title = "Parked Car"
        pinDropped.subtitle = Varriables.selectedDate
        
        mapViewer.addAnnotation(pinDropped)
    }
    
    func centerViewWindow(){
        
        if let location = locationManagment.location?.coordinate{
        
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: windowSize, longitudinalMeters: windowSize)
            mapViewer.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        if location.speed>15
        {
            switchBikeMode.setOn(false, animated: true)
        }
        
        var speedLimit=11.17
        var speedLimitLower = 1.8
        if switchBikeMode.isOn
        {
            speedLimit=2.68
        }
        
        
        if(location.speed>=speedLimit)
        {
            print("speed over 10mph")
            print(timeCounters)
            timeCounters+=1
            if(timeCounters>=5)
            {
                movementDetected=true
            }
        }
        
        if(location.speed<speedLimitLower && movementDetected==true)
        {
            print("speed under 10mph")
            print(timeCountersStopped)
            timeCountersStopped+=1
            if(timeCountersStopped>=20)
            {
                timeCounters=0
                movementDetected=false
                parked()
            }
        }
    }
    
    func startLocationServices(){
        locationManagment.delegate=self
        locationManagment.desiredAccuracy=kCLLocationAccuracyBest
    }

    func checkServices(){
        if CLLocationManager.locationServicesEnabled(){
            startLocationServices()
            locationManagment.requestAlwaysAuthorization()
            locationManagment.requestWhenInUseAuthorization()
            centerViewWindow()
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
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkServices()
    }
    
    func parked(){
        let lat = locationManagment.location!.coordinate.latitude
        let long = locationManagment.location!.coordinate.longitude
        parking.deleteData()
        
        parking.addData(pinCoords: [String(lat),String(long)], dateAndtime: formatter.string(from: Date()))
        
        let notifications = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        if switchBikeMode.isOn
        {
            content.title="Parked bike location added to history"
        }
        else
        {
            content.title="Parked car location added to history"
        }
        
        content.body="tap here to view location"
        content.sound = .default
        
        print("notificaiton about to come up")
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)
        
        notifications.add(request) { (error) in
            
        }
    }
}
