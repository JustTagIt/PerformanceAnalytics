% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MM.NCE.R
\name{NCE}
\alias{NCE}
\alias{MM.NCE}
\title{Functions for calculating the nearest comoment estimator for financial time series}
\usage{
MM.NCE(R, as.mat = TRUE, ...)
}
\arguments{
\item{R}{an xts, vector, matrix, data frame, timeSeries or zoo object of
asset returns (with mean zero)}

\item{as.mat}{TRUE/FALSE whether to return the full moment matrix or only
the vector with the unique elements (the latter is advised for speed), default
TRUE}

\item{\dots}{any other passthru parameters, see details.}
}
\description{
calculates NCE covariance, coskewness and cokurtosis matrices
}
\details{
The coskewness and cokurtosis matrices are defined as the matrices of dimension 
p x p^2 and p x p^3 containing the third and fourth order central moments. They
are useful for measuring nonlinear dependence between different assets of the 
portfolio and computing modified VaR and modified ES of a portfolio.

The nearest comoment estimator is a way to estimate the covariance, coskewness and
cokurtosis matrix by means of a latent multi-factor model. The method is proposed in 
Boudt, Cornilly and Verdonck (2018).

The optional arguments include the number of factors, given by `k` and the weight matrix
`W`, see the examples.
}
\examples{
data(edhec)

# default estimator
est_nc <- MM.NCE(edhec[, 1:3] * 100)

# scree plot to determine number of factors
obj <- rep(NA, 5)
for (ii in 1:5) {
    est_nc <- MM.NCE(edhec[, 1:5] * 100, k = ii - 1)
    obj[ii] <- est_nc$optim.sol$objective * nrow(edhec[, 1:5])
}
plot(0:4, obj, type = 'b', xlab = "number of factors", 
     ylab = "objective value", las = 1)
     
# bootstrapped estimator
est_nc <- MM.NCE(edhec[, 1:2] * 100, W = list("Wid" = "RidgeD",
                 "alpha" = NULL, "nb" = 250, "alphavec" = seq(0.2, 1, by = 0.2)))
                 
# ridge weight matrix with alpha = 0.5
est_nc <- MM.NCE(edhec[, 1:2] * 100, W = list("Wid" = "RidgeD", "alpha" = 0.5))

}
\references{
Boudt, Kris, Dries Cornilly and Tim Verdonck. 2020. Nearest comoment estimation with unobserved
factors. Journal of Econometrics, 217(2), 381-397.
}
\seealso{
\code{\link{CoMoments}} \cr \code{\link{ShrinkageMoments}} \cr \code{\link{StructuredMoments}}  
\cr \code{\link{EWMAMoments}} \cr \code{\link{MCA}}
}
\author{
Dries Cornilly
}
\concept{co-moments}
\concept{moments}
