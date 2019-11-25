# Programacion:  Tests de Evaluacion del VaR y del ES.
# Jaime Lincovil & Chang Chann 2019.
# Revista: Revista Brasileira de Finan?as (Portugues)

# Funci?n que genera duraciones  con censura y el  vector de indicadoras C
Durcen <- function (outsample, VaR){
  
  Hit = ifelse(outsample < VaR, 1, 0) 
  T = sum(Hit)
  SS = length(Hit)
  D = diff(which(Hit == 1)) 
  C = rep(0, length(D))
  
  if (Hit[1] == 0) {
    C = c(1, C)
    D = c(which(Hit == 1)[1], D)
  }
  
  if (Hit[SS] == 0) {
    C = c(C, 1)
    D = c(D, SS - tail(which(Hit == 1), 1))
  }
  return ( list ( D=D,C=C)  )
  
}


varselect<- function(v,t){ #  N?mero de duraci?nes
  T<- length(v)
  if(t=="0" | t>T){vi<- 0} else { vi<- v[t] } 
  return(vi)
}


# Tiempo de las  duraciones con censura
tvarcen<- function(Hit,D,c){
  
  N<- length(D)
  if( c[1]==1&c[N]==1 ){
    tt = which(Hit == 1)
    t= c(tt, length(Hit))
  }
  
  if( c[1]==1&c[N]==0 ){
    t = which(Hit == 1)
  }
  
  if( c[1]==0&c[N]==1 ){
    ti<- rep(0,N-1)
    for( i in 1:(N-1) ){
      tt <- 1+ sum (D[1:i])
      ti[i]<- tt
    }
    t <- c(ti, length(Hit))   
  }
  
  if( c[1]==0&c[N]==0 ){  
    ti<- rep(0,N-1)
    for( i in 1:(N-1) ) 
    {
      tt <- 1+ sum (D[1:i])
      ti[i]<- tt
    }
    t <- c(ti, length(Hit))
  }
  return (t)
}

# Tiempo de origen de las  duraciones con censura

tdorigcen <- function(Hit,D,c){ 
  N<- length(D)
  if( c[1]==1&c[N]==1 ) {
    t<- rep(0,N-1)		
    for(i in 1:(N-1))
    { tt <-  sum (D[1:i])
    t[i]<- tt
    }
    ti_1 <- c(0 , t)	
  }     	         
  
  if( c[1]==1&c[N]==0 )
  {
    t<- rep(0,N-1) 		
    for(i in 1:(N-1))
    { tt <- sum( D[1:i])
    t[i]<- tt
    }
    ti_1 <- c(0 , t)
  }
  
  if( c[1]==0&c[N]==1 )
  {
    t<- rep(0,N-1)
    for( i in 1:(N-1) ) 
    {
      tt <- 1+ sum (D[1:i])
      t[i]<- tt
    }
    ti_1 <-c(1,t) 
  }
  
  if( c[1]==0&c[N]==0 )
  {
    t<- rep(0,N-1)
    for( i in 1: (N-1) ) 
    {
      tt <- 1+ sum (D[1:i])
      t[i]<- tt
    }
    ti_1 <- c(1,t)			
  }
  
  return (ti_1)  
}

varselect<- function(v,t) {			   
  T<- length(v)
  if(t=="0" | t>T){vi<- 0} else { vi<- v[t] } 
  return(vi)
}

# Funciones  g y h: modelo Logaritmo linear
h0<- function(u){out<- log(u);return(out) }
g0<- function(u){out<- exp(u); return(out)}

# Funciones g y h: modelo logistico 
g1<-function(u){out<- exp(u)/( 1+exp(u) ); return(out)}
h1<- function(u ){out<- log(u/(1-u)); return(out)}

# Funciones  ligaci?n: modelo Probito
g3<-function(u){out<- pnorm(u, mean = 0, sd = 1); return(out)}
h3<- function(u ){out<- qnorm(u, mean = 0, sd = 1); return(out)}

# Funci?n de Risco Dattero & Stein (1984)
lambda<- function(para,t){ 
  pi<- para[1]
  b<- para[2] 
  vetor<- rep(0,length(t))
  for(s in 1:length(vetor)){vetor[s]<- pi*(t[s])^(b-1)}
  return(vetor) }

