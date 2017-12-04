//
//  TasksViewModelTests.swift
//  ListifyTests
//
//  Created by Khoi Lai on 12/4/17.
//  Copyright © 2017 khoi.io. All rights reserved.
//

import XCTest
import RxSwift
@testable import Listify

class TasksViewModelTests: XCTestCase {
    
    var subject = ListsViewModel(taskService: TaskServiceMock(), coordinator: CoordinatorMock())
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testCreate() {
        Observable.just("Somelist").bind(to: subject.onCreateList.inputs).disposed(by: disposeBag)
        
        // ASSERT Section Items
//        subject.sectionItems.asObservable().blockIng { (sections) in
//            XCTAssert(sections.first.name == "SomeList")
//        }.disposed(by: DisposeBag)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
