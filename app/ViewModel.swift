import SwiftUI
import CoreData
 
class ViewModel : ObservableObject{
    @Published var content = ""
    @Published var url = ""
    @Published var date = Date()
    @Published var isNewData = false
    @Published var updateItem : Task!
    
    func writeData(context : NSManagedObjectContext ){
        
        if updateItem != nil{
            updateItem.date = date
            updateItem.content = content
            updateItem.url = url
            try! context.save()
            
            updateItem = nil
            isNewData.toggle()
            content = ""
            url = ""
            date = Date()
            return
        }
        
        let newTask = Task(context: context)
        newTask.date = date
        newTask.content = content
        newTask.url = url
        
        do{
            try context.save()
            isNewData.toggle()
            content = ""
            url = ""
            date = Date()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func EditItem(item:Task){
        updateItem = item
        
        date = item.date!
        content = item.content!
        url = item.url!
        isNewData.toggle()
    }
}
 
