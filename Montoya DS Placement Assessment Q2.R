## Fernanda Montoya
## JHU Biostatistics PhD Placement Assessment - Data Science
## 8/6/2024

## Question 2

## call libraries
library(tidyverse)

## write function to solve b manually - used to check gradient descent later
b_sol <- function(x, y) {
  b <- (sum(x*y))/(sum(x*x))
  return(b)
}

## randomly generate two vectors of length n
n <- 3
x <- rnorm(n = n)
y <- rnorm(n = n)

## gradient descent function for L(b)
## function takes in two vectors x and y, an initial guess for b (b0), a user-specified
## step-size (e), and number of iteration to pass through (iter)
gdes <- function(x, y, b0, e, iter) {
  ## gradient descent
  bs <- rep(NA, 50)
  
  for(i in 1:iter){
    
    b <- b0 - e*(-2*sum(x*y) + 2*b0*sum(x*x)) ## derivative of L(b) wrt b eval at b
    
    ## convergence criteria
      if(sum(abs(b - b0)) < 1e-15){
        break
        b0 <- b 
      }
    b0 <- b
  }
  ## save the final estimate for b obtained and return it
  b0 <- b
  return(b)
}

## find correct solution for b using generated x and y
b_sol(x = x, y = y)

## testing function under different conditions
gdes(x = x, y = y, b0 = 1, e = .1, iter = 50)
gdes(x = x, y = y, b0 = 15, e = .1, iter = 50)
gdes(x = x, y = y, b0 = 1, e = 2, iter = 50)
gdes(x = x, y = y, b0 = 1, e = .1, iter = 1000)

## Function Questions

## How does the performance of the algorithm depend on e?

## The user input for e adjust how large or small of a step is taken when performing 
## the gradient descent and thus, we see that when running the function and changing only the 
## e parameter, convergence to b is happens more slowly for larger step sizes.

## When does the algorithm fail and why?

## This can algorithm fail for a couple of different reasons. One is if the number of iterations
## that the gradient descent completes is too low, the algorithm will not converge to the right
## value of b as it cannot compute enough values for b to get close to the convergence criteria. 
## Additionally, if the number of iterations is too large with a step size that is also 
## too large (e.g. e = 2 and iter = 500), the convergence criteria in the function is not met and fails to find
## b.



