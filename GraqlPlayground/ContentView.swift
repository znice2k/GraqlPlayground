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
    let getfunction = "backend.getSendMobile()"
    var otpMutation = SendMobileMutation(mobile: "")
    @ObservedObject var backend = Backend()
   
    let configuration = URLSessionConfiguration.default
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1c2VySWQiOiJjMmY0YWI2MC03OTlhLTQ0ZjktYTNmYS0zZDAwN2M4NDZkZDEiLCJzZXNzaW9uSWQiOiI2M2I2MTczNy1kNWVjLTRiNzctOGIwMy1iMDE2MDUwODcyNjciLCJleHAiOjE1ODAzMjgxNTIsIm1vZGUiOiJhY2Nlc3MifQ.VNicue3NN8cx9vupKhwjag47pe6_cKYL3k_21fh0dNGwES257c5fdmnN1_xyTxdkBz4U7ykPqWtFE51OnoqSxxjPozvy7aPw7tq6JjzPerj-IIzhobqn90IGGFH9Ro-_CuesCbxwfbmEDHgQEuUGZJS1rDiSRNZDn73Y3ZkGQR01Q8YXztrIRTS9OLPqJsmFPCm2ZimmxEgTRzrNTmQ13YTZNLBVc5RbTNOV96P0zSME5--HfwtPlFCHcv5hYyKIc6I19IMvtWOBw0NnuyeFiWqvw1YWvgDmq4kocJyHA2H5sxbsEccUZ_hE7LesMbtQAGzlYua6VdFFwBKxS6ILGLCRTWh4SGb2LqgmKE35vaZWYiuSnwcU7KmkD7oKMiIIKjx4mP09vUSWUaLFD_fi9SuDeG5_lE6yfUAianKILmiPoZdkxtb71rlobH5Iw7ZkS2GFsH0Y1x5iqkmugoZkvj6gkXAo6k8DNS0KMsUU-bGy2nBVwG3KNqtDoGkeEXrnX_mw7teUv6pWHsL5X5qXcHnZQUP73SBN0wa_BfPWRiqCErCHoG86Hn_OtmE0Z34UBKC4KRpE7yC_iYZvLOd_M2IVHdyCOm9sn5r0IYyn7VY9PbJLzroqBFNalFhJzN5nNVuPdNF5VF_URABQOaribRHnTb7V41ItgZyNslUI2oI"
    
    
    var body: some View {
        VStack{
         Text("Hello, World!")
            Button("Get Register"){
                self.getRegister()
            }
            
            if( self.backend.otpManger.otpSent == true){
                Text("OTP wurde erfolgreich versand")
            }
            
        }.onAppear(perform: {
           // self.getRegister()
        })
        
    }
    
    func getRegister(){

        //configuration.httpAdditionalHeaders = ["authorization":"\(token)"]

        backend.getSendMobile()

    }
    
    
}



final class Backend : ObservableObject{
    
    var otpMutation = SendMobileMutation(mobile: "")
    @State var isLoading = true
    let userdefault = UserDefaults.standard
    var willChange = PassthroughSubject<Backend, Never>()
    
    let group = DispatchGroup()
    let queue = DispatchQueue.global()
    
    
    @Published var otpManger = OTPManger(otpSent: false){
        didSet{
            DispatchQueue.main.async {
                print("start will change")
                self.willChange.send(self)
                print("end will change")
                
            }
        }
    }
    

    func getSendMobile(){
        isLoading = true
        
        
        group.enter()
        queue.async(group: group) {
                          client.perform(mutation: SendMobileMutation(mobile: "bumsi bumsi ?")){result in
                     switch result {
                                       // In case of success
                                       case .success(let graphQLResult):
                                           // We try to parse our result
                                        if let objId = graphQLResult.data?.register?.otpSent{
                                            print ("User created with ObjectId: "  + String(objId))
                                            DispatchQueue.main.async {
                                              self.isLoading = false
                                                self.otpManger.otpSent = objId
                                                print("group leave 1")
                                       //         self.group.leave()
                                            
                                            }

                                           }
                                           // but in case of any GraphQL errors we present that message
                                           else if let errors = graphQLResult.errors {
                                               // GraphQL errors
                                               print(errors)
                                               
                                           }
                                       // In case of failure, we present that message
                                       case .failure(let error):
                                         // Network or response format errors
                                         print(error)
                                   }
                    }
        }
        group.notify(queue: queue){
            
            self.queue.async {
                      client.perform(mutation: SendMobileMutation(mobile: "bumsi bumsi ?")){result in
                               switch result {
                                                 // In case of success
                                                 case .success(let graphQLResult):
                                                     // We try to parse our result
                                                  if let objId = graphQLResult.data?.register?.otpSent{
                                                      print ("User created with ObjectId: "  + String(objId))
                                                      DispatchQueue.main.async {
                                                        self.isLoading = false
                                                          self.otpManger.otpSent = objId
                                                          print("group leave 2")
                                                       
                                                      }

                                                     }
                                                     // but in case of any GraphQL errors we present that message
                                                     else if let errors = graphQLResult.errors {
                                                         // GraphQL errors
                                                         print(errors)
                                                         
                                                     }
                                                 // In case of failure, we present that message
                                                 case .failure(let error):
                                                   // Network or response format errors
                                                   print(error)
                                             }
                              }
            }
            
        }
        
        


        
      
        
        
    
    }
    func success(){
        print("Token erfolgreich geholt")
    }
    
    
}

struct OTPManger : Decodable{
    var otpSent : Bool
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}

