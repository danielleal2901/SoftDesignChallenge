//
//  SearchError.swift
//  SoftDesignChallenge
//
//  Created by ACT on 23/02/22.
//

import Foundation

enum SearchError: Error {
    case underlyingError(Error)
    case notFound
    case unkowned
}
