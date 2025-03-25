import SwiftUI

struct loginGestionnaireView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var navigateToDashboard = false
    
    var body: some View {
        let prettyBlue = Color(red:45/255.0, green: 85/255.0, blue :166/255.0)
        let bluelight2 = Color(red : 121/255.0, green : 178/255.0, blue: 218/255.0)
        let yellowlight = Color(red: 241/255.0, green: 227/255.0, blue: 129/255.0)
        let redark = Color(red : 149/255.0, green :29/255.0, blue:25/255.0)

        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    Spacer()
                    
                    // Carte de connexion
                    VStack(spacing: 0) {
                        Text("Login")
                            .font(.jomhuriaBig())
                            .fontWeight(.bold)
                            .foregroundColor(yellowlight)

                        VStack(alignment: .leading, spacing: 0) {
                            Text("pseudo")
                                .font(.jomhuriaLittle())
                                .foregroundColor(yellowlight)
                            TextField("pseudo", text: $viewModel.pseudo)
                                .padding()
                                .background(bluelight2)
                                .cornerRadius(10)
                                .foregroundColor(redark)
                        }

                        VStack(alignment: .leading, spacing: 0) {
                            Text("mot de passe")
                                .font(.jomhuriaLittle())
                                .foregroundColor(yellowlight)
                            SecureField("**********", text: $viewModel.motDePasse)
                                .padding()
                                .background(bluelight2)
                                .cornerRadius(10)
                                .foregroundColor(redark)
                        }
                        Spacer().frame(height: 40)

                        Button(action: {
                            viewModel.login()
                        }) {
                            Text("se connecter")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.5))
                                .cornerRadius(10)
                        }


                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                        }

                       
                    }
                    .padding()
                    .background(prettyBlue)
                    .cornerRadius(20)
                    .padding(.horizontal, 40)

                    Spacer()

                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                        .padding(.bottom, 20)
                }
            }
            .background(Image("Image")
                .resizable()
                .ignoresSafeArea(.all)
            )
            .navigationDestination(isPresented: $viewModel.isAuthenticated) {
                    TableauDeBordView()
                }
        }.navigationBarBackButtonHidden(true)
    }
}
struct loginGestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        loginGestionnaireView()
    }
}
