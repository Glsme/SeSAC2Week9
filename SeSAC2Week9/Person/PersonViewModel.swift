//
//  PersonViewModel.swift
//  SeSAC2Week9
//
//  Created by Seokjune Hong on 2022/08/31.
//

import Foundation

class PersonViewModel {
    var list: Observable<Person> = Observable(Person(page: 0, totalPages: 0, totalResults: 0, results: []))
    
    func fetchPerson(query: String) {
        PersonAPIManager.requestPerson(query: query) { person, error in
            guard let person = person else {
                return
            }
            
//            dump(person.results)
            self.list.value = person
        }
    }
    
    var numberOfRowsInsection: Int {
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Result {
        return list.value.results[indexPath.row]
    }
}