# Funci?n de Log-verosimilitud negativa

nLWD <- function (theta, D, Indcen, Hit, VAR, lig){ 
  
  if(lig=="0"){g<- g0 ; h<- h0}
  if(lig=="1"){g<- g1 ; h<- h1}
  if(lig=="2"){g<- g2 ; h<- h2}
  if(lig=="3"){g<- g3 ; h<- h3}
  
  pi <- theta[1]
  b  <- theta[2]
  Beta <- theta[3]
  
  V   <- abs(VAR) 
  N <- length(D)                 
  tci <- tvarcen(Hit,D, Indcen)  
  VaRj <- rep (0, length(tci )) 
  for (i in 1: length (tci )) { VaRj[i]<- varselect( V, tci[i])}
  
  NN<- length(VaRj)
  vector1 <- rep(0, N)
  vector2 <- rep(0, N)	
  
  for(i in 1:N){
    vector1[i]<- log( g( h( lambda(c(pi,b),D[i]) ) - Beta*VaRj[i] ))
    tor<- tdorigcen(Hit,D,Indcen)
    j <- seq(1, D[i]-1)
    var<- 0
    for(t in 1:length(j) ){var[t]<- varselect(V,tor[i]+ t) }
    if(D[i]!="1"){ vector2[i] <- sum(log(1- g( h( lambda(c(pi,b),j) ) - Beta*var )))} else {vector2[i]= 0 }
  }
  
  nll <- - ( sum(vector1, na.rm=TRUE)
             + Indcen[1]*log( (1-  g ( h(lambda(c(pi,b),D[1])) - Beta*VaRj[1]) ) /g ( h(lambda(c(pi,b),D[1])) - Beta*VaRj[1]) )
             + Indcen[N]*log( (1-  g (h(lambda(c(pi,b),D[N])) - Beta*VaRj[NN]))/g (h(lambda(c(pi,b),D[N])) - Beta*VaRj[NN]))
             +  sum( vector2,na.rm=TRUE) )
  return(nll)
}



# Test CAViaR  Berkowtiz et al (2010) 

Caviar.cc <- function(conf.level, coverage, outsample, VaR){
  
  hit = ifelse(outsample < VaR, 1, 0)
  tt<- length (outsample)
  m_tt<- tt-1
  hit1 <- hit[1:m_tt]
  hit2 <- hit[2:tt]
  VaR2 <- VaR[2:tt] 
  
  mylogit<- glm(hit2 ~ hit1+ VaR2, family=binomial(link="logit"), na.action=na.pass)
  logLik(mylogit)
  delta0.mv <-  -log(length(hit)/sum(hit)- 1)                             # alpha.mv sobre Hzero
  delta0 <- log( coverage/ (1- coverage) )
  
  
  emv <- mylogit$coefficients
  emv1 <- emv[1]
  emv2 <- emv[2]
  emv3 <- emv[3]
  
  l.h1 <-  sum ( hit2*(emv1+emv2*hit1+emv3*VaR2)) -  sum (log(1+ exp(emv1+emv2*hit1+emv3*VaR2)))            
  l.h0 <- sum( hit2*delta0 ) - (tt-1)*log( 1+exp(delta0) )  
  
  CAViaR.cc <-  -2*(l.h0  - l.h1)
  crit_value <- qchisq( 1- conf.level , 3, lower.tail = FALSE ) 
  
  return (  list( RV= CAViaR.cc , crit= crit_value, delta= c(emv1, emv2,emv3)  ) )
  
}


# Tests GMM Candelon (2008)

