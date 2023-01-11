//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by FauziArda on 11/01/23.
//

import CoreData
import UIKit

class CoreDataManger{
    // get reference to object manage context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // data for table
    var items : [Movie]?

    // fetch data from core data and display it
    func fetchMovies(){
        do {
            self.items = try context.fetch(Movie.fetchRequest())
        }
        catch {
            print("error occure on fetch data from coredata")
        }
    }

    // insert into coredata
    func saveDataToCoreData(_ film : Film){
        // create nsobject of Movie
        let movie = Movie(context: self.context)

        // edit attribute
        movie.title = film.title
        movie.posterPath = film.posterPath
        movie.adult = film.adult!
        movie.backdropPath = film.backdropPath
        movie.genreIDS = film.genreIDS!
        movie.id = Int32(film.id!)
        movie.originalLanguage = film.originalLanguage
        movie.originalTitle = film.originalTitle
        movie.overview = film.overview
        movie.popularity = film.popularity!
        movie.releaseDate = film.releaseDate
        movie.video = film.video!
        movie.voteAverage = film.voteAverage!
        movie.voteCount = Int16(film.voteCount!)

        // save it

        do {
            try context.save()
        }
        catch {
            print("error while saving data to coredata")
        }

        // show it
        fetchMovies()
    }

    // delete a data from coredata
    func deleteDataFromCoreData(_ film : Film){

        // get the object data
        let objToRemove = self.items?.first(where: { Movie in
            return Movie.id == film.id!
        })

        // remove that obj in context
        self.context.delete(objToRemove!)

        // save it
        do {
            try context.save()
        }
        catch {
            print("error while saving data to coredata")
        }

        // fetch again
        fetchMovies()

    }
}
