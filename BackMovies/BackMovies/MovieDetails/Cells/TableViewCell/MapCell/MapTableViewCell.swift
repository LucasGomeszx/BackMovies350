//
//  MapTableViewCell.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 27/03/23.
//

import UIKit
import MapKit

enum MapStrings: String {
    case mapLabel = "Que tal um cineminha?"
}

class MapTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var movieMap: MKMapView!
    
    static let identifier: String = String(describing: MapTableViewCell.self)
    
    let locationManager = CLLocationManager()
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()

    }
    
    private func setUpView() {
        mainView.backgroundColor = .clear
        mapLabel.text = MapStrings.mapLabel.rawValue
        mapLabel.textColor = .white
        movieMap.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func searchNearbyCinemas(userLocation: CLLocation) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "cinema"
        request.region = movieMap.region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response, error == nil else {
                print("Erro ao buscar cinemas: \(error?.localizedDescription ?? "")")
                return
            }

            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.title = item.name
                annotation.coordinate = item.placemark.coordinate
                self.movieMap.addAnnotation(annotation)
            }
        }
    }

}

extension MapTableViewCell: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 2500, longitudinalMeters: 2500)
        movieMap.setRegion(region, animated: false)
        searchNearbyCinemas(userLocation: userLocation)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro ao obter a localização do usuário: \(error.localizedDescription)")
    }
}

extension MapTableViewCell: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation, let title = annotation.title {
            let placemark = MKPlacemark(coordinate: annotation.coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = title
            
            let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: options)
        }
    }

}
