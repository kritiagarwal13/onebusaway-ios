//
//  CreateAlarmOperation.swift
//  OBAKit
//
//  Created by Aaron Brethorst on 10/17/18.
//  Copyright © 2018 OneBusAway. All rights reserved.
//

import Foundation

public class CreateAlarmOperation: NetworkOperation {

    private static let apiPath = "/api/v1/regions/%@/alarms"
    public class func buildAPIPath(regionID: String) -> String {
        return String(format: apiPath, regionID)
    }

    public class func buildURLRequest(
        secondsBefore: TimeInterval,
        stopID: String,
        tripID: String,
        serviceDate: Date,
        vehicleID: String?,
        stopSequence: Int,
        userPushID: String,
        regionID: String,
        baseURL: URL,
        queryItems: [URLQueryItem]
    ) -> URLRequest {
        var params: [String: Any] = [
            "seconds_before": secondsBefore,
            "stop_id": stopID,
            "trip_id": tripID,
            "service_date": Int64(serviceDate.timeIntervalSince1970 * 1000),
            "stop_sequence": stopSequence,
            "user_push_id": userPushID
        ]

        if let vehicleID = vehicleID {
            params["vehicle_id"] = vehicleID
        }

        let url = buildURL(fromBaseURL: baseURL, path: buildAPIPath(regionID: regionID), queryItems: queryItems)
        let urlRequest = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = NetworkHelpers.dictionary(toHTTPBodyData: params)

        return urlRequest as URLRequest
    }
}
