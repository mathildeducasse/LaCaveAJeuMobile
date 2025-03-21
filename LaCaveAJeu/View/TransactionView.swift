//
//  TransactionView.swift
//  LaCaveAJeu
//
//  Created by etud on 20/03/2025.
//

import SwiftUI

struct TransactionView: View {
    @State var showFilters = false
    @StateObject private var viewModel = TransactionViewModel()
    let blueclair = Color(red : 121/255.0, green : 178/255.0, blue: 218/255.0)
    let bluee = Color(red : 45/255.0, green : 85/255.0, blue: 166/255.0)
    let bluegris = Color(red : 193/255.0, green : 205/255.0, blue: 214/255.0)
    let yelloww = Color(red : 240/255.0, green : 230/255.0, blue: 158/255.0)
    var body: some View {
        VStack{
            Spacer().frame(height: 80);
            HStack{
                Spacer()
                Text("💸")
                    .font(.system(size:40))
                    .padding(.trailing, 30.0)
                
            }
            HStack{
                Spacer()
                Text("Transactions")
                    .font(.jomhuriaBigger())
                    .foregroundColor(blueclair)
                Spacer()
            }
            Spacer().frame(height: 0);
            VStack{
                
                HStack {
                    Text("Filtres")
                        .font(.jomhuria())
                        .foregroundColor(bluee)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showFilters.toggle()
                        }
                    })
                    {
                        Text(showFilters ? "−" : "+")
                            .font(.title)
                            .bold()
                            .foregroundColor(bluee)
                    }
                }.frame(width: 260, height: 20)
                .padding()
                .background(bluegris)
                .cornerRadius(10)
                
                if showFilters{
                    TransactionFiltresView(viewModel : viewModel)
                }
                
                VStack {
                     ForEach($viewModel.transactions) { $transaction in
                         TransactionsView(transaction : $transaction)
                    }}.onAppear {
                        viewModel.fetchTransaction()
                    }
                
                Spacer()
            }.padding(.horizontal, 20.0)
                .padding(.vertical, 30)
            .background(yelloww)
                .cornerRadius(10)
                .padding(.horizontal, 30)
                
        }.background(bluee)
        .edgesIgnoringSafeArea(.all)
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
