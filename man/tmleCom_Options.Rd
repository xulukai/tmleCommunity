% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zzz.R
\name{tmleCom_Options}
\alias{tmleCom_Options}
\title{Setting all possible options for \code{tmleCommunity} }
\usage{
tmleCom_Options(Qestimator = c("speedglm__glm", "glm__glm", "h2o__ensemble",
  "SuperLearner"), gestimator = c("speedglm__glm", "glm__glm",
  "h2o__ensemble", "SuperLearner"), bin.method = c("equal.mass", "equal.len",
  "dhist"), nbins = 5, maxncats = 10, maxNperBin = 500, parfit = FALSE,
  poolContinVar = FALSE, savetime.fit.hbars = TRUE,
  h2ometalearner = "h2o.glm.wrapper", h2olearner = "h2o.glm.wrapper",
  CVfolds = 5, SL.library = c("SL.glm", "SL.step", "SL.glm.interaction"))
}
\arguments{
\item{Qestimator}{A string specifying default estimator for outcome mechanism model fitting. 
The default estimator is \code{"speedglm__glm"}, which estimates regressions with \code{\link[speedglm]{speedglm.wfit}}; 
Estimator \code{"glm__glm"} uses \code{\link[stats]{glm.fit}};
Estimator \code{"h2o__ensemble"} implements the super learner ensemble (stacking) algorithm using the H2O R interface; 
Estimator \code{"SuperLearner"} implements the super learner prediction methods.
Note that if \code{"h2o__ensemble"} fails, it falls back on {"SuperLearner"}. If \code{"SuperLearner"} fails, 
it falls back on {"speedglm__glm"}. If \code{"speedglm__glm"} fails, it falls back on {"glm__glm"}.}

\item{gestimator}{A string specifying default estimator for exposure mechanism fitting. It has the same options as \code{Qestimator}.}

\item{bin.method}{Specify the method for choosing bins when discretizing the conditional continuous exposure variable \code{A}.
The default method is \code{"equal.mass"}, which provides a data-adaptive selection of the bins based on equal mass/ area, i.e., 
each bin will contain approximately the same number of observations as otheres. Method \code{"equal.len"} partitions the range of 
\code{A} into equal length \code{nbins} intervals. Method \code{"dhist"} uses a combination of the above two approaches. Please
see Denby and Mallows "Variations on the Histogram" (2009) for more details. Note that argument \code{maxNperBin} controls
the maximum number of observations in each bin.}

\item{nbins}{When \code{bin.method = "equal.len"}, set to the user-supplied number of bins when discretizing a continous variable/
If not specified, then default to 5; If setting to as \code{NA}, then set to the nearest integer of \code{nobs/ maxNperBin}, where
\code{nobs} is the total number of observations in the input data. When method is \code{"equal.mass"}, \code{nbins} will be set as 
the maximum of the default \code{nbins} and the nearest integer of \code{nobs/ maxNperBin}.}

\item{maxncats}{Integer that specifies the maximum number of unique categories a categorical variable \code{A[j]} can have. If 
\code{A[j]} has more unique categories, it is automatically considered a continuous variable. Default to 10.}

\item{maxNperBin}{Integer that specifies the maximum number of observations in each bin when discretizing a continuous variable 
\code{A[j]} (applies directly when \code{bin.method =} \code{"equal.mass"} and indirectly when \code{bin.method = "equal.len"}, but 
\code{nbins = NA}).}

\item{parfit}{Logical. If \code{TRUE}, perform parallel regression fits and predictions for discretized continuous variables by 
functions \code{foreach} and \code{dopar} in \code{foreach} package. Default to \code{FALSE}. Note that it requires 
registering a parallel backend prior to running \code{tmleCommunity} function, e.g., using \code{doParallel} R package and running 
\code{registerDoParallel(cores = ncores)} for \code{ncores} parallel jobs.}

\item{poolContinVar}{Logical. If \code{TRUE}, when fitting a model for binirized continuous variable, pool bin indicators across
all bins and fit one pooled regression. Default to \code{FALSE}.}

\item{savetime.fit.hbars}{Logical. If \code{TRUE}, skip estimation and prediction of exposure mechanism P(A|W,E) under g0 & gstar
when \code{f.gstar1 = NULL} and \code{TMLE.targetStep = "tmle.intercept"}, and then directly set \code{h_gstar_h_gN = 1} for each 
observation. Default to \code{TRUE}.}

\item{h2ometalearner}{A string to pass to \code{\link{h2o.ensemble}}, specifying the prediction algorithm used to learn the optimal 
combination of the base learners. Supports both h2o and SuperLearner wrapper functions. Default to "h2o.glm.wrapper".}

\item{h2olearner}{A string or character vector to pass to \code{\link{h2o.ensemble}}, naming the prediction algorithm(s) used to train
the base models for the ensemble. The functions must have the same format as the h2o wrapper functions. Default to "h2o.glm.wrapper".}

\item{CVfolds}{Set the number of splits for the V-fold cross-validation step to pass to \code{\link{SuperLearner}} and 
\code{\link{h2o.ensemble}}. Default to 5.}

\item{SL.library}{A string or character vector of prediction algorithms to pass to \code{\link{SuperLearner}}. Default to 
c("SL.glm", "SL.step", "SL.glm.interaction"). For more available algorithms see \code{SuperLearner::listWrappers()}.
Additional wrapper functions are available at 
\href{https://github.com/ecpolley/SuperLearnerExtra}{https://github.com/ecpolley/SuperLearnerExtra}.}
}
\value{
Invisibly returns a list with old option settings.
}
\description{
Additional options that control the estimation algorithm in \code{tmleCommunity} package  
}
\examples{
#***************************************************************************************
# Example 1: using different estimators in estimation of Q and g mechanisms
#***************************************************************************************
# 1.1 using speed.glm (and glm)
tmleCom_Options(Qestimator = "speedglm__glm", gestimator = "speedglm__glm")
tmleCom_Options(Qestimator = "speedglm__glm", gestimator = "glm__glm")

# 1.2 using SuperLearner
library(SuperLearner)
# library including "SL.glm", "SL.glmnet", "SL.ridge", and "SL.stepAIC"
tmleCom_Options(Qestimator = "SuperLearner", gestimator = "SuperLearner", CVfolds = 5,
                SL.library = c("SL.glm", "SL.glmnet", "SL.ridge", "SL.stepAIC"))

# library including "SL.bayesglm", "SL.gam", and "SL.randomForest", and split to 10 CV folds
# require("gam"); require("randomForest")
tmleCom_Options(Qestimator = "SuperLearner", gestimator = "SuperLearner", CVfolds = 10,
                SL.library = c("SL.bayesglm", "SL.gam", "SL.randomForest"))

# Create glmnet wrappers with different alphas (the default value of alpha in SL.glmnet is 1)
create.SL.glmnet <- function(alpha = c(0.25, 0.50, 0.75)) {
  for(mm in seq(length(alpha))){
    eval(parse(text = paste('SL.glmnet.', alpha[mm], '<- function(..., alpha = ', 
                            alpha[mm], ') SL.glmnet(..., alpha = alpha)', sep = '')), 
         envir = .GlobalEnv)
  }
  invisible(TRUE)
}
create.SL.glmnet(seq(0, 1, length.out=3))  # 3 glmnet wrappers with alpha = 0, 0.5, 1
# Create custom randomForest learners (set ntree to 100 rather than the default of 500) 
create.SL.rf <- create.Learner("SL.randomForest", list(ntree = 100))
# Create a sequence of 3 customized KNN learners 
# set the number of nearest neighbors as 8 and 12 rather than the default of 10
create.SL.Knn <- create.Learner("SL.kernelKnn", detailed_names=TRUE, tune=list(k=c(8, 12)))
SL.library <- c(grep("SL.glmnet.", as.vector(lsf.str()), value=TRUE), 
                create.SL.rf$names, create.SL.Knn$names)
tmleCom_Options(Qestimator = "SuperLearner", gestimator = "SuperLearner", 
                SL.library = SL.library, CVfolds = 5)            

# 1.3 using h2o.ensemble
library("h2o"); library("h2oEnsemble")
# h2olearner including "h2o.glm.wrapper" and "h2o.randomForest.wrapper"
tmleCom_Options(Qestimator = "h2o__ensemble", gestimator = "h2o__ensemble", 
                CVfolds = 10, h2ometalearner = "h2o.glm.wrapper", 
                h2olearner = c("h2o.glm.wrapper", "h2o.randomForest.wrapper"))

# Create a sequence of customized h2o glm, randomForest and deeplearning wrappers 
h2o.glm.1 <- function(..., alpha = 1, prior = NULL) { 
  h2o.glm.wrapper(..., alpha = alpha, , prior=prior) 
}
h2o.glm.0.5 <- function(..., alpha = 0.5, prior = NULL) { 
  h2o.glm.wrapper(..., alpha = alpha, , prior=prior) 
}
h2o.randomForest.1 <- function(..., ntrees = 200, nbins = 50, seed = 1) {
  h2o.randomForest.wrapper(..., ntrees = ntrees, nbins = nbins, seed = seed)
}
h2o.deeplearning.1 <- function(..., hidden = c(500, 500), activation = "Rectifier", seed = 1) {
  h2o.deeplearning.wrapper(..., hidden = hidden, activation = activation, seed = seed)
}
h2olearner <- c("h2o.glm.1", "h2o.glm.0.5", "h2o.randomForest.1", 
                "h2o.deeplearning.1", "h2o.gbm.wrapper")
tmleCom_Options(Qestimator = "h2o__ensemble", gestimator = "h2o__ensemble",
                SL.library = c("SL.glm", "SL.glmnet", "SL.ridge", "SL.stepAIC"), CVfolds = 5,
                h2ometalearner = "h2o.deeplearning.wrapper", h2olearner = h2olearner)

# using "h2o.deeplearning.wrapper" for h2ometalearner
tmleCom_Options(Qestimator = "h2o__ensemble", gestimator = "h2o__ensemble",
                SL.library = c("SL.glm", "SL.glmnet", "SL.ridge", "SL.stepAIC"), CVfolds = 5,
                h2ometalearner = "h2o.deeplearning.wrapper", h2olearner = h2olearner)

#***************************************************************************************
# Example 2: Define the values of bin cutoffs for continuous outcome in different ways
# through three arguments - bin.method, nbins, maxNperBin 
#***************************************************************************************
# 2.1 using equal-length method
# discretize a continuous outcome variable into 10 bins, no more than 1000 obs in each bin 
tmleCom_Options(bin.method = "equal.len", nbins = 10, maxNperBin = 1000)

# 2.2 find a compromise between equal-mass and equal-length method
# discretize into 5 bins (default), and no more than 5000 obs in each bin
tmleCom_Options(bin.method = "dhist", nbins = 10, maxNperBin = 5000)

# 2.3 Default to use equal-mass method with 5 bins, no more than 500 obs in each bin
tmleCom_Options()
}
\seealso{
\code{\link{print_tmleCom_opts}}
}
