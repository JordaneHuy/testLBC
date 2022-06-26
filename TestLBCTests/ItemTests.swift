//
//  ItemTests.swift
//  TestLBCTests
//
//  Created by Jordane HUY on 25/06/2022.
//

import XCTest
@testable import TestLBC

class ItemTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitItem() throws {
        let date = Date()
        let itemImage = ItemImage(small: "test url1",
                                  thumb: "test url2")
        let item = Item(id: 1,
                        categoryId: 1,
                        title: "Test title",
                        description: "Test description",
                        price: 10.0,
                        creationDate: date,
                        images: itemImage,
                        isUrgent: false)
        
        XCTAssertEqual("test url1", itemImage.small)
        XCTAssertEqual("test url2", itemImage.thumb)
        
        XCTAssertEqual(1, item.id)
        XCTAssertEqual(1, item.categoryId)
        XCTAssertEqual("Test title", item.title)
        XCTAssertEqual("Test description", item.description)
        XCTAssertEqual(10.0, item.price)
        XCTAssertEqual(date, item.creationDate)
        XCTAssertEqual(false, item.isUrgent)
    }
    
    func testDecodeItem() throws {
        let date = Date().ISO8601Format()
        let data = "{\"id\":1,\"category_id\":1,\"title\":\"Test title\",\"description\":\"Test description\",\"price\":10.0,\"creation_date\":\"\(date.description)\",\"is_urgent\":false,\"images_url\":{\"small\":\"test url1\",\"thumb\":\"test url2\"}}".data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let item = try decoder.decode(Item.self, from: data)
            let itemImage = item.images
            
            
            XCTAssertEqual("test url1", itemImage.small)
            XCTAssertEqual("test url2", itemImage.thumb)
            
            XCTAssertEqual(1, item.id)
            XCTAssertEqual(1, item.categoryId)
            XCTAssertEqual("Test title", item.title)
            XCTAssertEqual("Test description", item.description)
            XCTAssertEqual(10.0, item.price)
            XCTAssertEqual(item.creationDate.description, item.creationDate.description)
            XCTAssertEqual(false, item.isUrgent)
        } catch {
            XCTFail("Cannot decode: \(error)")
        }
    }
    
    func testAPI() {
        HomeWorker().getListing(completion: { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                XCTFail("Error API: \(error.debugDescription)")
                return
            }
            
            XCTAssertTrue(response.statusCode == 200)
        })
    }
}
