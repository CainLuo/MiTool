//
//  ApiNetworkManager+.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Alamofire
import Foundation

extension ApiManager {
    func fetchDeivceFP(
        deviceId: UUID,
        cookie: String,
        completion: @escaping (String) -> Void
    ) {
        func generateSeed() -> String {
            let characters = "0123456789abcdef"
            var result = ""
            for _ in 0 ..< 16 {
                let randomIndex = Int.random(in: 0 ..< characters.count)
                let character = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
                result.append(character)
            }
            return result
        }

        let url = "https://public-data-api.mihoyo.com/device-fp/api/getFp"
        let deviceId = deviceId.uuidString
        let body: Parameters = [
            "seed_id": generateSeed(),
            "device_id": deviceId,
            "platform": "5",
            "seed_time": "\(Int(Date().timeIntervalSince1970) * 1000)",
            // swiftlint:disable line_length
            "ext_fields": """
            {"vendor":"--","ramCapacity":"3662","cpuCores":"6","chargeStatus":"3","romCapacity":"121947","ramRemain":"76","accelerometer":"0.054596x-0.290237x-0.957809","networkType":"WIFI","screenSize":"390×844","isJailBreak":"0","gyroscope":"-0.024806x0.070681x-0.020708","IDFV":"275379E1-5FB1-42B9-86D6-F4F80A6CAC2C","proxyStatus":"1","magnetometer":"-118.163391x-247.904663x-353.548492","batteryStatus":"100","cpuType":"CPU_TYPE_ARM64","model":"iPhone13,2","osVersion":"17.1.1","romRemain":"3963","appMemory":"60"}
            """,
            // swiftlint:enable line_length
            "app_name": "bbs_cn",
            "device_fp": "38d7ebd3b45ae",
        ]
        
        post(
            url: url,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: HTTPHeaders(["Cookie": cookie])
        ) { (result: Result<MiHoYoDeviceFPResponseModel, Error>) in
            switch result {
            case .success(let success):
                if let deviceFp = success.data?.deviceFp {
                    completion(deviceFp)
                }
                Logger.info(success)
            case .failure(let failure):
                Logger.error(failure)
            }
        }
    }
}
