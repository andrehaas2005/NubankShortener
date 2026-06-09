//
//  LocalStorageProtocol.swift
//  NubankShortener
//
//  Created by Andre  Haas on 08/06/26.
//


public protocol LocalStorageProtocol {
  
  func save(_ items: [AliasResponse])
  func fetch() -> [AliasResponse]
  func fetch(page: Int, pageSize: Int) -> [AliasResponse]
  func removeAll()
}