gmm.cc <-  function (conf.nivel, coverage, outsample, VaR){
  
  objeto<- Durcen(outsample,VaR)
  D<- objeto$D
  N<- length(D)
  alpha<- coverage
  
  
  m1.a <- (1-alpha*D)/sqrt(1-alpha)
  m2.a <- (3 - alpha - alpha*D)*(1-alpha*D)/(2-2*alpha)-0.5
  m3.a <- (5-2*alpha - alpha*D)/(3*sqrt(1-alpha))*m2.a-(2/3)*m1.a
  m4.a <- (7-3*alpha - alpha*D)/(4*sqrt(1-alpha))*m3.a-(3/4)*m2.a
  m5.a <- (9-4*alpha- alpha*D)/(5*sqrt(1-alpha))*m4.a-(4/5)*m3.a
  
  mm1.a <- sum(m1.a)/sqrt(N)
  mm2.a <- sum(m2.a)/sqrt(N)
  mm3.a <- sum(m3.a)/sqrt(N)
  mm4.a <- sum(m4.a)/sqrt(N)
  mm5.a <- sum(m5.a)/sqrt(N)
  
  j.cc3 <- mm1.a^2+ mm2.a^2+ mm3.a^2
  j.cc5 <- mm1.a^2+ mm2.a^2+ mm3.a^2+ mm4.a^2 + mm5.a^2
  
  
  crit.value3<- qchisq(conf.nivel, 3, lower.tail = TRUE, log.p = FALSE)
  crit.value5<- qchisq(conf.nivel, 5, lower.tail = TRUE, log.p = FALSE)
  
  out<- list(J3.cc= j.cc3,J5.cc = j.cc5 ,crit.value3,crit.value5)
  names(out)<- c( "J3.cc" ,"J5.cc", "Valorcritico3" ,"Valorcritico5"  )
  
  return(out)
}


## Teste GVaR Pelletier and Wei (2015)
GeoVaR <- function(conf.level ,p , outsample, VaR,lig,star){
  cd_am <- Durcen (outsample ,VaR)
  D <-cd_am$D
  c <-cd_am$C 
  N<-length(D)
  hit = ifelse(outsample < VaR, 1, 0)
  
  if(lig=="0" ){ LOWER<- c(0.001,0,0) ; UPPER<- c(0.999,1, 1.5) } 
  if(lig== "1"){ LOWER<- c(0.001,0,0) ;UPPER<- c(0.99,1, 1.5)}  
  if(lig=="2"){ LOWER<- c(0.0001,0,-0.05) ; UPPER<- c(0.99,1, 3)} 
  if(lig=="3" ){ LOWER<- c(0.001,0,-1.5) ; UPPER<- c(0.99,1, 1.5)}  
  
  outnLVCox  <- try( optim(par=star , nLWD ,  D=D, Indcen=c, Hit=hit, VAR=VaR,lig=lig, method= "L-BFGS-B",
                           lower = LOWER, upper = UPPER ), silent=TRUE)
  
  if ( class(nLWD) == "try-error"){ l.h1 <- NA ; Beta <- NA }else{l.h1 <- - outnLVCox$value ;Beta<- outnLVCox$par[3]  }
  theta<- c(p,1)		
  l.h0 <- -  nLVGeo2(theta,D,c)
  RV_gv <- -2*(  l.h0 - l.h1  )
  crit_value<- qchisq(conf.level, 3, lower.tail = TRUE, log.p = FALSE)
  return ( list(RV= RV_gv, crit= crit_value, Beta=Beta)  )
}

# Programacion del test 1 y 2.
# Acerbi and Szekely (2014)
# Test estadistico pos amostral
# a:= vector pos-amostra  
# b:= vector previsiones para ES
# VaR: vector previsiones del VaR

ES_test1<- function(a, b, VaR){
  Hit = ifelse(a < VaR, 1, 0) 
  Nt= sum(Hit)
  Zt= ( sum(a*Hit/b) / Nt) -1 
  return(Zt)  
}

ES_test2<- function(a,b, VaR, coverage){
  Hit = ifelse(a < VaR, 1, 0) 
  T= length(Hit)
  Zt= ( sum(a*Hit/b) / T*coverage) -1 # revisar.
  return(Zt)  
}

# Adapaci?n  test de  Righi and Ceretta (2013)


ES_test3<- function(a, b, c,VaR){
  Hit = ifelse(a < VaR, 1, 0) 
  Zt=  sum( ( (a-b)/c )*Hit  )/sum(Hit)   
  return(Zt)  
}



