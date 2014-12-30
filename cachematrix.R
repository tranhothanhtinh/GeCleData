##  In order to avoid computing inverse matrix repeatedly (especially if the  matrix is big),
##  If the contents of a matrix are not changing, it may make sense to cache the 
##  inverse matrix so that when we need it again, it can be looked up in the cache
##  rather than recomputed.

## makeCacheMatrix function creates a special "matrix", which is really a list containing a function to
## 1- set elements of the matrix 
## 2- get the matrix by return a matrix
## 3- set elements of the inverse matrix
## 4- get the inverse matrix

makeCacheMatrix <- function(x = matrix())
{
  mat<-NULL
  
  set<-function(y) ## set the matrix
  {
    x<<-y
    mat<<-NULL
  }
  
  get<-function() x ## return the matrix
  
  set_matrix<-function(solve) mat<<- solve ## set the matrix to mat
  
  get_matrix<-function() mat ## return the matrix 
  
  list(set=set, get=get,  set_matrix=set_matrix, get_matrix=get_matrix)
}

## cacheSolve function calculates the inverse matrix  of the special "matrix" created with the above function.
## However, it first checks to see if the inverse matrix has already been calculated. If so, it gets 
## the inverse matrix from the cache and skips the computation. Otherwise, it calculates the inverse matrix of the matrix
## and sets the inverse matrix in the cache via the set_matrix function.

cacheSolve <- function(x=matrix(), ...) 
{
  mat<-x$get_matrix()
  
  if(!is.null(mat))  ## if the inverse matrix has been already computed in cache then get the inverse matrix from cach
  {
    message("Getting cached matrix")
    return(mat)
  }
  
  matrix<-x$get() ## get the matric by call get() of makeCacheMatrix
  
  mat<-solve(matrix, ...) # copute the inverse matrix by solve() function
  
  x$set_matrix(mat) ## return the inverse matrix
  
  mat
}
