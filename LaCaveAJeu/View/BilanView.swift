
import SwiftUI

struct BilanView: View {
    @StateObject private var viewModel = BilanViewModel()
    @StateObject private var vendeurVM = VendeurlViewModel()
    @State private var selectedVendeurId = ""
    let yellowlight = Color(red : 240/255.0,green: 230/255.0, blue:158/255.0)
    let bleufonce = Color(red: 45/255.0, green: 85/255.0,blue: 166/255.0)
    var body: some View {
        NavigationStack{
            ZStack{
                bleufonce.ignoresSafeArea()
                VStack{
                    HStack{
                        NavigationLink(destination: TableauDeBordView()) {
                            VStack{
                                Image("arrow").resizable()
                                    .frame(width: 60, height: 40)
                                    .scaledToFit()
                            }
                            .background(yellowlight)
                            .cornerRadius(10)
                            .padding(.leading, 30.0)}
                        Spacer()
                        Text("📋")
                            .font(.system(size:40))
                            .padding(.trailing, 30.0)
                    }
                    Spacer().frame(height: 20)
                    HStack{
                        Spacer()
                        Text("Bilan")
                            .font(.jomhuriaBigger())
                            .foregroundColor(yellowlight)
                        Spacer()
                    }
                    Spacer().frame(height: 0)
                    VStack {
                    
                        Picker("Vendeur", selection: $selectedVendeurId) {
                            Text("Sans sélection").tag("")
                            ForEach(vendeurVM.vendeurs) { vendeur in
                                if let id = vendeur.id {
                                    Text("\(vendeur.nom) \(vendeur.prenom)").tag(vendeur.id ?? "")
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
                        
                        
                    }.padding()
                        .background(yellowlight)
                        .cornerRadius(10)
                        .padding()
                        .onChange(of: selectedVendeurId) { newId in
                            viewModel.fetchBilan(for: newId)
                        }
                        .onAppear {
                            vendeurVM.fetchVendeurs()
                        }
                }
            }}
        }}


#Preview {
    BilanView()
}
