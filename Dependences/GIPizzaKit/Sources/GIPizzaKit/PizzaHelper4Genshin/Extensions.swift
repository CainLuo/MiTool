//
//  Extensions.swift
//
//
//  Created by Bill Haku on 2023/3/25.
//

import CommonCrypto
import CryptoKit
import Defaults
import Foundation

// MARK: - String

extension String {
    public var localized: String {
        String(format: NSLocalizedString(self, comment: ""))
    }

    public var spmLocalized: String {
        String(format: NSLocalizedString(self, bundle: Bundle.module, comment: ""))
    }
}

extension String {
    @available(iOS 15, watchOS 8, *)
    public func toAttributedString() -> AttributedString {
        let attributedString = try? AttributedString(markdown: self)
        return attributedString ?? ""
    }
}

extension String {
    /**
     - returns: the String, as an MD5 hash.
     */
    public var md5: String {
        let digest = Insecure.MD5.hash(data: Data(utf8))
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

    public var sha256: String {
        let digest = SHA256.hash(data: Data(utf8))
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
