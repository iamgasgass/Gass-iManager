import Foundation

/// Catalogo esplicito delle chiavi note da controllare a runtime.
/// iOS non offre una API pubblica per enumerare ogni possibile chiave sconosciuta:
/// aggiungere qui nuove chiavi permette di leggerle dalla firma dell'app.
enum EntitlementCatalog {
    static let definitions: [EntitlementDefinition] = [
        .init(key: "application-identifier", title: "Identificatore applicazione", category: "Firma", symbol: "app.badge", kind: .string, explanation: "Identificatore firmato dell'app, normalmente Team ID + Bundle ID."),
        .init(key: "com.apple.developer.team-identifier", title: "Team Developer", category: "Firma", symbol: "person.text.rectangle", kind: .string, explanation: "Identificatore del team Apple Developer associato alla firma."),
        .init(key: "get-task-allow", title: "Debug consentito", category: "Firma", symbol: "ladybug", kind: .boolean, explanation: "Quando true, il processo può essere collegato da strumenti di debug secondo il profilo di firma."),
        .init(key: "keychain-access-groups", title: "Gruppi di accesso Portachiavi", category: "Firma", symbol: "key.horizontal", kind: .stringArray, explanation: "Gruppi che delimitano gli elementi di Keychain accessibili all'app."),
        .init(key: "com.apple.developer.default-data-protection", title: "Protezione dati predefinita", category: "Firma", symbol: "lock.shield", kind: .string, explanation: "Classe di protezione dati dichiarata nella firma."),

        .init(key: "aps-environment", title: "Apple Push Notification service", category: "Notifiche", symbol: "bell.badge", kind: .string, explanation: "Ambiente APNs firmato, ad esempio development o production."),
        .init(key: "com.apple.developer.usernotifications.critical-alerts", title: "Avvisi critici", category: "Notifiche", symbol: "bell.and.waves.left.and.right", kind: .boolean, explanation: "Permette l'uso delle notifiche critiche, soggette ad autorizzazione Apple."),
        .init(key: "com.apple.developer.usernotifications.time-sensitive", title: "Notifiche time-sensitive", category: "Notifiche", symbol: "clock.badge", kind: .boolean, explanation: "Dichiara il supporto alle notifiche sensibili al tempo."),
        .init(key: "com.apple.developer.usernotifications.communication", title: "Notifiche di comunicazione", category: "Notifiche", symbol: "message.badge", kind: .boolean, explanation: "Dichiara le funzionalità speciali per notifiche di comunicazione."),
        .init(key: "com.apple.developer.usernotifications.filtering", title: "Filtro notifiche", category: "Notifiche", symbol: "line.3.horizontal.decrease.circle", kind: .boolean, explanation: "Dichiara la capacità di filtraggio delle notifiche supportata dal sistema."),

        .init(key: "com.apple.developer.associated-domains", title: "Associated Domains", category: "Web e identità", symbol: "link", kind: .stringArray, explanation: "Domini associati per Universal Links, Shared Web Credentials e servizi correlati."),
        .init(key: "com.apple.developer.applesignin", title: "Sign in with Apple", category: "Web e identità", symbol: "person.crop.circle.badge.checkmark", kind: .stringArray, explanation: "Configurazione dei servizi Sign in with Apple ammessi."),
        .init(key: "com.apple.developer.authentication-services.autofill-credential-provider", title: "Credential Provider", category: "Web e identità", symbol: "person.crop.rectangle.stack", kind: .boolean, explanation: "Accesso alle API per provider di credenziali e AutoFill."),

        .init(key: "com.apple.security.application-groups", title: "App Groups", category: "Condivisione", symbol: "person.2", kind: .stringArray, explanation: "Contenitori condivisi consentiti tra app ed estensioni dello stesso gruppo."),
        .init(key: "com.apple.developer.icloud-container-identifiers", title: "Container iCloud", category: "iCloud", symbol: "icloud", kind: .stringArray, explanation: "Identificatori dei container iCloud dichiarati nella firma."),
        .init(key: "com.apple.developer.icloud-container-development-container-identifiers", title: "Container iCloud di sviluppo", category: "iCloud", symbol: "icloud.and.arrow.down", kind: .stringArray, explanation: "Container iCloud dedicati allo sviluppo, se inclusi nella firma."),
        .init(key: "com.apple.developer.icloud-services", title: "Servizi iCloud", category: "iCloud", symbol: "cloud", kind: .stringArray, explanation: "Servizi iCloud abilitati, ad esempio CloudKit o documenti."),
        .init(key: "com.apple.developer.ubiquity-container-identifiers", title: "Container ubiquity", category: "iCloud", symbol: "externaldrive.icloud", kind: .stringArray, explanation: "Container utilizzabili per documenti ubiqui."),
        .init(key: "com.apple.developer.ubiquity-kvstore-identifier", title: "iCloud Key-Value Store", category: "iCloud", symbol: "externaldrive", kind: .string, explanation: "Identificatore del database ubiquity key-value."),
        .init(key: "com.apple.developer.icloud-container-environment", title: "Ambiente iCloud", category: "iCloud", symbol: "cloud.sun", kind: .string, explanation: "Ambiente iCloud associato alla firma, se presente."),

        .init(key: "com.apple.developer.healthkit", title: "HealthKit", category: "Salute e sensori", symbol: "heart.text.square", kind: .boolean, explanation: "Autorizza l'accesso alle API HealthKit; i dati richiedono comunque il consenso dell'utente."),
        .init(key: "com.apple.developer.healthkit.background-delivery", title: "HealthKit background delivery", category: "Salute e sensori", symbol: "heart.circle", kind: .boolean, explanation: "Permette l'uso di aggiornamenti HealthKit in background, quando supportati."),
        .init(key: "com.apple.developer.homekit", title: "HomeKit", category: "Casa e automazione", symbol: "house", kind: .boolean, explanation: "Dichiara la capability HomeKit; l'accesso ai dati richiede consenso."),
        .init(key: "com.apple.developer.siri", title: "Siri", category: "Casa e automazione", symbol: "waveform", kind: .boolean, explanation: "Dichiara l'integrazione con SiriKit, quando supportata."),
        .init(key: "com.apple.developer.arkit.main-camera-access.allow", title: "ARKit: accesso camera principale", category: "Salute e sensori", symbol: "camera.aperture", kind: .boolean, explanation: "Entitlement per scenari specifici di accesso camera ARKit."),

        .init(key: "com.apple.developer.networking.wifi-info", title: "Informazioni Wi-Fi", category: "Rete", symbol: "wifi", kind: .boolean, explanation: "Consente l'accesso a determinate informazioni sulla rete Wi-Fi, con ulteriori requisiti di sistema."),
        .init(key: "com.apple.developer.networking.multicast", title: "Multicast networking", category: "Rete", symbol: "dot.radiowaves.left.and.right", kind: .boolean, explanation: "Dichiara la capacità di rete multicast."),
        .init(key: "com.apple.developer.networking.HotspotConfiguration", title: "Hotspot Configuration", category: "Rete", symbol: "wifi.router", kind: .boolean, explanation: "Accesso alle API per configurare reti Wi-Fi compatibili."),
        .init(key: "com.apple.developer.networking.networkextension", title: "Network Extension", category: "Rete", symbol: "network", kind: .stringArray, explanation: "Tipi di Network Extension autorizzati per l'app."),
        .init(key: "com.apple.developer.networking.HotspotHelper", title: "Hotspot Helper", category: "Rete", symbol: "antenna.radiowaves.left.and.right", kind: .boolean, explanation: "Capacità Hotspot Helper, soggetta a entitlement e autorizzazioni Apple."),
        .init(key: "com.apple.developer.networking.multipath", title: "Multipath networking", category: "Rete", symbol: "arrow.triangle.branch", kind: .boolean, explanation: "Dichiara l'accesso alle funzionalità Multipath TCP dove autorizzate."),
        .init(key: "com.apple.developer.networking.manage-thread-network-credentials", title: "Credenziali Thread", category: "Rete", symbol: "dot.radiowaves.up.forward", kind: .boolean, explanation: "Dichiara l'accesso a specifiche API di gestione delle credenziali Thread."),

        .init(key: "com.apple.developer.in-app-payments", title: "Apple Pay", category: "Pagamenti e Wallet", symbol: "creditcard", kind: .stringArray, explanation: "Merchant ID Apple Pay associati alla firma."),
        .init(key: "com.apple.developer.pass-type-identifiers", title: "Pass Type IDs", category: "Pagamenti e Wallet", symbol: "wallet.pass", kind: .stringArray, explanation: "Identificatori dei pass Wallet consentiti."),
        .init(key: "com.apple.developer.payment-pass-provisioning", title: "Payment Pass Provisioning", category: "Pagamenti e Wallet", symbol: "creditcard.and.123", kind: .boolean, explanation: "Entitlement per specifici flussi di provisioning di payment pass."),
        .init(key: "com.apple.developer.nfc.readersession.formats", title: "NFC Reader Session", category: "Pagamenti e Wallet", symbol: "wave.3.right", kind: .stringArray, explanation: "Formati NFC consentiti, se dichiarati."),
        .init(key: "com.apple.developer.carkey", title: "Car Key", category: "Pagamenti e Wallet", symbol: "car.side", kind: .boolean, explanation: "Entitlement per integrazioni Car Key supportate."),

        .init(key: "com.apple.developer.devicecheck.appattest-environment", title: "App Attest environment", category: "Sicurezza", symbol: "checkmark.shield", kind: .string, explanation: "Ambiente App Attest dichiarato nella firma."),
        .init(key: "com.apple.developer.devicecheck.appattest-key", title: "App Attest key", category: "Sicurezza", symbol: "key.viewfinder", kind: .boolean, explanation: "Entitlement associato a specifiche funzionalità App Attest."),
        .init(key: "com.apple.developer.user-management", title: "User Management", category: "Sicurezza", symbol: "person.badge.key", kind: .boolean, explanation: "Entitlement per funzionalità di gestione utenti supportate."),
        .init(key: "com.apple.developer.device-information.user-assigned-device-name", title: "Nome dispositivo assegnato", category: "Sicurezza", symbol: "iphone.gen3", kind: .boolean, explanation: "Accesso al nome dispositivo assegnato dall'utente, nei casi autorizzati."),
        .init(key: "com.apple.developer.managed-app-distribution", title: "Managed App Distribution", category: "Distribuzione", symbol: "building.2", kind: .boolean, explanation: "Entitlement per scenari gestiti di distribuzione app."),
        .init(key: "com.apple.developer.enterprise-application", title: "Enterprise application", category: "Distribuzione", symbol: "building.2.crop.circle", kind: .boolean, explanation: "Entitlement legato a specifici contesti di distribuzione enterprise."),

        .init(key: "com.apple.developer.game-center", title: "Game Center", category: "Media e giochi", symbol: "gamecontroller", kind: .boolean, explanation: "Dichiara funzionalità Game Center quando previste dalla firma."),
        .init(key: "com.apple.developer.maps", title: "MapKit / Maps", category: "Media e giochi", symbol: "map", kind: .boolean, explanation: "Entitlement per funzionalità Maps specifiche quando richiesto."),
        .init(key: "com.apple.developer.weatherkit", title: "WeatherKit", category: "Media e giochi", symbol: "cloud.sun.rain", kind: .boolean, explanation: "Dichiara l'uso di WeatherKit dove applicabile."),
        .init(key: "com.apple.developer.group-session", title: "Group Activities", category: "Media e giochi", symbol: "person.3", kind: .boolean, explanation: "Entitlement associato alle attività di gruppo supportate."),
        .init(key: "com.apple.developer.shared-with-you", title: "Shared with You", category: "Media e giochi", symbol: "square.and.arrow.up", kind: .boolean, explanation: "Entitlement per integrazioni SharePlay/Shared with You supportate."),

        .init(key: "com.apple.developer.driverkit", title: "DriverKit", category: "Entitlement speciali", symbol: "cpu", kind: .boolean, explanation: "Entitlement speciale non normalmente disponibile alle comuni app iOS."),
        .init(key: "com.apple.developer.endpoint-security.client", title: "Endpoint Security", category: "Entitlement speciali", symbol: "shield.lefthalf.filled", kind: .boolean, explanation: "Entitlement privilegiato per piattaforme e casi d'uso specifici."),
        .init(key: "com.apple.developer.system-extension.install", title: "System Extension install", category: "Entitlement speciali", symbol: "puzzlepiece.extension", kind: .boolean, explanation: "Entitlement specifico per piattaforme e casi d'uso non comuni su iOS."),
        .init(key: "com.apple.developer.kernel.extended-virtual-addressing", title: "Extended virtual addressing", category: "Entitlement speciali", symbol: "memorychip", kind: .boolean, explanation: "Entitlement a disponibilità limitata per scenari specifici."),
        .init(key: "com.apple.developer.on-demand-install-capable", title: "On-demand install", category: "Distribuzione", symbol: "arrow.down.app", kind: .boolean, explanation: "Entitlement per scenari specifici di installazione on-demand."),
        .init(key: "com.apple.developer.developer-mode", title: "Developer Mode", category: "Firma", symbol: "hammer", kind: .boolean, explanation: "Entitlement associato a funzionalità di developer mode specifiche."),

        .init(key: "com.apple.developer.proximity-reader.payment.acceptance", title: "Proximity Reader", category: "Pagamenti e Wallet", symbol: "wave.3.right.circle", kind: .boolean, explanation: "Entitlement soggetto a requisiti e approvazioni specifiche."),
        .init(key: "com.apple.developer.push-to-talk", title: "Push to Talk", category: "Notifiche", symbol: "mic.badge.plus", kind: .boolean, explanation: "Entitlement per la capability Push to Talk supportata dal sistema."),
        .init(key: "com.apple.developer.contacts.notes", title: "Note dei contatti", category: "Dati personali", symbol: "person.crop.square", kind: .boolean, explanation: "Entitlement specifico per l'accesso a campi note dei contatti."),
        .init(key: "com.apple.developer.photos-library", title: "Photos Library", category: "Dati personali", symbol: "photo.on.rectangle", kind: .boolean, explanation: "Entitlement per funzionalità specifiche della libreria foto."),
        .init(key: "com.apple.developer.accessibility", title: "Accessibility", category: "Accessibilità", symbol: "accessibility", kind: .boolean, explanation: "Entitlement speciali relativi alle funzioni di accessibilità, quando concessi."),
        .init(key: "com.apple.developer.app-compute", title: "App Compute", category: "Entitlement speciali", symbol: "cpu.fill", kind: .boolean, explanation: "Entitlement specialistico disponibile solo in contesti supportati."),
        .init(key: "com.apple.developer.in-app-purchase", title: "In-App Purchase", category: "Pagamenti e Wallet", symbol: "cart", kind: .boolean, explanation: "Dichiara entitlement correlati agli acquisti in-app quando presenti."),
        .init(key: "com.apple.developer.storekit.external-purchase", title: "External Purchase", category: "Pagamenti e Wallet", symbol: "cart.badge.plus", kind: .boolean, explanation: "Entitlement StoreKit soggetto a requisiti regionali e approvazioni Apple."),
        .init(key: "com.apple.developer.storekit.external-link.account", title: "External Link Account", category: "Pagamenti e Wallet", symbol: "arrow.up.right.square", kind: .boolean, explanation: "Entitlement StoreKit soggetto a requisiti regionali e approvazioni Apple."),
        .init(key: "com.apple.developer.storekit.external-purchase-link", title: "External Purchase Link", category: "Pagamenti e Wallet", symbol: "link.circle", kind: .boolean, explanation: "Entitlement StoreKit soggetto a requisiti regionali e approvazioni Apple."),
        .init(key: "com.apple.developer.carplay-audio", title: "CarPlay Audio", category: "Automotive", symbol: "car.side.rear.open.filled", kind: .boolean, explanation: "Entitlement riservato a specifiche categorie CarPlay."),
        .init(key: "com.apple.developer.carplay-communication", title: "CarPlay Communication", category: "Automotive", symbol: "car.side", kind: .boolean, explanation: "Entitlement riservato a specifiche categorie CarPlay."),
        .init(key: "com.apple.developer.carplay-messaging", title: "CarPlay Messaging", category: "Automotive", symbol: "message", kind: .boolean, explanation: "Entitlement riservato a specifiche categorie CarPlay."),
        .init(key: "com.apple.developer.carplay-navigation", title: "CarPlay Navigation", category: "Automotive", symbol: "arrow.triangle.turn.up.right.diamond", kind: .boolean, explanation: "Entitlement riservato a specifiche categorie CarPlay."),
        .init(key: "com.apple.developer.device-information.user-device-name", title: "Device Name", category: "Sicurezza", symbol: "iphone", kind: .boolean, explanation: "Accesso al nome dispositivo quando previsto dalla firma e dal sistema."),
    ]
}
