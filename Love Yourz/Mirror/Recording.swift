//
//  Recording.swift
//  Love Yourz
//
//  Created by Sanchitha Dinesh on 8/1/24.
//

import Foundation

struct Recording {
    let fileURL: URL
    let createdAt: Date
}




func getFileDate(for file: URL) -> Date {
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
        let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
    } else {
        return Date()
    }
}

