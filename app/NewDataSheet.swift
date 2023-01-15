

import SwiftUI
import GoogleMobileAds



struct NewDataSheet: View {
   @ObservedObject var viewModel : ViewModel
   @Environment(\.managedObjectContext) var context
   
   var bannerView: GADBannerView!
   var body: some View {
       ZStack{
           LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.2), .gray.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
               


           
           VStack{
               Spacer()
                   .frame(height: 100)
               Text("タイトル")
                   .font(.title3)
                   .fontWeight(.light)
                   .padding()
                   .ignoresSafeArea(.keyboard)
               TextEditor(text: $viewModel.content)
                   .frame(width: 300, height: 50)
                   .border(Color.gray, width: 1)
                   .padding()
               Text("URL")
                   .font(.title3)
                   .fontWeight(.light)
                   .padding()
               TextEditor(text: $viewModel.url)
                   .frame(width: 300, height: 50)
                   .border(Color.gray, width: 1)
                   .padding()
               
   
               Spacer()
               Button(action: {
                   viewModel.writeData(context: context)
               }, label: {
                   Text(viewModel.updateItem == nil ? "追加する" : "追加する")
                   .padding(.vertical)
                   .foregroundColor(.white)
                   .frame(width:UIScreen.main.bounds.width - 30)
                   .background(Color.gray)
                   .cornerRadius(50)
               })
               .padding()
               .disabled(viewModel.content == "" ? true : false)
               .opacity(viewModel.content == "" ? 0.6 : 1)
               
               
               
//               AdMobBannerView()
//                   .frame(height: 300)
//                   .ignoresSafeArea(.keyboard, edges: .bottom)
           }
           
       }
       .ignoresSafeArea(.keyboard, edges: .bottom)
      
   }
    
}
