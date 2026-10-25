import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Image(systemName: "checkmark.shield.fill")
                        .font(.system(size: 44, weight: .medium))
                        .foregroundStyle(.mint)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 18)

                    Text("Come leggere il risultato")
                        .font(.title2.bold())

                    explanationRow(title: "Presente", detail: "La chiave è stata letta dalla firma dell'eseguibile e il suo valore è disponibile.", color: .mint)
                    explanationRow(title: "Assente", detail: "La lettura è riuscita, ma la chiave non è presente nella firma di questa build.", color: .secondary)
                    explanationRow(title: "Errore", detail: "Il parser non è riuscito a leggere la chiave. Non viene classificata come assente.", color: .orange)

                    Divider().overlay(.white.opacity(0.12))

                    Text("Limite importante di iOS")
                        .font(.headline)
                    Text("Apple non espone alle app iOS un'API pubblica per enumerare tutte le chiavi di entitlement possibili. GassiManager legge i valori firmati per le chiavi del catalogo incluso nel progetto. Per controllare un'entitlement Apple nuovo o proprietario, aggiungi la sua chiave e il tipo corretto a EntitlementCatalog.swift.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("La presenza di un entitlement non garantisce da sola che un servizio funzioni: possono essere necessari un profilo valido, configurazione sul portale Apple, consenso dell'utente e condizioni del dispositivo. Il progetto non invia i dati a server e non contiene analytics.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(22)
            }
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("Informazioni")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fine") { dismiss() }
                        .buttonStyle(.glass)
                }
            }
        }
    }

    private func explanationRow(title: String, detail: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Circle().fill(color).frame(width: 9, height: 9).padding(.top, 5)
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.subheadline.weight(.semibold))
                Text(detail).font(.subheadline).foregroundStyle(.secondary)
            }
        }
    }
}
