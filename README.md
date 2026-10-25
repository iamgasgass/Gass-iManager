# GassiManager

App iOS nativa SwiftUI con interfaccia **Liquid Glass** (iOS 26+), scanner di entitlement della firma e build CI via GitHub Actions. Il progetto Xcode viene generato da `project.yml` con XcodeGen.

## Funzionalità

- Legge a runtime i valori firmati dell'app per un catalogo esteso di chiavi entitlement conosciute.
- Distingue **Presente**, **Assente** ed **Errore di lettura**: un errore non viene riportato come entitlement assente.
- Filtra per stato e ricerca per chiave, servizio o categoria.
- Mostra o nasconde i valori firmati, con selezione e copia del testo.
- UI costruita con SwiftUI nativo e gli API Liquid Glass di iOS 26: `glassEffect`, `GlassEffectContainer` e stili di sistema.
- Scansione locale: nessun backend, analytics o telemetria.
- Test automatici di coerenza del catalogo e workflow GitHub Actions per la build Simulator.

## Requisiti

- macOS con Xcode 26 o superiore.
- iOS 26+ per eseguire l'app con Liquid Glass nativo.
- [XcodeGen](https://github.com/yonaskolb/XcodeGen): `brew install xcodegen`.

## Generare e aprire il progetto

```bash
brew install xcodegen
./Scripts/generate-project.sh
open GassiManager.xcodeproj
```

Poi seleziona un iPhone con iOS 26 o successivo e premi **Run**. Per una build locale da terminale:

```bash
xcodebuild -resolvePackageDependencies -project GassiManager.xcodeproj -scheme GassiManager
xcodebuild build -project GassiManager.xcodeproj -scheme GassiManager \
  -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO
```

La dipendenza `AppEntitlements` (`wiedem/app-entitlements`) usa Swift Package Manager e analizza la firma Mach-O a runtime senza API private. La prima risoluzione dei pacchetti richiede rete.

## GitHub Actions

Il workflow `.github/workflows/build.yml` esegue checkout, selezione Xcode, generazione del progetto, risoluzione delle dipendenze e build per iOS Simulator ad ogni push e pull request.

## Come vengono letti gli entitlement

Apple codifica gli entitlement nella firma del codice; Xcode combina il file `.entitlements`, le capacità dell'App ID e i dati di provisioning quando firma il prodotto. L'app usa `AppEntitlements` per leggere i valori delle chiavi elencate in `GassiManager/Services/EntitlementCatalog.swift`.

**Limite iOS:** Apple non fornisce alle app iOS un'API pubblica per enumerare ogni chiave di entitlement immaginabile. Per questo il progetto ha un catalogo esplicito e ampliabile di chiavi note. Se utilizzi un entitlement proprietario o introdotto da una nuova versione di sistema, aggiungi la chiave al catalogo con il tipo corretto (`string`, `boolean` o `stringArray`). Una chiave che non è nel catalogo non può essere dichiarata assente solo perché non compare nella schermata.

La schermata misura la presenza del valore nella firma dell'eseguibile corrente, non l'esito di tutte le API collegate: un entitlement presente non implica che il servizio sia configurato lato Apple, che il dispositivo lo supporti o che l'utente abbia concesso i relativi permessi.

## Firma e distribuzione

`GassiManager/GassiManager.entitlements` è volutamente vuoto: il progetto non presume che tu possieda capability come APNs, iCloud o App Groups. Abilita le capacità necessarie in Xcode/Apple Developer e firma con il tuo Team ID. Il workflow CI verifica la compilazione senza certificati di distribuzione; non produce una build App Store firmata.

## Struttura

```text
GassiManager/
├── .github/workflows/build.yml
├── GassiManager/
│   ├── ContentView.swift
│   ├── GassiManagerApp.swift
│   ├── GassiManager.entitlements
│   ├── Models/EntitlementDefinition.swift
│   ├── Services/EntitlementCatalog.swift
│   ├── Services/EntitlementScanner.swift
│   └── Views/{AboutView,EntitlementRow}.swift
├── GassiManagerTests/EntitlementCatalogTests.swift
├── Scripts/generate-project.sh
├── project.yml
└── README.md
```

## Licenza

MIT. Vedi [`LICENSE`](LICENSE). La dipendenza `AppEntitlements` mantiene la propria licenza MIT e resta attribuita al relativo autore.
