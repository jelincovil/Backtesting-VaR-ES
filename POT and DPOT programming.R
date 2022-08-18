  
	#######################################
	### DPOT Programming Araujo e Alves ###
	#######################################

#### For running this example we suggest to download the daily
#### prices of SP 500 index with at least the first 1001 days,
#### compute the returns and save them in the file
#### with the name SP_500.txt
#### Choose coverage <- 0.01 to forecast VaR(0.01)
#### Choose c <- 0.75 to implement the DPOT(c=0.75)
#### Choose th <- 0.1 to implement a threshold such that
#### 10% of the values are larger than the threshold

#coverage <- 0.05
#c <- 0.75
#th <- 0.1

#### log-likelihood function which takes three arguments: theta is
#### the vector of parameters, y the excesses and x the durations:

gpdlik <- function(theta,y,x){
alpha1 <- theta[1]
gamma <- theta[2]
n<-length(y)
logl<- -sum(log(alpha1*(1/x)^c))-(1/gamma+1)*sum(log(1+gamma*y/(alpha1*(1/x)^c)))
return(-logl)
}

RiskDPOT <- function(xx,th,c, coverage){
#### We read the log returns from the text file SP_500.txt.
#### Then we compute the symmetric of log returns and choose the
#### returns from day 1 until day 1000, to illustrate the
#### calculation of one-day VaR forecast for day 1001

b <- xx*-1  
len <- length(b)

#### Calculation of excesses and durations
#### since the preceding 3 excesses

b_sort <-sort(b, decreasing = TRUE)
u <-  b_sort[floor(th*len)+1]
bb <- b[b>u]
bb <- bb -u
duration <- 1
j <- 1
xexc <- rep(0,times=length(bb))
for(ii in 1:len){
if (b[ii]>u){
xexc[j] <- duration
duration <- 1
j <- j+1
}
else {
duration <-duration+1
}
}
lag1_xexc <-rep(0,times=length(bb))
d2 <-rep(0,times=length(xexc))
limit <- length(xexc)-1
xxxx <- xexc[1:limit]
lag1_xexc <- c(0, xxxx)
limit2 <- length(xexc)-2
xxxx <- xexc[1:limit2]
lag2_xexc <- c(0, 0, xxxx)

limit3 <- length(bb)
bb <- bb[3:limit3]
xexc <- xexc[3:limit3]
lag1_xexc <- lag1_xexc[3:limit3]
lag2_xexc <- lag2_xexc[3:limit3]
d3 <- xexc+lag1_xexc+lag2_xexc
#### durations since the preceding 3 excesses (v=3)
#### We use the optim with Nelder and Mead algorithm to
#### maximize the log likelihood

model <- try ( optim(c(0.5,0.5), gpdlik, y=bb, x=d3), silent=TRUE )
mle1 <- model$par[1]
mle2 <- model$par[2]
#### With the VaR DPOT estimator we compute the forecast
delta <- mle1*(1/(duration+xexc[length(xexc)]+xexc[length(xexc)-1]))^c
var_forecast <- u + ((th/coverage)^mle2-1)*(delta/mle2)

es_forecast<- (var_forecast/(1-mle2)) + (delta - mle2*u)/(1-mle2)

#### One-day-ahead VaR forecast:
return (c(-var_forecast, -es_forecast))
}

		#####################################
		### POT Programming Jaime e Jaime ###
		#####################################

RiskPOT<- function(x,th,coverage){ 

b <- x*-1  ; len <- length(b) ; th <- th
b_sort <-sort(b, decreasing = TRUE)
u <-  b_sort[floor(th*len)+1] 
ajuste = pot(b,threshold=u)
risco <- riskmeasures(ajuste, 1-coverage)
VaRpot <- risco[2]
fit= gpdFit(b,threshold =th, method = "mle")
sigmamle=as.numeric(fit$par.ests[1])
gammamle= as.numeric(fit$par.ests[2])
ESPOT<- (VaRpot/(1-gammamle)) + (sigmamle- gammamle*u)/(1- gammamle)
return( c(- VaRpot, -ESPOT) )
}

