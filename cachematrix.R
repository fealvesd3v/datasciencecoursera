##makeCacheMatrix This function creates a special "matrix" object that can cache its inverse. 
##Its internal list contains functions to
##Set the value of the matrix
##Get the value of the matrix
##Set the value of the inverse matrix
##Get the value of the inverse matrix
makeCacheMatrix <- function(matrix = matrix()) {
  
   ##Initializes the cache to null
   cache <- NULL

   ##Set matrix 
   set <- function(newMatrix) {
      ##Assign newMatrix to matrix
      matrix <<- newMatrix
      ##Clear Cache
      cache <<- NULL
   }

  ##Retrieve matrix
  get <- function() {
     ##Returns the stored matrix
     matrix
  }
  
  ##Set inverse matrix
  setInverse <- function(inverseMatrix){
     ##Inverse matrix is assigned to cache
     cache <<- inverseMatrix
  }
  
  ##Retrieve the inverse matrix
  getInverse <- function() {
     ##Returns the cached inverse matrix
     cache
  }
  
  ##Returns a list with references to all the functions defined above.
  list(
         set = set, get = get,
         setInverse = setInverse, getInverse = getInverse
  )
}

##This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
##If the inverse has already been calculated and cached (and the matrix has not changed), 
##then the cachesolve will retrieve the inverse from the cache.
cacheSolve <- function(matrix, ...) {
   
   ## Retrieves the inverse matrix and assigns it to the cache
   cache <- matrix$getInverse()

   ##Checks if the cache is null 
   if(!is.null(cache)) {
      ##If so, issue message
      message("Retrieving cached matrix...")
      ##Force "premature" return of the function
      ##Return the cached matrix
      return(cache)
  }
  
  ##Retrieves the stored matrix and assigns it to data
  data <- matrix$get()
  ##Calculates the inverse matrix
  cache <- solve(data, ...)
  ##Sets the inverse matrix
  matrix$setInverse(cache)
  ##Returns the cached inverted matrix
  cache
}
