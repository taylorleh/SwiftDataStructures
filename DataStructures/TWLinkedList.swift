//
//  LinkedList.swift
//  DataStructures
//
//  Created by Taylor Lehman on 3/16/18.
//  Copyright © 2018 Taylor Lehman. All rights reserved.
//

import Foundation

public class TWListNode<T>: CustomStringConvertible {
  var value:T
  var next: TWListNode<T>?
  
  public var description: String {
    if next != nil {
      return "\(value)->"
    } else {
      return "\(value)->nil"
    }
  }
  
  public init(_ val: T) {
    self.value = val
  }
}



public class TWLinkedList<T: Equatable>: CustomStringConvertible {
  
  // MARK: Private Props
  
  private var tail: TWListNode<T>?
  
  private var counter: Int = 0
  
  
  // MARK: Public Props
  
  // #pragma mark - public
  public var head: TWListNode<T>?
  
  public var isEmpty: Bool {
    return count == 0 && head == nil
  }
  
  public var count: Int {
    return counter
  }
  
  public var description: String {
    guard head != nil else {
      return "nil"
    }
    var output = ""
    var front:TWListNode! = head
    
    while(front != nil) {
      output += "\(front.value)\u{2192}"
      front = front!.next
    }
    output += "nil"
    return output
  }
  

  
  // MARK: - Initializers
  public init(){}
  
  public init(headValue: T) {
    let newNode = TWListNode(headValue)
    head = newNode
    tail = newNode
  }
  
  
  /// Access a Node from LL using a subscript
  ///
  /// - Parameter index: desired index of node
  subscript(index: Int) -> TWListNode<T>? {
    return retrieve(atIndex: index)
  }
  
  // MARK: Public Methods
  
  /// Appends a single value to the linked list
  ///
  /// - Parameter val: value to append
  public func appendValue(withValue val: T) {
    appendNode(TWListNode(val))
    counter += 1
  }
  
  
  /// Creates is mini linkedlist based off an array
  /// of values passed in
  ///
  /// - Parameter values: array of values that will be initialized into Nodes
  public func appendValues(values: inout [T]) {
    guard !values.isEmpty else {
      return
    }
    
    var reversed = Array(values.reversed())
    
    while(!reversed.isEmpty) {
      appendValue(withValue: reversed.removeLast())
    }
  }
  
  
  public func contains(_ target: T) -> Bool {
    guard head != nil else {
      return false
    }
    
    var current: TWListNode! = head
    
    while(current != nil) {
      if target == current.value {
        return true
      }
      
      current = current.next
    }
    
    return false
  }
  
  
  public func insert(_ element: T, at index: Int) {
    guard !isEmpty else {
      if index == 0 {
        head = TWListNode(element)
        counter += 1
      }
      return
    }
    
    guard index == 0 || index < count else {
      print("Trying to insert element out of bounds")
      return
    }
    
    guard count > 2 else {
      let newNode = TWListNode(element)
      if index == 0 {
        newNode.next = head
        head = newNode
      } else if index == 1 {
        head!.next = newNode
      }
      counter += 1
      return
    }
    
    let newNode = TWListNode(element)
    
    if index == 0 {
      newNode.next = head
      head = newNode
      counter += 1
      return
    }
    
    var current: TWListNode! = head!.next
    var previous: TWListNode! = head
    var localIndex: Int = 1
    
    while(current != nil) {
      if index == localIndex {
        previous.next = newNode
        newNode.next = current
        counter += 1
        break
      }
      
      previous = current
      current = current.next
      localIndex += 1
    }
  }
  
  
  public func retrieve(atIndex index: Int) -> TWListNode<T>? {
    guard head != nil, index < count else {
      return nil
    }
    
    var current: TWListNode! = head
    var position = 0
    
    while(index != position) {
      position += 1
      current = current.next
    }
    
    return current
  }
  
  
  public func removeNode(atIndex index: Int) {
    guard index >= 0, index < count, count != 0 else {
      return
    }
    
    guard index != 0 else {
      switch count {
      case 1:
        head = nil
      case 2:
        head = head!.next
      default:
        head = nil
      }
      
      counter -= 1
      return
    }
    
    var current: TWListNode<T>! = head
    var previous: TWListNode = current
    var position = 0;
    
    while(position != index) {
      previous = current
      current = current.next!
      position += 1
    }
    
    counter -= 1
    previous.next = current.next
    
  }
  
  // MARK: Private Methods
  
  /// Adds a node to the tail of the linked list. If no toehr
  /// values exist for head and tail, new node is set to these values
  ///
  /// - Parameter val: The node to append the the tail
  private func appendNode(_ val: TWListNode<T>) {
    guard head != nil else {
      head = val
      tail = val
      return
    }
    
    tail!.next = val
    tail = val
  }
  
}

