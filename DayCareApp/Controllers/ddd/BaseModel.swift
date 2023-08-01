//
//  BaseModel.swift
//  Scout App
//
//  Created by Osama Mansoori on 11/27/20.
//  Copyright © 2020 AppiskeyUser. All rights reserved.
//

import Foundation

//Error Message Response:
class ServerErrorResponse: Decodable {
    
    var error_description: String?
    var status: Int?
    var message: String?
    var email: [String]?
    var forgotPasswordEmail: String?
    var error: String?
    var errors: [String: Any]?
    var password: String?
    var oldPassword: String?
    var observation: String?
    var questionnaire_not_filled: String?
    var inspection_payment_status: String?
    
    enum CodingKeys : String , CodingKey {
        case error_description
        case status
        case message
        case email
        case forgotPasswordEmail
        case error
        case errors
        case password
        case oldPassword
        case observation
        case questionnaire_not_filled
        case inspection_payment_status
    }
    
    public required init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.error_description = try? container.decodeIfPresent(String.self, forKey: .error_description)
        self.status = try? container.decodeIfPresent(Int.self, forKey: .status)
        self.message = try? container.decodeIfPresent(String.self, forKey: .message)
        self.email = try? container.decodeIfPresent([String].self, forKey: .email)
        self.error = try? container.decodeIfPresent(String.self, forKey: .error)
        
        if let errorsDict = try? container.decodeIfPresent([String: [String]].self, forKey: .errors) {
            
            if let passwordValue = errorsDict["password"]?.first{
                self.password = passwordValue
            }
            
            if let emailValue = errorsDict["email"]?.first{
                self.forgotPasswordEmail = emailValue
            }
            
            if let old_passwordValue = errorsDict["old_password"]?.first{
                self.oldPassword = old_passwordValue
            }
            
            if let observation_nameValue = errorsDict["observation_name"]?.first{
                self.observation = observation_nameValue
            }
            
            if let questionnaire_not_filledValue = errorsDict["questionnaire_not_filled"]?.first{
                self.questionnaire_not_filled = questionnaire_not_filledValue
            }
            
            if let inspection_payment_statusValue = errorsDict["inspection_payment_status"]?.first{
                self.inspection_payment_status = inspection_payment_statusValue
            }
        }
    }
}

// Server Message Response:
struct ServerMessageResponse: Decodable {
    var message: String
}

// Server Test Message Error:
struct TestErrorResponse: Decodable {
    var message: String?
}

// MARK: - NotificationModel
struct NotificationModel: Decodable {
    let data: [NotificationDataModel]?
    let path: String?
    let perPage: Int?
    let unreadNotificationsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case path = "path"
        case perPage = "per_page"
        case unreadNotificationsCount = "unread_notifications_count"
    }
}

// MARK: - NotificationDataModel
struct NotificationDataModel: Decodable {
    let id: String?
    let notifiableType: String?
    let notifiableID: Int?
    let data: DetailNotificationModel?
    var readAt: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case notifiableType = "notifiable_type"
        case notifiableID = "notifiable_id"
        case data = "data"
        case readAt = "read_at"
        case createdAt = "created_at"
        
    }
}

// MARK: - DataClass
class DetailNotificationModel: Decodable {
    let title: String?
    let body: String?
    let type: String?
    let data: RedirectionData?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case body = "body"
        case type = "type"
        case data = "data"
    }
}

// MARK: - RedirectionData
struct RedirectionData: Decodable {
    var inspectionID: Int
    var observationID: Int
    var observationName: String
    var redirection_type: String
    var roomPivotId: Int
    
    enum CodingKeys: String, CodingKey {
        case inspectionID = "inspection_id"
        case observationID = "observation_id"
        case observationName = "observation_name"
        case redirection_type = "redirection_type"
        case roomPivotId = "roomPivotId"
    }
    
     init(from decoder : Decoder) throws{
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
         
        if let inspectionID = try? container.decodeIfPresent(Int.self, forKey: .inspectionID){
            self.inspectionID = inspectionID
        } else {
            self.inspectionID = 0
        }
        if let observationID = try? container.decodeIfPresent(Int.self, forKey: .observationID){
            self.observationID = observationID
        } else {
            self.observationID = 0
        }
        if let redirection_type = try? container.decodeIfPresent(String.self, forKey: .redirection_type){
            self.redirection_type = redirection_type
        } else {
            self.redirection_type = ""
        }
        if let observationName = try? container.decodeIfPresent(String.self, forKey: .observationName){
            self.observationName = observationName
        } else {
            self.observationName = ""
        }
        if let roomPivotId = try? container.decodeIfPresent(Int.self, forKey: .roomPivotId){
            self.roomPivotId = roomPivotId
        } else {
            self.roomPivotId = 0
        }
    }
}

