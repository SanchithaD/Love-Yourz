//
//  Date.swift
//  Love Yourz
//
//  Created by Sanchitha Dinesh on 8/1/24.
//

import Foundation

extension Date
{
    func toString(dateFormat format: String ) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
        
    }

}

