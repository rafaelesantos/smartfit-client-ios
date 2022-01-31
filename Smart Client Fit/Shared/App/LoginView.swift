//
//  LoginView.swift
//  Smart Client Fit
//
//  Created by Rafael Escaleira on 27/01/22.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var loginViewModel = LoginViewModel()
    @State private var isPresented: Bool? = nil
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    GroupBox(label: AboutAppLabelView(labelText: "Sobre", labelImage: "info.circle")) {
                        Divider().padding(.vertical, 4)
                        
                        HStack(alignment: .center, spacing: 10) {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(9)
                            
                            Text("Aplicativo desenvolvido com o intuito de exibir informações pessoais, histórico de acessos e mensalidades pagas e pendentes.")
                                .font(.footnote)
                        }
                    }
                    
                    GroupBox(label: AboutAppLabelView(labelText: "Login", labelImage: "lock.shield.fill")) {
                        Divider().padding(.vertical, 4)
                        
                        Group {
                            TextFieldRowView(name: "CPF", textContentType: .username, value: self.$loginViewModel.login)
                            TextFieldRowView(name: "Senha", textContentType: .password, value: self.$loginViewModel.password)
                            NavigationLink(destination: UserView(), tag: true, selection: self.$isPresented) {
                                Button("ACESSAR") {
                                    self.loginViewModel.postLogin {
                                        self.loginViewModel.login = ""
                                        self.loginViewModel.password = ""
                                        self.isPresented = true
                                    }
                                }
                                .font(.system(size: 15, weight: .bold, design: .default))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.clear)
                            }
                        }
                        .padding()
                        .background(
                            Color(UIColor.tertiarySystemBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        )
                    }
                    
                    GroupBox(label: AboutAppLabelView(labelText: "Usuários", labelImage: "person.3.fill")) {
                        Divider().padding(.vertical, 4)
                        
                        if self.loginViewModel.users.isEmpty {
                            Text("Nenhum usuário realizou o login até o momento.\nInforme suas credenciais a cima para usufruir da aplicação.")
                                .font(.footnote)
                        } else {
                            Group {
                                ForEach(self.loginViewModel.users) { user in
                                    UserRowView(user: user)
                                        .onTapGesture {
                                            self.loginViewModel.login = user.login
                                            self.loginViewModel.password = user.password
                                        }
                                        .padding(.all, 4)
                                        
                                    
                                }
                            }
                            .padding()
                            .background(
                                Color(UIColor.tertiarySystemBackground)
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            )
                        }
                    }
                }.padding(.all, 15)
            }
            .navigationBarTitle(Text("Área do Cliente"), displayMode: .large)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}
