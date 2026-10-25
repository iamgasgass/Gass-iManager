import SwiftUI

struct ContentView: View {
    @State private var statuses: [EntitlementStatus] = []
    @State private var selectedFilter: EntitlementFilter = .all
    @State private var searchText = ""
    @State private var showValues = false
    @State private var isScanning = false
    @State private var lastScan = Date()
    @State private var showAbout = false

    private var presentCount: Int { statuses.filter { $0.isReadable && $0.isPresent }.count }
    private var absentCount: Int { statuses.filter { $0.isReadable && !$0.isPresent }.count }
    private var errorCount: Int { statuses.filter { !$0.isReadable }.count }

    private var filteredStatuses: [EntitlementStatus] {
        statuses.filter { status in
            let filterMatches: Bool
            switch selectedFilter {
            case .all: filterMatches = true
            case .active: filterMatches = status.isReadable && status.isPresent
            case .absent: filterMatches = status.isReadable && !status.isPresent
            case .errors: filterMatches = !status.isReadable
            }
            let queryMatches = searchText.isEmpty
                || status.definition.key.localizedCaseInsensitiveContains(searchText)
                || status.definition.title.localizedCaseInsensitiveContains(searchText)
                || status.definition.category.localizedCaseInsensitiveContains(searchText)
            return filterMatches && queryMatches
        }
    }

