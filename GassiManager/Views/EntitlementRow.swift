import SwiftUI

struct EntitlementRow: View {
    let status: EntitlementStatus
    let showValues: Bool

    private var accent: Color {
        if !status.isReadable { return .orange }
        return status.isPresent ? .mint : .secondary
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: status.definition.symbol)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(accent)
                    .frame(width: 42, height: 42)
                    .background(.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 14, style: .continuous))

                VStack(alignment: .leading, spacing: 4) {
                    Text(status.definition.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text(status.definition.key)
                        .font(.caption.monospaced())
                        .foregroundStyle(.secondary)
                        .textSelection(.enabled)
                        .lineLimit(2)
                }

                Spacer(minLength: 4)

                statusBadge
            }

            Text(status.definition.explanation)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            if showValues, let renderedValue = status.renderedValue, !renderedValue.isEmpty {
                VStack(alignment: .leading, spacing: 5) {
                    Text("VALORE LETTO DALLA FIRMA")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .tracking(1.1)
                        .foregroundStyle(.secondary)
                    Text(renderedValue)
                        .font(.footnote.monospaced())
                        .textSelection(.enabled)
                        .foregroundStyle(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
                .background(.black.opacity(0.16), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            }

            if let error = status.readError {
                Label(error, systemImage: "exclamationmark.triangle.fill")
                    .font(.caption)
                    .foregroundStyle(.orange)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .accessibilityElement(children: .contain)
    }

    private var statusBadge: some View {
        HStack(spacing: 5) {
            Circle()
                .fill(accent)
                .frame(width: 6, height: 6)
            Text(status.readError == nil ? (status.isPresent ? "PRESENTE" : "ASSENTE") : "ERRORE")
                .font(.system(size: 10, weight: .bold, design: .rounded))
                .tracking(0.5)
        }
        .foregroundStyle(accent)
        .padding(.horizontal, 9)
        .padding(.vertical, 7)
        .background(accent.opacity(0.12), in: Capsule())
    }
}
