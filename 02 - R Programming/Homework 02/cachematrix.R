## Caching complex function results saves time, here we determine if the cache 
## of an inverse matrix exixsts, if it does, we use that value, if not we
## create it and add it to the cache


# Namespace the function so we don't have any collisions

# initialize the inverse vector (i) defautling it to NULL
# initialize setter/getter methods
# expose methods for use
makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  set <- function(y){
    x <<- y
    i <<-NULL
  }
    get <- function(){ x }
    setInverse <- function(inverse) i <<- inverse
    getInverse <- function(){ i }
    list(set = set, 
         get = get, 
         setInverse = setInverse, 
         getInverse = getInverse)
}


# Test cache to see if value exists, if it does use that value, if it doesn't
# generate value we need, return value
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  i <- x$getInverse()
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setInverse(i)
  i
}

# Test
# a <- matrix(c(2, 4, 3, 1, 5, 7), nrow = 2, ncol=2)
# a
# b <- makeCacheMatrix(a)
# c <- cacheSolve(b)
# c
# d <- cacheSolve(b)
# d