    private var groupedStatuses: [(key: String, values: [EntitlementStatus])] {
        let groups = Dictionary(grouping: filteredStatuses, by: { $0.definition.category })
        return groups.keys.sorted().map { key in
            (key: key, values: (groups[key] ?? []).sorted { $0.definition.title.localizedStandardCompare($1.definition.title) == .orderedAscending })
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                background

                ScrollView {
                    VStack(alignment: .leading, spacing: 22) {
                        header
                        summaryCard
                        controls

                        if filteredStatuses.isEmpty {
                            emptyState
                        } else {
                            ForEach(groupedStatuses, id: \.key) { group in
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack(spacing: 8) {
                                        Text(group.key.uppercased())
                                            .font(.system(size: 11, weight: .bold, design: .rounded))
                                            .tracking(1.6)
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                        Text("\(group.values.count)")
                                            .font(.caption.monospacedDigit().weight(.semibold))
                                            .foregroundStyle(.tertiary)
                                    }
                                    .padding(.horizontal, 4)

                                    GlassEffectContainer(spacing: 14) {
                                        LazyVStack(spacing: 12) {
                                            ForEach(group.values) { status in
                                                EntitlementRow(status: status, showValues: showValues)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        footer
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 12)
                    .padding(.bottom, 32)
                }
                .scrollIndicators(.hidden)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAbout = true
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.title3)
                    }
                    .buttonStyle(.glass)
                    .accessibilityLabel("Informazioni sul rilevamento")
                }
            }
            .searchable(text: $searchText, prompt: "Cerca chiave, servizio o categoria")
            .sheet(isPresented: $showAbout) {
                AboutView()
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
            .task {
                if statuses.isEmpty { scan() }
            }
            .refreshable { scan() }
        }
        .tint(.mint)
    }

    private var background: some View {
        ZStack {
            Color(uiColor: .systemBackground)
            LinearGradient(
                colors: [Color.cyan.opacity(0.16), .clear, Color.indigo.opacity(0.18)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Circle()
                .fill(Color.cyan.opacity(0.10))
                .frame(width: 300, height: 300)
                .blur(radius: 90)
                .offset(x: 150, y: -320)
            Circle()
                .fill(Color.purple.opacity(0.10))
                .frame(width: 280, height: 280)
                .blur(radius: 95)
                .offset(x: -160, y: 340)
        }
        .ignoresSafeArea()
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 9) {
            HStack(spacing: 8) {
                Image(systemName: "shield.lefthalf.filled")
                    .foregroundStyle(.mint)
                Text("SIGNING DIAGNOSTICS")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .tracking(2.0)
                    .foregroundStyle(.secondary)
                Spacer()
                HStack(spacing: 5) {
                    Circle().fill(.mint).frame(width: 6, height: 6)
                    Text("LOCALE")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .tracking(0.8)
                }
                .foregroundStyle(.mint)
                .padding(.horizontal, 9)
                .padding(.vertical, 6)
                .background(.mint.opacity(0.1), in: Capsule())
            }

            Text("GassiManager")
                .font(.system(size: 35, weight: .bold, design: .rounded))
                .tracking(-1.5)

            Text("Tutti i permessi firmati, sotto controllo.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 8)
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: 17) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("ENTITLEMENT SCANNER")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .tracking(1.6)
                        .foregroundStyle(.secondary)
                    Text("\(presentCount)")
                        .font(.system(size: 49, weight: .semibold, design: .rounded))
                        .contentTransition(.numericText())
                    Text("chiavi presenti nella firma")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "checkmark.shield.fill")
                    .font(.system(size: 35, weight: .medium))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.mint, .mint.opacity(0.2))
                    .padding(14)
                    .background(.mint.opacity(0.1), in: RoundedRectangle(cornerRadius: 19, style: .continuous))
            }

            Rectangle()
                .fill(.white.opacity(0.12))
                .frame(height: 1)

            HStack(spacing: 0) {
                metric(value: "\(statuses.count)", label: "Controllate", color: .primary)
                Spacer(minLength: 8)
                metric(value: "\(absentCount)", label: "Assenti", color: .secondary)
                Spacer(minLength: 8)
                metric(value: "\(errorCount)", label: "Errori", color: errorCount == 0 ? .secondary : .orange)
            }

            HStack(spacing: 7) {
                Image(systemName: "clock.arrow.circlepath")
                Text("Ultimo controllo: \(lastScan.formatted(date: .omitted, time: .shortened))")
                Spacer()
                if isScanning {
                    ProgressView().controlSize(.small)
                } else {
                    Button {
                        scan()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.subheadline.weight(.semibold))
                    }
                    .buttonStyle(.glass)
                    .accessibilityLabel("Ripeti scansione")
                }
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassEffect(.regular.tint(.mint.opacity(0.08)), in: RoundedRectangle(cornerRadius: 28, style: .continuous))
    }

    private func metric(value: String, label: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(value)
                .font(.system(size: 21, weight: .semibold, design: .rounded))
                .foregroundStyle(color)
                .contentTransition(.numericText())
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }

    private var controls: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Catalogo")
                    .font(.title3.bold())
                Spacer()
                Button {
                    showValues.toggle()
                } label: {
                    Label(showValues ? "Nascondi valori" : "Mostra valori", systemImage: showValues ? "eye.slash" : "eye")
                        .font(.caption.weight(.medium))
                }
                .buttonStyle(.glass)
            }

            Picker("Filtra entitlements", selection: $selectedFilter) {
                ForEach(EntitlementFilter.allCases) { filter in
                    Text(filter.rawValue).tag(filter)
                }
            }
            .pickerStyle(.segmented)
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "line.3.horizontal.decrease.circle")
                .font(.system(size: 32))
                .foregroundStyle(.secondary)
            Text("Nessun risultato")
                .font(.headline)
            Text("Cambia filtro o termine di ricerca.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 48)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private var footer: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Solo lettura · Nessuna telemetria", systemImage: "hand.raised.fill")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            Text("La scansione legge le chiavi note della firma di questa app. Un entitlement assente non equivale a una capability richiesta dal sistema; un entitlement presente non sostituisce autorizzazioni o configurazioni Apple.")
                .font(.caption)
                .foregroundStyle(.tertiary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.top, 5)
    }

    private func scan() {
        guard !isScanning else { return }
        isScanning = true
        Task { @MainActor in
            let results = await Task.detached(priority: .userInitiated) {
                EntitlementScanner.scan()
            }.value
            withAnimation(.snappy(duration: 0.28)) {
                statuses = results
                lastScan = Date()
                isScanning = false
            }
        }
    }
}