// MARK: - Add New Room
struct AddNewRoom: Decodable {
    var id: Int?
    var code: String?
    var inspectionBaseCost: String?
    var customerID: Int?
    var scheduledTime: String?
    var status: String?
    var questionnaireStatus: String?
    var observationsStatus: String?
    var notes: String?
    var type: String?
    var paidStatus: String?
    var deletedAt: String?
    var createdAt: String?
    var updatedAt: String?
    var assigned: Bool?
    var paid: Bool?
    var inspectionRooms: [InspectionRoomModel]?
    var observations: [Observation]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case code = "code"
        case inspectionBaseCost = "inspection_base_cost"
        case customerID = "customer_id"
        case scheduledTime = "scheduled_time"
        case status = "status"
        case questionnaireStatus = "questionnaire_status"
        case observationsStatus = "observations_status"
        case notes = "notes"
        case type = "type"
        case paidStatus = "paid_status"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case assigned = "assigned"
        case paid = "paid"
        case inspectionRooms = "inspection_rooms"
        case observations = "observations"
    }
    
    init(from decoder : Decoder) throws{
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try? container.decodeIfPresent(Int.self, forKey: .id){
            self.id = id
        } else {
            self.id = 0
        }
        if let code = try? container.decodeIfPresent(String.self, forKey: .code){
            self.code = code
        } else {
            self.code = ""
        }
        if let inspectionBaseCost = try? container.decodeIfPresent(String.self, forKey: .inspectionBaseCost){
            self.inspectionBaseCost = inspectionBaseCost
        } else {
            self.inspectionBaseCost = ""
        }
        if let customerID = try? container.decodeIfPresent(Int.self, forKey: .customerID){
            self.customerID = customerID
        } else {
            self.customerID = 0
        }
        if let scheduledTime = try? container.decodeIfPresent(String.self, forKey: .scheduledTime){
            self.scheduledTime = scheduledTime
        } else {
            self.scheduledTime = ""
        }
        
        if let status = try? container.decodeIfPresent(String.self, forKey: .status){
            self.status = status
        } else {
            self.status = ""
        }
        if let questionnaireStatus = try? container.decodeIfPresent(String.self, forKey: .questionnaireStatus){
            self.questionnaireStatus = questionnaireStatus
        } else {
            self.questionnaireStatus = ""
        }
        if let observationsStatus = try? container.decodeIfPresent(String.self, forKey: .observationsStatus){
            self.observationsStatus = observationsStatus
        } else {
            self.observationsStatus = nil
        }
        
        if let notes = try? container.decodeIfPresent(String.self, forKey: .notes){
            self.notes = notes
        } else {
            self.notes = ""
        }
        if let type = try? container.decodeIfPresent(String.self, forKey: .type){
            self.type = type
        } else {
            self.type = ""
        }
        if let paidStatus = try? container.decodeIfPresent(String.self, forKey: .paidStatus){
            self.paidStatus = paidStatus
        } else {
            self.paidStatus = ""
        }
        
        if let deletedAt = try? container.decodeIfPresent(String.self, forKey: .deletedAt){
            self.deletedAt = deletedAt
        } else {
            self.deletedAt = ""
        }
        if let createdAt = try? container.decodeIfPresent(String.self, forKey: .createdAt){
            self.createdAt = createdAt
        } else {
            self.createdAt = ""
        }
        if let updatedAt = try? container.decodeIfPresent(String.self, forKey: .updatedAt){
            self.updatedAt = updatedAt
        } else {
            self.updatedAt = ""
        }
        
        if let assigned = try? container.decodeIfPresent(Bool.self, forKey: .assigned){
            self.assigned = assigned
        } else {
            self.assigned = false
        }
        if let paid = try? container.decodeIfPresent(Bool.self, forKey: .paid){
            self.paid = paid
        } else {
            self.paid = false
        }
        if let updatedAt = try? container.decodeIfPresent(String.self, forKey: .updatedAt){
            self.updatedAt = updatedAt
        } else {
            self.updatedAt = ""
        }
        if let observations = try? container.decodeIfPresent([Observation].self, forKey: .observations){
            self.observations = observations
        } else {
            self.observations = []
        }
        if let inspectionRooms = try? container.decodeIfPresent([InspectionRoomModel].self, forKey: .inspectionRooms){
            self.inspectionRooms = inspectionRooms
        } else {
            self.inspectionRooms = []
        }
    }
}

// MARK: - InspectionRoomModel
struct InspectionRoomModel: Decodable {
    var id: Int?
    var inspectionID: String?
    var roomID: String?
    var inspectionRoomDescription: String?
    var questionnaireStatus: String?
    var observationsStatus: String?
    var createdAt: String?
    var updatedAt: String?
    var isNewRoom: Int?
    var testAssigned: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case inspectionID = "inspection_id"
        case roomID = "room_id"
        case inspectionRoomDescription = "description"
        case questionnaireStatus = "questionnaire_status"
        case observationsStatus = "observations_status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isNewRoom = "is_new_room"
        case testAssigned = "test_assigned"
    }
}
