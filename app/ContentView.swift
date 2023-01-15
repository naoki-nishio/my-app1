
import SwiftUI
import CoreData
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport


struct AdMobBannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        print("広告を表示")
        let banner = GADBannerView(adSize: GADAdSizeBanner) // インスタンスを生成
        // 諸々の設定をしていく
        banner.adUnitID = "ca-app-pub-8979621487536159/8271665356" // 自身の広告IDに置き換える
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        
        
        
        return banner // 最終的にインスタンスを返す
        
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {
      // 特にないのでメソッドだけ用意
    }
}


struct ContentView: View {
//    init() {
//        UITableView.appearance().backgroundColor = .white
//    }
    
    

    
    @StateObject var viewModel = ViewModel()
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],
        animation: .spring()
    ) var results : FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    @State private var isShowingDialog = false
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            VStack{
                Button(action: {
                    requestIDFA()
                      }){
                          Text("広告許可")
                      }

                VStack(){
                    
                    
                    if results.isEmpty{
                        Spacer()
                        Text("+ボタンよりURLを追加")
                            .font(.title3)
                            .fontWeight(.light)
                            .foregroundColor(.primary)
                            .padding()
                        Spacer()
                    }else{
                        List{
                            ForEach(results){ Task in
                                
                                VStack{
                                    Button(action: {
                                        if let url = URL(string:Task.url ?? "") {
                                            UIApplication.shared.open(url, options: [.universalLinksOnly: false], completionHandler: {completed in
                                                print(completed)
                                            })
                                        }
                                        
                                    }, label: {
                                        HStack{
                                            Text(Task.content ?? "")
                                                .font(.title2)
                                                .fontWeight(.light)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                        
                                            
                                            
                                        }})
                                    .padding(5)
                                    
                                }
                                
                            }
                            .onDelete(perform: deleteData)
                            
                        }
                        
                        .listStyle(InsetListStyle())
                        
                    }
                }
                HStack{
                    Spacer()
                    Button(action: {viewModel.isNewData.toggle()}, label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.gray)
                            .clipShape(Circle())
                        
                    })
                    .padding(5)
                    
                }
                AdMobBannerView()
                    .frame(width:320,height: 50)
                
                
            }
        })
        //.ignoresSafeArea(.all, edges: .top)
        .background(Color.primary.opacity(0).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $viewModel.isNewData, content: {
            NewDataSheet(viewModel: viewModel)
        })
        
        

    }
      
    
    private func deleteData(offsets: IndexSet) {
            offsets.forEach { index in
                context.delete(results[index])
            }
        // 保存を忘れない
            try? context.save()
        }
    
    
    
    
}





class ViewController: UIViewController {

  private var interstitial: GADInterstitialAd?

  override func viewDidLoad() {
    super.viewDidLoad()
    let request = GADRequest()
    GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                                request: request,
                      completionHandler: { [self] ad, error in
                        if let error = error {
                          print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                          return
                        }
                        interstitial = ad
                      }
    )
  }
}


