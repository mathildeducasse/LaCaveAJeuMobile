
import SwiftUI

struct BilanView: View {
    @StateObject private var viewModel = BilanViewModel()
    @StateObject private var vendeurVM = VendeurlViewModel()
    @State private var selectedVendeurId = ""
    let yellowlight = Color(red : 240/255.0,green: 230/255.0, blue:158/255.0)
    var body: some View {
        NavigationStack{
            VStack {
                NavigationLink(destination: TableauDeBordView()) {
                    VStack{
                        Image("arrow").resizable()
                            .frame(width: 60, height: 40)
                            .scaledToFit()
                    }
                    .background(yellowlight)
                    .cornerRadius(10)
                    .padding(.leading, 30.0)}
                    Text("📊 Bilan vendeur").font(.title)
                    
                    Picker("Vendeur", selection: $selectedVendeurId) {
                        Text("Sans sélection").tag("")
                        ForEach(vendeurVM.vendeurs) { vendeur in
                            if let id = vendeur.id {
                                Text("\(vendeur.nom) \(vendeur.prenom)").tag(id)
                            }
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    
                    if let bilan = viewModel.bilan {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("📦 Dépôts : \(bilan.nbDepots)")
                            Text("🛒 Ventes : \(bilan.nbVentes)")
                            Text("💰 Portefeuille : \(String(format: "%.2f", bilan.portefeuilleTotal)) €")
                            Text("💸 Frais payés : \(String(format: "%.2f", bilan.fraisTotal)) €")
                            Text("🎮 Jeux restants : \(bilan.jeuxRestants)")
                            Text("✅ Jeux vendus : \(bilan.jeuxVendus)")
                        }
                        .padding()
                    }
                    
                    Spacer()
                }
                .onChange(of: selectedVendeurId) { newId in
                    viewModel.fetchBilan(for: newId)
                }
                .onAppear {
                    vendeurVM.fetchVendeurs()
                }
            }
        }}


#Preview {
    BilanView()
}
