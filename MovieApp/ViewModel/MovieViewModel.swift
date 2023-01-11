//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by FauziArda on 11/01/23.
//

import Foundation

class MovieViewModel {
    
    private var apiService = ApiService()
    private var coreDataManager = CoreDataManger()
    var discoverMovies = [Film]()
    var isConnectionOn = true
    private var movieDetail = [MovieDetail]()
    private var reviews = [Item]()
    private var trailerURL = ""
    
    init() {
        // get connection status
        isConnectionOn = Reachability.isConnectedToNetwork()
    }
    
    func setNextpage()  {
        self.apiService.page += 1
    }
    
    func setNextPageReview(){
        self.apiService.reviewPage += 1
    }
    
    func getConnectionStatus() -> Bool {
        Reachability.isConnectedToNetwork()
    }
    
    func fetchDiscoverMoviesData(completion: @escaping () -> ()) {
        // update connection status when back to online
        self.isConnectionOn = Reachability.isConnectedToNetwork()
        
        if self.isConnectionOn {
            print("trying get data form api")
            // weak self - prevent retain cycles
            apiService.getDiscoverMoviesData { [weak self] (result) in
                
                switch result {
                case .success(let listOf):
                    self?.discoverMovies = listOf.results
                    // save to coredata
                    for movie in self!.discoverMovies {
                        self!.coreDataManager.saveDataToCoreData(movie)
                    }
                    
                    // set it donw using completion
                    completion()
                    
                case .failure(let error):
                    // Something is wrong with the JSON file or the model
                    print("Error processing json data: \(error)")
                    self?.isConnectionOn = false
                }
            }
            
        } else {
            
            print("trying to get data form coredata")
            // get from coredata
            coreDataManager.fetchMovies()
            for data in coreDataManager.items! {
                let film = Film(adult: data.adult, backdropPath: data.backdropPath, genreIDS: data.genreIDS!, id: Int(data.id), originalLanguage: data.originalLanguage, originalTitle: data.originalTitle, overview: data.overview, popularity: data.popularity, posterPath: data.posterPath, releaseDate: data.releaseDate, title: data.title, video: data.video, voteAverage: data.voteAverage, voteCount: Int(exactly: data.voteCount)!)
                self.discoverMovies.append(film)
            }
            // set it donw using completion
            completion()
            
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if discoverMovies.count != 0 {
            return discoverMovies.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Film {
        return discoverMovies[indexPath.row]
    }
    
    // get number of data in coredata
    func coredataMovieCount() -> Int{
        return self.coreDataManager.items?.count ?? 0
    }
    
    // get movie's detail from api
    func getMoviesDetailFromAPI(id : Int, completion : @escaping () ->())  {
        // update connection status when back to online
        self.isConnectionOn = Reachability.isConnectedToNetwork()
        
        if self.isConnectionOn {
            print("trying get data movie detail form api")
            // weak self - prevent retain cycles
            apiService.getMoviesDetail(id: id) { [weak self] (result) in
                
                switch result {
                case .success(let detail):
                    self?.movieDetail = [detail]
                    
                    // checking data
//                    print("movie id:\(id) \n", "detail movie: \(String(describing: self?.movieDetail))")
                    
                    // TODO: save to coredata
//                    for movie in self!.discoverMovies {
//                        self!.coreDataManager.saveDataToCoreData(movie)
//                    }
                    
                    // set it done using completion
                    completion()
                    
                case .failure(let error):
                    // Something is wrong with the JSON file or the model
                    print("Error processing json data: \(error)")
                    self?.isConnectionOn = false
                }
            }
            
        }
        else {
            // get detail from coredata
            
            // set it done using completion
            
        }
            
    }
    
    func getMovieDetailInstance() -> [MovieDetail] {
        return self.movieDetail
        
    }
    
    // get movie reviews from api
    func getMovieReviewsFromAPI(id : Int, completion : @escaping () ->())  {
        // update connection status when back to online
        self.isConnectionOn = Reachability.isConnectedToNetwork()
        
        if self.isConnectionOn {
            print("trying get data movie detail form api")
            // weak self - prevent retain cycles
            apiService.getMovieReview(id: id) { [weak self] (result) in
                
                switch result {
                case .success(let data):
                    self?.reviews = data.results!
                    
                    // checking data
                    print("movie id:\(id) \n", "detail movie: \(String(describing: self?.reviews))")
                    
                    // TODO: save to coredata
//                    for movie in self!.discoverMovies {
//                        self!.coreDataManager.saveDataToCoreData(movie)
//                    }
                    
                    // set it done using completion
                    completion()
                    
                case .failure(let error):
                    // Something is wrong with the JSON file or the model
                    print("Error processing json data: \(error)")
                    self?.isConnectionOn = false
                }
            }
            
        }
        else {
            print("no internet connection")
            // get detail from coredata
            
            // set it done using completion
            
        }
            
    }
    
    func getReviews() -> [Item] {
        return self.reviews
    }
    
    
    // TODO: get video url from api
    func getMovieTrailerFromAPI(id : Int, completion : @escaping () ->())  {
        // update connection status when back to online
        self.isConnectionOn = Reachability.isConnectedToNetwork()
        
        if self.isConnectionOn {
            print("trying get data movie detail form api")
            // weak self - prevent retain cycles
            apiService.getVideoTrailerURL(id: id) { [weak self] (result) in
                
                switch result {
                case .success(let data):
                    for trailer in data.videos! {
                        if trailer.type == "Trailer"{
                            self?.trailerURL = trailer.key!
                            break
                        }
                    }
                    
                    // checking data
                    print("movie id:\(id) \n", "trailer: \(String(describing: self?.trailerURL))")
                    
                    // set it done using completion
                    completion()
                    
                case .failure(let error):
                    // Something is wrong with the JSON file or the model
                    print("Error processing json data: \(error)")
                    self?.isConnectionOn = false
                }
            }
            
        }
        else {
            print("no internet connection")
            // get detail from coredata
            
            // set it done using completion
            
        }
            
    }
    
    func getTrailerURL() -> String{
        return self.trailerURL
    }
    
}
