//
//  CategoryTests.swift
//  TestLBCTests
//
//  Created by Jordane HUY on 26/06/2022.
//

import XCTest
@testable import TestLBC

class CategoryTests: XCTestCase {
    let cdStack = CoreDataManager()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cdStack.testing = true
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitCategory() throws {
        let category = Category(id: 1,
                                name: "test name")
        
        XCTAssertEqual(1, category.id)
        XCTAssertEqual("test name", category.name)
    }
    
    func testDecodeCategory() throws {
        let data = "{\"id\":1,\"name\":\"Test name\"}".data(using: .utf8)!
        let decoder = JSONDecoder()
        
        do {
            let category = try decoder.decode(Category.self, from: data)
            
            XCTAssertEqual(1, category.id)
            XCTAssertEqual("Test name", category.name)
        } catch {
            XCTFail("Cannot decode: \(error)")
        }
    }
    
    func testCDCategory() throws {
        let category = Category(id: 1,
                                name: "test name")
        cdStack.createCategory(category: category)
        
        let cdCategory = cdStack.fetchCategory(id: 1)
        
        XCTAssertNotNil(cdCategory, "Report should not be nil")
        XCTAssertTrue(cdCategory?.id == 1)
        XCTAssertTrue(cdCategory?.name == "test name")
    }
    
    func testAPI() {
        HomeWorker().getCategories(completion: { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                XCTFail("Error API: \(error.debugDescription)")
                return
            }
            
            XCTAssertTrue(response.statusCode == 200)
        })
    }
}
