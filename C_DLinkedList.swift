//
//  C_DLinkedList.swift
//  DSA self study CommandLine
//
//  Created by sungwook on 10/29/21.
//
// Copyright (c) 2021 by Sungwook Kim
// This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
// https://creativecommons.org/licenses/by-nc/4.0/
// However, anyone who has donated can use it as OPEN SOURCE with ATTRIBUTION ASSURANCE LICENSE.

///
/// #The Objective of this work
/// **LinkedList** is a simple data structure which can be found easily here and there.
/// But I've found that the introduction of `sentinel` to LinkedList may simplfy the implementation of LinkedList class even if it is not faster.
/// And the implementaiton in value type would be another alternative: I love **value type** as well.
/// However, I prefer a clearer, simpler, manageable implementation in Swift5 that is my point.
///
/// Oct 29, 2021
/// Thanks, by Sungwook Kim
///

/// Some related exercise for singly linked list is here:
/// https://leetcode.com/problems/add-two-numbers/discuss/1632426/in-Swift-5.5-clearer-faster-and-more-understandable-code
/// This is my implementation, experience of the problem on LeetCode.com
///  and I found that most coding competition sites do **NOT** treat elegantly Swift language so far.

import Foundation

public class C_DLinkedList<Key: Equatable & Comparable> {
    /// ** CAVEAT **
    ///```
    /// static let sentinel: C_DLinkedList<Key>
    ///```
    /// `static let` is not possible due to the following
    /// Static stored properties not supported in generic types
    var k: Key?
    var next: C_DLinkedList<Key>?
    var prev: C_DLinkedList<Key>?
}

/// sentinel if k == nil, next == self, prev == self
public func make_a_sentinel<Key: Equatable & Comparable>(the_type: Key.Type) -> C_DLinkedList<Key> {
    let the_setinel = C_DLinkedList<Key>()
    the_setinel.next = the_setinel
    the_setinel.prev = the_setinel
    return the_setinel
}

/// ** CAVEAT **
/// add any key to the head.
public func insert<Key: Equatable & Comparable>(sentinel: C_DLinkedList<Key>, key: Key) {
    let x = C_DLinkedList<Key>()
    x.k = key
    x.next = sentinel.next
    sentinel.next?.prev = x
    sentinel.next = x
    
    /// This should come the last.
    x.prev = sentinel
}

/// if not found, returns `the sentinel`, otherwise it will be removed from the linked list and then be returned by this function.
public func popElement<Key: Equatable & Comparable>(sentinel: C_DLinkedList<Key>, key: Key) -> C_DLinkedList<Key> {
    let find = search(sentinel: sentinel, key: key)
    if find !== sentinel {
        find.prev?.next = find.next
        find.next?.prev = find.prev
        find.next = nil; find.prev = nil
    }
    return find
}

/// if not found, returns `the sentinel`, otherwise it return the element.
public func search<Key: Equatable & Comparable>(sentinel: C_DLinkedList<Key>, key: Key) -> C_DLinkedList<Key> {
    var next = sentinel.next
    while next !== sentinel, next!.k != key {
        next = next!.next!
    }
    return next!
}

public func print_the_list<Key: Equatable & Comparable>(sentinel: C_DLinkedList<Key>) {
    var next = sentinel.next
    while next !== sentinel {
        print("\(next!.k!) ", terminator: "")
        next = next!.next!
    }
    print("")
}


func testings__of__C_DLinkedList() {
    let array = [4,3,2,1]
    let the_sentinel = make_a_sentinel(the_type: Int.self)
    array.forEach {
        insert(sentinel: the_sentinel, key: $0)
    }
    let message = { (result:C_DLinkedList<Int>, key:Int) in
        result === the_sentinel ? "The key \(key) is NOT found":"The key \(key) is found"
    }
    print(message(search(sentinel: the_sentinel, key: 2), 2))
    print(message(search(sentinel: the_sentinel, key: 222), 222))
    
    print("Before popElement")
    print_the_list(sentinel: the_sentinel)
    var popped_2: C_DLinkedList<Int>? = popElement(sentinel: the_sentinel, key: 2)
    print("After popElement")
    print_the_list(sentinel: the_sentinel)
    assert(popped_2!.k! == 2)
    print(popped_2!.k! == 2) /// this is true.

    /// it is removed from memory
    popped_2 = nil
    print_the_list(sentinel: the_sentinel)
    assert(popped_2?.k == nil)
    print(popped_2?.k == nil) /// this is true.
}
