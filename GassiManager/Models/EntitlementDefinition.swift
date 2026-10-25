import Foundation

enum EntitlementValueKind: String, CaseIterable, Hashable, Identifiable, Sendable {
    case string
    case boolean
    case stringArray

    var id: String { rawValue }

    var label: String {
        switch self {
        case .string: "Testo"
        case .boolean: "Booleano"
        case .stringArray: "Elenco"
        }
    }
}

struct EntitlementDefinition: Identifiable, Hashable, Sendable {
    let key: String
    let title: String
    let category: String
    let symbol: String
    let kind: EntitlementValueKind
    let explanation: String

    var id: String { key }
}

struct EntitlementStatus: Identifiable, Hashable, Sendable {
    let definition: EntitlementDefinition
    let isPresent: Bool
    let renderedValue: String?
    let readError: String?

    var id: String { definition.id }
    var isReadable: Bool { readError == nil }
}

enum EntitlementFilter: String, CaseIterable, Hashable, Identifiable {
    case all = "Tutti"
    case active = "Presenti"
    case absent = "Assenti"
    case errors = "Errori"

    var id: String { rawValue }
}
