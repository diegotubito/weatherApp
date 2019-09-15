//
//  MockServiceManager.swift
//  weatherAppTests
//
//  Created by Gomez David Diego on 15/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import XCTest
@testable import weatherApp

class MockServiceManager: XCTestCase {
    
    var shouldReturnError = false
    var requestRetrieveDataWasCalled = false
    
    enum MockServiceError: Error {
        case requestData
    }
    
    func reset() {
        shouldReturnError = false
        requestRetrieveDataWasCalled = false
     //   mockData = try? JSONSerialization.data(withJSONObject: mockJson)
        
    }
    
    var mockData : [String : Any]?
    var mockJson = ["data": [[
                            "rh": 65,
                            "pod": "d",
                            "lon": -78.63861,
                            "pres": 1006.5,
                            "timezone": "America New_York",
                            "ob_time": "2019-09-15 19:10",
                            "country_code": "US",
                            "clouds": 75,
                            "ts": 1568574600,
                            "solar_rad": 532.5,
                            "state_code": "NC",
                            "city_name": "Raleigh",
                            "wind_spd": 1.79,
                            "last_ob_time": "2019-09-15T19:10:00",
                            "wind_cdir_full": "north-northwest",
                            "wind_cdir": "NNW",
                            "slp": 1018.3,
                            "vis": 5,
                            "h_angle": 25.7,
                            "sunset": "23:22",
                            "dni": 881.1,
                            "dewpt": 22,
                            "snow": 0,
                            "uv": 3.81957,
                            "precip": 0,
                            "wind_dir": 336,
                            "sunrise": "10:57",
                            "ghi": 761.58,
                            "dhi": 112.38,
                            "aqi": 50,
                            "lat": 35.7721,
                            "weather": [
                                        "icon": "c02d",
                                        "code": "802",
                                        "description": "Scattered clouds"],
                            "datetime": "2019-09-15:19",
                            "temp": 29.2,
                            "station": "1327W",
                            "elev_angle": 48.15,
                            "app_temp": 32.3]],
                    "count": 1] as [String : Any]
    
}

extension MockServiceManager: ServiceManagerProtocol {
    func retrieveJSON(url: String, result: @escaping ([String : Any]?, Error?) -> Void) {
        requestRetrieveDataWasCalled = true
        
        if shouldReturnError {
            result(nil, MockServiceError.requestData)
        } else {
            result(mockJson, nil)
        }
    }
    
}

