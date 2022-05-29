//
//  RealmService.swift
//  RxMessage
//
//  Created by JunHeeJo on 5/26/22.
//

import Foundation
import RxSwift
import RealmSwift

protocol LocalDBService {
    func save(message: RMMessage, to room: RMMessageRoom) -> Observable<Void>
    func queryAllMessages(from roomKey: Int) -> Observable<[RMMessage]>
    func getMessageRoom(key: Int) -> Observable<RMMessageRoom>
    func queryAllMessageRoom() -> Observable<[RMMessageRoom]>
}

class RealmService: LocalDBService {
    
    private var realm: Realm {
        return try! Realm()
    }
    
    // TODO: create라는 개념이 아니라 있나 없나 확인하고 있으면 room object리턴 없으면 create 이므로 메서드 이름을 바꾸는게 좋지않을까?
    @discardableResult
    func getMessageRoom(key: Int) -> Observable<RMMessageRoom> {
        return Observable.create { observer in
            let realm = self.realm
            
            if let messageRoom = realm.object(ofType: RMMessageRoom.self, forPrimaryKey: key) {
                observer.onNext(messageRoom)
                observer.onCompleted()
                return Disposables.create()
            }
            
            do {
                try realm.write {
                    let newMessageRoom = RMMessageRoom(id: key)
                    realm.add(newMessageRoom)
                    observer.onNext(newMessageRoom)
                    observer.onCompleted()
                }
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func save(message: RMMessage, to room: RMMessageRoom) -> Observable<Void> {
        // room.allMessages에 저장을 해야한다.
        return Observable.create { observer in
            let realm = self.realm
            
            do {
                try realm.write {
                    room.allMessages.append(message)
                    observer.onNext(())
                    observer.onCompleted()
                }
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func queryAllMessages(from roomKey: Int) -> Observable<[RMMessage]> {
        return Observable.create { observer in
            let realm = self.realm
            
            guard let messageRoom = realm.object(ofType: RMMessageRoom.self, forPrimaryKey: roomKey) else {
                observer.onNext([])
                observer.onCompleted()
                return Disposables.create()
            }
            
            let allMessages = messageRoom.allMessages.sorted { $0.date < $1.date }
            observer.onNext(allMessages)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func queryAllMessageRoom() -> Observable<[RMMessageRoom]> {
        return Observable.create { observer in
            let realm = self.realm
            
            let messageRooms = realm.objects(RMMessageRoom.self)
            
            // TODO: 최근 메세지 기준으로 정렬해야한다.
            observer.onNext(messageRooms.toArray())
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}


extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
