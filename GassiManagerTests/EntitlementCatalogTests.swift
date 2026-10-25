import XCTest
@testable import GassiManager

final class EntitlementCatalogTests: XCTestCase {
    func testCatalogContainsUniqueKeys() {
        let keys = EntitlementCatalog.definitions.map(\.key)
        XCTAssertEqual(keys.count, Set(keys).count, "Il catalogo non deve ripetere chiavi.")
    }

    func testEveryDefinitionHasTitleAndExplanation() {
        for definition in EntitlementCatalog.definitions {
            XCTAssertFalse(definition.key.isEmpty)
            XCTAssertFalse(definition.title.isEmpty)
            XCTAssertFalse(definition.explanation.isEmpty)
        }
    }

    func testCatalogIsBroadEnoughToBeUseful() {
        XCTAssertGreaterThanOrEqual(EntitlementCatalog.definitions.count, 50)
    }
}
