//
//  RestClientTests.swift
//  RestClientTests
//
//  Created by Ulaş Sancak on 23.10.2021.
//

import XCTest
@testable import RestClient

class RestClientTests: XCTestCase {
    
    let endpoint = RestEndpoint(urlString: "https://www.google.com", parameters: ["Parameter": "Value"])
    let endpointForJSON = RestEndpoint(urlString: "https://www.google.com", httpMethod: .post, encodingType: .json, parameters: ["Parameter": "Value"])
    let endpointToFail = RestEndpoint(urlString: "notavalidurl")
    let endpointForPost = RestEndpoint(urlString: "https://www.google.com", httpMethod: .post, parameters: ["Parameter": "Value"])
    var endpointForIncorrectJSONParameters: RestEndpoint!
    let endpointForNilJSONParameters = RestEndpoint(urlString: "https://www.google.com", httpMethod: .post, encodingType: .json)


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //Had to find a not valid json parameters. Source: https://stackoverflow.com/a/33584493/1471786
        let bogusStr = String(
            bytes: [0xD8, 0x00] as [UInt8],
            encoding: String.Encoding.utf16BigEndian)!
        
        endpointForIncorrectJSONParameters = RestEndpoint(urlString: "https://www.google.com", httpMethod: .post, encodingType: .json, parameters: ["Parameter": bogusStr])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testURL() throws {
        let url = URL(string: endpoint.urlString)
        XCTAssertNotNil(url, "URL Nil")
        XCTAssertNotNil(url?.host == nil, "URL Not Valid")
    }
    
    func testFailingURL() throws {
        let url = URL(string: endpointToFail.urlString)
        XCTAssert(url == nil || url?.host == nil, "URL Is Valid")
    }
    
    func testCreatingURLComponents() throws {
        let urlComponents = try endpoint.createURLComponents()
        XCTAssertNotNil(urlComponents, "URLComponents Nil")
    }
    
    func testFailingCreatingURLComponents() throws {
        do {
            let urlComponents = try endpointToFail.createURLComponents()
            XCTAssertNil(urlComponents, "URLComponents Should Be Nil")
        } catch let error {
            XCTAssert(true, error.localizedDescription)
        }
    }
    
    func testURLForURLComponents() throws {
        let urlComponents = try endpoint.createURLComponents()
        let url = urlComponents?.url
        XCTAssertNotNil(url, "URL Nil")
        XCTAssertNotNil(url?.host == nil, "URL Not Valid")
    }
    
    func testPercentEncodingQueryForURLComponents() throws {
        let urlComponents = try endpoint.createURLComponents()
        let data = urlComponents?.percentEncodedQuery?.data(using: .utf8)
        XCTAssertNotNil(data, "Data Nil")
    }
    
    func testJSONEncoding() throws {
        let parameters = endpointForJSON.parameters
        XCTAssertNotNil(parameters, "Parameters Nil")
        let data = try JSONSerialization.data(withJSONObject: parameters!, options: [])
        XCTAssertNotNil(data, "Data Nil")
    }

    func testCreatingRequest() throws {
        let request = try endpoint.createRequest()
        XCTAssertNotNil(request, "Request Nil")
    }
    
    func testCreatingPostRequest() throws {
        let request = try endpointForPost.createRequest()
        XCTAssertNotNil(request, "Request Nil")
    }
    
    func testCreatingJSONPostRequest() throws {
        let request = try endpointForJSON.createRequest()
        XCTAssertNotNil(request, "Request Nil")
    }
    
    func testState() throws {
        endpoint.start { _ in }
        XCTAssertTrue(endpoint.state == .running, "Endpoint state should be running.")
    }
    
    func testJSONData() throws {
        do {
            _ = try endpointForIncorrectJSONParameters.createJSONData()
            XCTAssertTrue(false, "Should have failed")
        } catch {
            print("Failed")
        }
    }
    
    func testJSONNil() throws {
        let data = try endpointForNilJSONParameters.createJSONData()
        XCTAssertNil(data, "Data should be nil.")
    }

    func testFailingCreatingRequest() throws {
        do {
            let request = try endpointToFail.createRequest()
            XCTAssertNil(request, "Request Should Be Nil")
        } catch let error {
            XCTAssert(true, error.localizedDescription)
        }
    }

}
