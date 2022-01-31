//
//  UserViewModel.swift
//  Smart Client Fit (iOS)
//
//  Created by Rafael Escaleira on 28/01/22.
//

import Foundation
import CoreLocation

class UserViewModel: ObservableObject {
    private var webservice: Webservice
    
    @Published var user: User?
    @Published var history: UserHistoryAccess?
    @Published var payment: UserPayment?
    @Published var locations: Locations?
    @Published var mapLocations: [MapLocation] = []
    @Published var currentLocation: MapLocation?
    
    init() {
        self.webservice = Webservice()
    }
    
    func getUser(lastDays: Int = 90) {
        if let secret = HeaderToken.defaultHeaderToken.pageProps?.session?.secret {
            self.webservice.getUser(secret: secret) { user in
                if let user = user {
                    self.user = user
                    _ = try? user.save(on: .currentUser)
                    self.getUserHistoryAccess(lastDays: lastDays)
                    self.getUserPayments()
                }
            }
        }
    }
    
    func getUserHistoryAccess(lastDays: Int, completion: (() -> ())? = nil) {
        if let secret = HeaderToken.defaultHeaderToken.pageProps?.session?.secret,
           let userID = user?.personal?.id,
           let userToken = user?.personal?.single_access_token {
            self.webservice.getUserHistoryAccess(secret: secret, userID: userID, lastDays: lastDays) { userHistoryAccess in
                if let userHistoryAccess = userHistoryAccess {
                    self.history = userHistoryAccess
                    _ = try? self.history?.save(on: .userHistoryAccess(userID))
                    self.getLocations(token: userToken, completion: completion)
                }
            }
        }
    }
    
    func getUserPayments() {
        if let secret = HeaderToken.defaultHeaderToken.pageProps?.session?.secret,
           let user = try? DataManager.shared.get(on: .currentUser, User.self),
           let userID = user.personal?.id {
            self.webservice.getUserPayment(secret: secret) { userPayment in
                if let userPayment = userPayment {
                    self.payment = userPayment
                    _ = try? self.payment?.save(on: .userPayment(userID))
                }
            }
        }
    }
    
    func getLocations(token: String, completion: (() -> ())? = nil) {
        if let locations = try? DataManager.shared.get(on: .locations, Locations.self),
           let user = try? DataManager.shared.get(on: .currentUser, User.self),
           let currentLocationID = user.location?.smart_system_id,
           let currentLocation = locations.data?.data?.first(where: { "\(currentLocationID)" == $0.id }),
           let address = currentLocation.attributes?.address,
           let cityName = currentLocation.attributes?.cityName {
            self.locations = locations
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address + ", " + cityName) { (placemarks, error) in
                if let placemarks = placemarks,
                   let location = placemarks.first?.location {
                    self.currentLocation = MapLocation(hour: "", name: currentLocation.attributes?.name ?? "", address: currentLocation.attributes?.address ?? "", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, count: 0)
                    _ = try? self.currentLocation?.save(on: .currentLocation)
                    _ = try? self.locations?.save(on: .locations)
                    self.getMapLocations(completion: completion)
                }
            }
        } else if let secret = HeaderToken.defaultHeaderToken.pageProps?.session?.secret,
                  let user = try? DataManager.shared.get(on: .currentUser, User.self),
                  let currentLocationID = user.location?.smart_system_id {
            self.webservice.getLocations(secret: secret, token: token) { locations in
                if let locations = locations,
                   let currentLocation = locations.data?.data?.first(where: { "\(currentLocationID)" == $0.id }),
                   let address = currentLocation.attributes?.address,
                   let cityName = currentLocation.attributes?.cityName {
                    self.locations = locations
                    let geoCoder = CLGeocoder()
                    geoCoder.geocodeAddressString(address + ", " + cityName) { (placemarks, error) in
                        if let placemarks = placemarks,
                           let location = placemarks.first?.location {
                            self.currentLocation = MapLocation(hour: "", name: currentLocation.attributes?.name ?? "", address: currentLocation.attributes?.address ?? "", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, count: 0)
                            _ = try? self.currentLocation?.save(on: .currentLocation)
                            _ = try? self.locations?.save(on: .locations)
                            self.getMapLocations(completion: completion)
                        }
                    }
                }
            }
        }
    }
    
    func getMapLocations(completion: (() -> ())? = nil) {
        if let locations = try? DataManager.shared.get(on: .locations, Locations.self),
           let user = try? DataManager.shared.get(on: .currentUser, User.self),
           let userID = user.personal?.id,
           let historyAccess = try? DataManager.shared.get(on: .userHistoryAccess(userID), UserHistoryAccess.self),
           let locationDataAttributes = locations.data?.data?.filter({ locationData in
               historyAccess.data?.contains(where: { historyData in
                   return "\(historyData.attributes?.locationId ?? -1)" == locationData.id
               }) ?? false
           }).map({ locationData -> MapLocation in
               let historyAccessData = historyAccess.data?.filter({ historyData in
                   return "\(historyData.attributes?.locationId ?? -1)" == locationData.id
               })
               
               return MapLocation(hour: historyAccessData?.last?.attributes?.createdAt?.formatted(on: "yyyy-MM-dd-HH:mm", with: "HH:mm") ?? "", name: locationData.attributes?.name ?? "", address: (locationData.attributes?.address ?? "") + ", " + (locationData.attributes?.cityName ?? ""), latitude: 0, longitude: 0, count: historyAccessData?.count ?? 0)
           }) {
            self.addressToCoordinate(mapLocationsData: locationDataAttributes, index: 0, completion: completion)
        }
    }
    
    func addressToCoordinate(mapLocationsData: [MapLocation], index: Int, completion: (() -> ())? = nil) {
        if index < mapLocationsData.count {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(mapLocationsData[index].address) { (placemarks, error) in
                if let placemarks = placemarks,
                   let location = placemarks.first?.location {
                    let mpLocData = mapLocationsData[index]
                    if self.mapLocations.isEmpty == false {
                        self.mapLocations.append(MapLocation(hour: mpLocData.hour, name: mpLocData.name, address: mpLocData.address, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, count: mpLocData.count))
                    } else {
                        self.mapLocations = [MapLocation(hour: mpLocData.hour, name: mpLocData.name, address: mpLocData.address, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, count: mpLocData.count)]
                    }
                }
                self.addressToCoordinate(mapLocationsData: mapLocationsData, index: index + 1)
            }
        } else {
            completion?()
        }
    }
}

