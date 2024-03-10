//
//  File.swift
//
//
//  Created by 戴藏龙 on 2023/10/17.
//

import Foundation

@available(iOS 15.0, *)
extension MiHoYoAPI {
    public static func dailyNote(
        server: Server,
        uid: String,
        cookie: String,
        sTokenV2: String?,
        deviceFingerPrint: String?,
        deviceId: UUID?
    ) async throws
        -> any DailyNote {
        switch server.region {
        case .mainlandChina:
            if let sTokenV2 {
                return try await widgetDailyNote(
                    cookie: cookie,
                    sTokenV2: sTokenV2,
                    deviceFingerPrint: deviceFingerPrint,
                    deviceId: deviceId
                )
            } else {
                throw MiHoYoAPIError.noStokenV2
            }
        case .global:
            return try await generalDailyNote(
                server: server,
                uid: uid,
                cookie: cookie,
                deviceFingerPrint: deviceFingerPrint,
                deviceId: deviceId
            )
        }
    }

    public static func generalDailyNote(
        server: Server,
        uid: String,
        cookie: String,
        deviceFingerPrint: String?,
        deviceId: UUID?
    ) async throws
        -> GeneralDailyNote {
        let queryItems: [URLQueryItem] = [
            .init(name: "role_id", value: uid),
            .init(name: "server", value: server.id),
        ]

        let additionalHeaders: [String: String]? = {
            if let deviceFingerPrint, !deviceFingerPrint.isEmpty, let deviceId {
                return [
                    "x-rpc-device_fp": deviceFingerPrint,
                    "x-rpc-device_id": deviceId.uuidString,
                ]
            } else {
                return nil
            }
        }()

        let request = try await Self.generateRecordAPIRequest(
            region: server.region,
            path: "/game_record/app/genshin/api/dailyNote",
            queryItems: queryItems,
            cookie: cookie,
            additionalHeaders: additionalHeaders
        )

        let (data, _) = try await URLSession.shared.data(for: request)

        return try await .decodeFromMiHoYoAPIJSONResult(data: data, with: request)
    }

    static func widgetDailyNote(
        cookie: String,
        sTokenV2: String,
        deviceFingerPrint: String?,
        deviceId: UUID?
    ) async throws
        -> WidgetDailyNote {
        let cookie = cookie + "stoken: \(sTokenV2)"
        let additionalHeaders: [String: String]? = {
            if let deviceFingerPrint, !deviceFingerPrint.isEmpty, let deviceId {
                return [
                    "x-rpc-device_fp": deviceFingerPrint,
                    "x-rpc-device_id": deviceId.uuidString,
                ]
            } else {
                return nil
            }
        }()

        let request = try await Self.generateRecordAPIRequest(
            region: .mainlandChina,
            path: "/game_record/app/genshin/aapi/widget/v2",
            queryItems: [],
            cookie: cookie,
            additionalHeaders: additionalHeaders
        )

        let (data, _) = try await URLSession.shared.data(for: request)
        return try await .decodeFromMiHoYoAPIJSONResult(data: data, with: request)
    }
}
