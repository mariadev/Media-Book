//
//  CoreDataStorageManager.swift
//  Media
//
//  Created by Maria on 31/12/2020.
//

import Foundation
import CoreData

// TODO: capa de abstraction para usar siempre media items

class CoreDataStorageManager: FavoritesProvidable {
    
    let mediaItemKind: MediaItemType
    let stack = CoreDataStack.shareInstance
    
    init(withMediaItemKind mediaItemKind: MediaItemType) {
        self.mediaItemKind = mediaItemKind
    }
    
    func getFavorites() -> [MediaItemDetailProvidable]? {
        
        let context = stack.persistentContainer.viewContext
        switch self.mediaItemKind {
        case .book:
            let fetchRequest : NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
            let dateSortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "publishedDate", ascending: true)
            let priceSortDescriptor = NSSortDescriptor(key: "price", ascending: false)
            fetchRequest.sortDescriptors = [dateSortDescriptor, priceSortDescriptor]
            do {
                let favorites = try context.fetch(fetchRequest)
                return favorites.map({ $0.mappedObject() })
            } catch {
                assertionFailure("Error fetching books")
                return nil
            }
            
        default:
            fatalError("not supported yet")
        }
        
    }
    
    func getFavorite(byId favoriteId: String) -> MediaItemDetailProvidable? {
        let context = stack.persistentContainer.viewContext
        switch self.mediaItemKind {
        case .book:
            let fetchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "bookId = %@", favoriteId)
            fetchRequest.predicate = predicate
            do {
                let favorites = try context.fetch(fetchRequest)
                return favorites.last?.mappedObject()
            } catch {
                assertionFailure("Error fetching media item by id \(favoriteId)")
                return nil
            }
            
        default:
            fatalError("not supported yet")
        }
    }
    
    func add(favorite: MediaItemDetailProvidable) {
        let context = stack.persistentContainer.viewContext
        if let book = favorite as? Book {
            let bookManaged = BookManaged(context: context)
            bookManaged.bookId = book.bookId
            bookManaged.bookTitle = book.title
            bookManaged.publishedDate = book.publishedDate
            bookManaged.coverURL = book.coverURL?.absoluteString
            bookManaged.bookDescription = book.description
            if let rating = book.rating {
                bookManaged.rating = rating
            }
            if let numberOfReviews = book.numberOfReviews {
                bookManaged.numberOfReviews = Int32(numberOfReviews)
            }
            if let price = book.price {
                bookManaged.price = price
            }
            book.authors?.forEach({ (authorName) in
                let author = Author(context: context)
                author.fullName = authorName
                bookManaged.addToAuthors(author)
            })
            do {
                try context.save()
            } catch {
                assertionFailure("error saving context")
            }
        } else {
            fatalError("not supported yet :(")
        }
        
    }
    
    func remove(favoriteWithId favoriteId: String) {
        let context = stack.persistentContainer.viewContext
        switch self.mediaItemKind {
        case .book:
            let fetchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "bookId = %@", favoriteId)
            fetchRequest.predicate = predicate
            do {
                let favorites = try context.fetch(fetchRequest)
                favorites.forEach({ (bookManaged) in
                    context.delete(bookManaged)
                })
                try context.save()
                
            } catch {
                assertionFailure("Error removing media item with id \(favoriteId)")
            }
            
        default:
            fatalError("not supported yet :(")
        }
    }
    
}

