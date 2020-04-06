# makeCacheMatrix and cacheSolve functions stores a martix and return the inverse of it.

# makeCacheMatrix creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
    inverse <- NULL
    
    # set -> set the value of the matrix 'x'
    set <- function(y) {
        x <<- y
        inverse <<- NULL
    }
    
    # get -> get the value of the matrix 'x'
    get <- function() x
    
    # setInverse -> set the inverse of a matrix for future use
    set.inverse <- function(inv) inverse <<- inv
    
    # getInverse -> get the precomputed inverse of the set matrix
    get.inverse <- function() inverse
    list(set = set, get = get,
         set.inverse = set.inverse,
         get.inverse = get.inverse)
}


# cacheSolve calculates the inverse of a matrix.
cacheSolve <- function(x, ...) {
    inverse <- x$get.inverse()
    
    # check if the inverse has already been computed
    if(!is.null(inverse)) {
        # if yes, return the cached value.
        message("getting cached data")
        return(inverse)
    }
    
    # otherwise, it calculates the inverse..
    data <- x$get()
    inverse <- solve(data)
    x$set.inverse(inverse)
    inverse
}