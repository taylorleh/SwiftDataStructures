//
//  DataStructuresTests.swift
//  DataStructuresTests
//
//  Created by Taylor Lehman on 3/16/18.
//  Copyright © 2018 Taylor Lehman. All rights reserved.
//

import XCTest
@testable import DataStructures

class DataStructuresTests: XCTestCase {
    
  var intListValues: Array<Int>!
  
  override func setUp() {
    super.setUp()
    intListValues = [2,4,6,8,10]
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  
  func testAddToTail() {
    let list = TWLinkedList<Int>()
    list.appendValue(withValue: 1)
    list.appendValue(withValue: 2)
    list.appendValue(withValue: 3)
    XCTAssertEqual(list.head!.value, 1)
    XCTAssertEqual(list.head!.next!.value, 2)
    XCTAssertEqual(list.head!.next!.next!.value, 3)
  }
  
  
  
  func testAppendValues() {
    let sut = TWLinkedList<Int>()
    sut.appendValues(values: &intListValues!)
    
    XCTAssertEqual(sut.head!.value, 2)
    XCTAssertEqual(sut.head!.next!.value, 4)
    XCTAssertEqual(sut.head!.next!.next!.value, 6)
    XCTAssertEqual(sut.head!.next!.next!.next!.value, 8)
    XCTAssertEqual(sut.head!.next!.next!.next!.next!.value, 10)
  }
  
  func testInsertOnEmpty() {
    let sut = TWLinkedList<Int>()
    sut.insert(10, at: 0)
    XCTAssertEqual(sut.count, 1)
    XCTAssertEqual(sut.head?.value, 10)
  }
  
  func testInsertInFrontOnBuilt() {
    let sut = generateLinkedList(values: &intListValues!)
    
    sut.insert(1, at: 0)
    XCTAssertEqual(sut.head!.value, 1)
    XCTAssertEqual(sut.head!.next!.value, 2)
    XCTAssertEqual(sut.count, 6)
  }
  
  func testInsertInMiddle() {
    let list = generateLinkedList(values: &intListValues!)
    let newValue = (
      index: arc4random_uniform(UInt32(list.count)),
      value: 100
    )
    
    
    list.insert(newValue.value, at: Int(newValue.index))
    XCTAssertEqual(list.count, 6)
    
    if let result = list[Int(newValue.index)] {
      XCTAssertEqual(result.value, newValue.value)
    } else {
      XCTFail("Could not retrieve node at index \(Int(newValue.index))")
    }
  }
  
  func testContains() {
    let list = generateLinkedList(values: &intListValues!)
    
    assert(list.contains(2), "Found target in LinkedList")
    assert(list.contains(4), "Found target in LinkedList")
    assert(list.contains(6), "Found target in LinkedList")
    assert(list.contains(8), "Found target in LinkedList")
    assert(list.contains(10), "Found target in LinkedList")
  }
  
  func testRemoveNode() {
    let sut = generateLinkedList(values: &intListValues!)
    
    let removingIndex = arc4random_uniform(UInt32(sut.count))
    let removeValue = sut[Int(removingIndex)]
    
    sut.removeNode(atIndex: Int(removingIndex))
    
    XCTAssertEqual(sut.count, 4)
    
    if let x = removeValue?.value {
      XCTAssertFalse(sut.contains(x))
    } else {
      XCTFail("Randomly generated remove value could not be accessed")
    }
    
  }
  
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}

func generateLinkedList(values: inout Array<Int>) -> TWLinkedList<Int> {
  let list = TWLinkedList<Int>()
  list.appendValues(values: &values)
  return list
}

