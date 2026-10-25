import Foundation
import AppEntitlements

struct EntitlementScanner {
    static func scan(definitions: [EntitlementDefinition] = EntitlementCatalog.definitions) -> [EntitlementStatus] {
        definitions.map { definition in
            do {
                switch definition.kind {
                case .string:
                    let value: String? = try AppEntitlements.getValue(for: definition.key)
                    return EntitlementStatus(
                        definition: definition,
                        isPresent: value != nil,
                        renderedValue: value,
                        readError: nil
                    )
                case .boolean:
                    let value: Bool? = try AppEntitlements.getValue(for: definition.key)
                    return EntitlementStatus(
                        definition: definition,
                        isPresent: value != nil,
                        renderedValue: value.map { $0 ? "true" : "false" },
                        readError: nil
                    )
                case .stringArray:
                    let value: [String]? = try AppEntitlements.getArray(for: definition.key)
                    return EntitlementStatus(
                        definition: definition,
                        isPresent: value != nil,
                        renderedValue: value?.joined(separator: ", "),
                        readError: nil
                    )
                }
            } catch {
                return EntitlementStatus(
                    definition: definition,
                    isPresent: false,
                    renderedValue: nil,
                    readError: error.localizedDescription
                )
            }
        }
    }
}
