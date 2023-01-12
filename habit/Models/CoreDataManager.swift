//
//  CoreDataManager.swift
//  MyToDoApp
//
//  Created by Allen H on 2022/04/21.
//

import UIKit
import CoreData

//MARK: - To do 관리하는 매니저 (코어데이터 관리)

final class CoreDataManager {
    
    // 싱글톤으로 만들기
    static let shared = CoreDataManager()
    private init() {}
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func getHabitList() -> [Habit] {
        var habits: [Habit] = []
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: Entity.habit)
            request.predicate = NSPredicate(format: "isAcheived = %d", false as CVarArg)

            // 정렬순서를 정해서 요청서에 넘겨주기
            let dateOrder = NSSortDescriptor(key: "createdDate", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedList = try context.fetch(request) as? [Habit] {
                    habits = fetchedList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        return habits
    }
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func getAcheivedHabitList() -> [Habit] {
        var habits: [Habit] = []
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: Entity.habit)
            request.predicate = NSPredicate(format: "isAcheived = %d", true as CVarArg)

            // 정렬순서를 정해서 요청서에 넘겨주기
            let dateOrder = NSSortDescriptor(key: "createdDate", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedList = try context.fetch(request) as? [Habit] {
                    habits = fetchedList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        return habits
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    func saveData(name:String?, goalTitle: String?, goalCount: Int64, color: Int64, achieveCount: Int64, completion: @escaping () -> Void) {
        // 임시저장소 있는지 확인
        if let context = context {
            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: Entity.habit, in: context) {
                
                // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
                if let habit = NSManagedObject(entity: entity, insertInto: context) as? Habit {
                    
                    // MARK: - habit에 실제 데이터 할당 ⭐️
                    habit.id = UUID().uuidString
                    habit.name = name
                    habit.goalTitle = goalTitle
                    habit.goalCount = goalCount
                    habit.color = color
                    habit.acheiveCount = achieveCount
                    habit.isAcheived = false
                    habit.createdDate = Date()
                    
                    //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
        }
        completion()
    }
    
    // MARK: - [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 ===> 삭제)
    func deleteData(data: Habit, completion: @escaping () -> Void) {
        guard let id = data.id else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: Entity.habit)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
                if let fetchedList = try context.fetch(request) as? [Habit] {
                    
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                    if let target = fetchedList.first {
                        context.delete(target)
                        
                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
    func updateData(newData: Habit, completion: @escaping () -> Void) {
        guard let id = newData.id else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: Entity.habit)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기
                if let fetchedList = try context.fetch(request) as? [Habit] {
                    // 배열의 첫번째
                    if var habit = fetchedList.first {
                        
                        // MARK: - ToDoData에 실제 데이터 재할당(바꾸기) ⭐️
                        habit = newData
                        
                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
    
    
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    func saveAcheiveData(habit:Habit?, memo: String?, completion: @escaping () -> Void) {
        // 임시저장소 있는지 확인
        if let context = context {
            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: Entity.acheive, in: context) {
                
                // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
                if let acheive = NSManagedObject(entity: entity, insertInto: context) as? Acheive {
                    
                    // MARK: - habit에 실제 데이터 할당 ⭐️
                    acheive.id = UUID().uuidString
                    acheive.memo = memo
                    acheive.habit = habit
                    acheive.level = 3
                    acheive.createdDate = Date()
                    
                    //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
        }
        completion()
    }
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func getAcheiveList(habit: Habit) -> [Acheive] {
        var datas: [Acheive] = []
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: Entity.acheive)
            if let habitId = habit.id {
                request.predicate = NSPredicate(format: "habit.id = %@", habitId as CVarArg)
            }
//            request.predicate = NSPredicate(format: "id = %@", id as CVarArg)

//            let bookPersonPredicate = NSPredicate(format: "personRel.idPerson == %@", person.idPerson)

            // 정렬순서를 정해서 요청서에 넘겨주기
            let dateOrder = NSSortDescriptor(key: "createdDate", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedList = try context.fetch(request) as? [Acheive] {
                    datas = fetchedList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        return datas
    }
    
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func isCheckedToday(habit: Habit) -> Bool {
        var datas: [Acheive] = []
        var flag = false
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: Entity.acheive)
            if let habitId = habit.id {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let nowStr = dateFormatter.string(from: Date())
                let now = dateFormatter.date(from: nowStr)

                    
                let idPredicate = NSPredicate(format: "habit.id = %@", habitId as CVarArg)
                let createdDatePredicate = NSPredicate(format: "createdDate >= %@", now! as CVarArg)
                let andPredicate = NSCompoundPredicate(type: .and , subpredicates: [idPredicate, createdDatePredicate])
                request.predicate = andPredicate
            }
//            request.predicate = NSPredicate(format: "id = %@", id as CVarArg)

//            let bookPersonPredicate = NSPredicate(format: "personRel.idPerson == %@", person.idPerson)

            // 정렬순서를 정해서 요청서에 넘겨주기
//            let dateOrder = NSSortDescriptor(key: "createdDate", ascending: false)
//            request.sortDescriptors = [dateOrder]
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedList = try context.fetch(request) as? [Acheive] {
                    datas = fetchedList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        
        print(datas.count)
        if datas.count > 0 {
            flag = true
        } else {
            flag = false
        }
        
        return flag
    }
    
}
