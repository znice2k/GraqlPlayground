//
//  ContentView.swift
//  GraqlPlayground
//
//  Created by Alexander Nikiforow on 17.01.20.
//  Copyright © 2020 Alexander Nikiforow. All rights reserved.
//

import SwiftUI
import Apollo
import UIKit
import Combine



struct ContentView: View {
    let url = URL(string: "http://192.168.0.58:8000")
   
    let configuration = URLSessionConfiguration.default
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1c2VySWQiOiJjMmY0YWI2MC03OTlhLTQ0ZjktYTNmYS0zZDAwN2M4NDZkZDEiLCJzZXNzaW9uSWQiOiI2M2I2MTczNy1kNWVjLTRiNzctOGIwMy1iMDE2MDUwODcyNjciLCJleHAiOjE1ODAzMjgxNTIsIm1vZGUiOiJhY2Nlc3MifQ.VNicue3NN8cx9vupKhwjag47pe6_cKYL3k_21fh0dNGwES257c5fdmnN1_xyTxdkBz4U7ykPqWtFE51OnoqSxxjPozvy7aPw7tq6JjzPerj-IIzhobqn90IGGFH9Ro-_CuesCbxwfbmEDHgQEuUGZJS1rDiSRNZDn73Y3ZkGQR01Q8YXztrIRTS9OLPqJsmFPCm2ZimmxEgTRzrNTmQ13YTZNLBVc5RbTNOV96P0zSME5--HfwtPlFCHcv5hYyKIc6I19IMvtWOBw0NnuyeFiWqvw1YWvgDmq4kocJyHA2H5sxbsEccUZ_hE7LesMbtQAGzlYua6VdFFwBKxS6ILGLCRTWh4SGb2LqgmKE35vaZWYiuSnwcU7KmkD7oKMiIIKjx4mP09vUSWUaLFD_fi9SuDeG5_lE6yfUAianKILmiPoZdkxtb71rlobH5Iw7ZkS2GFsH0Y1x5iqkmugoZkvj6gkXAo6k8DNS0KMsUU-bGy2nBVwG3KNqtDoGkeEXrnX_mw7teUv6pWHsL5X5qXcHnZQUP73SBN0wa_BfPWRiqCErCHoG86Hn_OtmE0Z34UBKC4KRpE7yC_iYZvLOd_M2IVHdyCOm9sn5r0IYyn7VY9PbJLzroqBFNalFhJzN5nNVuPdNF5VF_URABQOaribRHnTb7V41ItgZyNslUI2oI"
    
    var backend = Backend()

    
    
    var body: some View {
        VStack{
         Text("Hello, World!")
            Button("Get Register"){
                self.getRegister()
            }
            
        }.onAppear(perform: {
            self.getRegister()
        })
        
    }
    
    func getRegister(){

        //configuration.httpAdditionalHeaders = ["authorization":"\(token)"]
        



        backend.getSendMobile()
      
        
       
    }
    
}



final class Backend{
    
    
    

    
    
    var network = Network()
    
    func getSendMobile(){

       
  /*  apollo.perform(mutation: RegisterMutation(mobile: "1241234")){ result in
         print("es geht los")
         guard let data = try? result.get().data else {
             print("empty response")
             return
             
         }
         print("Hier bin ich")
        // print(data.register?.otpSent)
     }*/
             
        
      /* let task = Network.shared.apollo.perform(mutation: RegisterMutation(mobile: "1241234"))
        { result in
            print("es geht los")
            guard let data = try? result.get().data else {
                print("empty response")
                return
            }
            print("Hier bin ich")
            print(data.register?.otpSent)
        }*/
        
        Network.shared.apollo.fetch(query: GetNameQuery())
        { result in
            print("es geht los")
            guard let data = try? result.get().data else {
                print("empty response")
                return
            }
            print("Hier bin ich")
           // print(data.register?.otpSent)
        }
        
        
    
    }
    
    
  
    
    
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}

