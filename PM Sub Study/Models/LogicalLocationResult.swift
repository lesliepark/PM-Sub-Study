//
//  LogicalLocationResult.swift
//  PM Sub Study
//
//  Created by Travis Allen on 3/14/19.
//  Copyright © 2019 Travis Allen. All rights reserved.
//
//
// import OMHClient
import LS2SDK
import ResearchSuiteResultsProcessor
import Gloss

open class LogicalLocationResult: RSRPIntermediateResult {
    public enum Action: String {
        case enter = "enter"
        case exit = "exit"
        case startedInside = "startedInside"
        case startedOutside = "startedOutside"
        case startedUnknown = "startedUnknown"
    }
    
    public let locationName: String
    public let action: Action
    public let eventTimestamp: Date
    
    public init(
        uuid: UUID,
        taskIdentifier: String,
        taskRunUUID: UUID,
        locationName: String,
        action: Action,
        eventTimestamp: Date
        ) {
        self.locationName = locationName
        self.action = action
        self.eventTimestamp = eventTimestamp
        
        super.init(
            type: "LogicalLocationResult",
            uuid: uuid,
            taskIdentifier: taskIdentifier,
            taskRunUUID: taskRunUUID
        )
        
    }
    
}

extension LogicalLocationResult: LS2DatapointConvertible {
    public func toDatapoint(builder: LS2DatapointBuilder.Type) -> LS2Datapoint? {
        let sourceName = LS2AcquisitionProvenance.defaultAcquisitionSourceName
        let creationDate = self.startDate ?? Date()
        
        let acquisitionSource = LS2AcquisitionProvenance(sourceName: sourceName, sourceCreationDateTime: creationDate, modality: .SelfReported)
        
        guard let schema: LS2Schema = LS2Schema(name: "geofence-scores", version: LS2SchemaVersion(major: 1, minor: 0, patch: 0), namespace: "Cornell") else {
            return nil
        }
        
        let body: JSON = {
            var body: JSON = [
                "location": self.locationName,
                "action": self.action.rawValue
                ]
            body["effective_time_frame"] = Gloss.Encoder.encode(dateISO8601ForKey: "date_time")(creationDate)
            return body
        }()
        
        let header = LS2DatapointHeader(id: self.uuid, schemaID: schema, acquisitionProvenance: acquisitionSource, metadata: nil)
        return builder.createDatapoint(header: header, body: body)
    }
       
}
