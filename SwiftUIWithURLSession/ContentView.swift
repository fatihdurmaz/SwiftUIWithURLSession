//
//  ContentView.swift
//  SwiftUIWithURLSession
//
//  Created by Fatih Durmaz on 16.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var users = [User]()
    var body: some View {
        NavigationStack{
            List(users){ user in
                HStack{
                    Text("\(user.id)")
                        .padding()
                        .foregroundColor(.white)
                        .background(.gray)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        
                        Text(user.name)
                            .font(.headline)
                        Text(user.email)
                            .font(.subheadline)
                    }
                }
            }
            .onAppear(perform: loadData)
            .navigationTitle("SwiftUI & URL Session")
        }
    }
    
    func loadData(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        
        URLSession.shared.dataTask(with: url){ data,response,error in
            
            guard let data = data else {
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    self.users = decodeData
                }
                
            }catch let error{
                print(error)
            }
            
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
