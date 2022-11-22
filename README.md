# Prueba de hipótesis para evaluar las previsiones del *Value-at-Risk*, *Expected Shortfall* y *Expectiles*
Autores: 
- Dra. Chang Chann [IME USP](https://www.ime.usp.br/~chang/home/index.php)
- Dr. Jaime Lincovil [Linkedin](https://cl.linkedin.com/in/jaime-enrique-lincovil-curivil-973a9b186) 

**Resumen:** <div align="justify">La evaluación de pronósticos de medidas de riesgo, tales como Value-at-Risk (VaR) y Expected Shortfall (ES), 
es una actividad muy relevante para las instituciones financieras. Las pruebas de hip\'otesis que realizan esta evaluación se 
introdujeron con el objetivo de verificar la eficiencia de estas predicciones. En este trabajo comparamos el poder empírico de nuevas 
clases de pruebas de evaluación presentes en la literatura. Ademá, usamos estos procedimientos para evaluar la eficiencia de las 
predicciones generadas por el método Simulación Histórica y métodos basados en la distribuci\'on generalizada de Pareto. 
Para evaluar las predicciones del VaR, la clase de pruebas Geom\'etrico--VaR se destac\'o por tener un mayor poder empi\'ico que las 
dem\'as pruebas en los escenarios simulados. Esto destaca las ventajas de trabajar con duraciones discretas e incluir covariables en los 
modelos de prueba. Para evaluar las predicciones de ES, aquellas basadas en distribuciones condicionales de la rentabilidad del VaR mostraron 
una alta potencia para tama\~nos de muestra grandes. Adicionalmente, mostramos que el m\'etodo basado en la distribución de Pareto generalizada
utilizando duraciones y covariables resulta en un excelente desempeño en las predicciones VaR y ES de acuerdo a la evaluaci\'on realizada por 
las pruebas consideradas. </div>

**Palabras-clases:** Cobertura Condicional, Expected Shortfall, Poder empírico,  Prueba de evaluación, Value-at-Risk.

Nota: el texto completo lo pueden encontrar en portugues [Chang y Lincovil (2019)](https://bibliotecadigital.fgv.br/ojs/index.php/rbfin/article/view/78758).
Con motivos de difusión del conocimiento, en el pdf añadimos el conceptos *Expectil* y ejemplos.

## VaR, infraciones del VaR, duraciones y  ES

Sea $P_t$ el precio de un activo en el instante $t$ y $r_{t}= \log(P_{t}) - \log(P_{t-1})$ el correspondiente log-retorno (o simplemente retorno) al instante $t$. Para un $R_t=(P_t-P_{t-1})/P_t$ pequeno, se sabe que $r_t \approx R_t$, es decir, el retorno $r_t$ representa aproximadamente la variación de precios del activo desde el tiempo $t-1$ a $t$. El VaR en el tiempo $t$ con probabilidad $p \in (0,1)$ y el $p$-cuantil $\inf\{l: F_t(l)\geq p\}$, donde $F_t$ es la función de distribución acumulada del retorno $r_t$. En particular, a continuación se da la definición formal de la previsión de VaR para una posición larga para distribuciones continuas.


**Definición**
Definimos la predicción $\textnormal{VaR}_{t | t-1}(p)$ realizado en el tiempo $t-1$ con un horizonte de una unidad de tiempo y con probabilidad de cobertura $p$, como el $p$--cuantil que satisface 

$$
p= \textnormal{Pr} \Big[ r_{t}  <  \textnormal{VaR}_{t  | t-1}(p) \ | \Omega_{t-1} \Big],
$$

donde   $\Omega_{t-1}$ es  un conjunto que contiene   informaciones  hasta el tiempo $t-1$.

Esta previsión del VaR puede considerarse como una medida de  variación máxima negativa de las rentabilidades. En este caso, cuando la rentabilidad tiene una variación negativa mayor a la prevista por el VaR, se entiende que la variación de la rentabilidad violó el límite establecido por el VaR. Este hecho es conocido en la literatura como *infración* de la predicción del VaR. Definimos la variable indicadora de infración del VaR como:

$$
I_{t} = \left\{
\begin{array}{l l}
1 \ , & \textrm{ si $r_{t}  <  \text{VaR}_{t  | t-1  }(p), $  } \\
0 \ , & \textrm{ caso contrario.}\\
\end{array}
\right. 
$$

Además, definimos la duración de la $i$-ésima infración del VaR por:

$$
 D_i = t_i - t_{i-1},
$$

donde $t_{i}$ denota el instante de la $i$-ésima infración del VaR. Para $i=1$ asumimos que $t_0=0$.

Otra medida de riesgo muy utilizada hoy en día es el ES. El ES fue introducido por Rappoport (1993) y luego Artzner (1997)-Artzner(1999) estudió formalmente sus propiedades.  El ES $(p)$ asociado al  VaR $(p)$ es definido por $\mbox{ES}(p)=1/(1-p)\int_{p}^1\mbox{VaR}(u)du$. De forma simplificada, el ES es  la pérdida esperada dado que la rentabilidad viola el VaR, es decir $\mbox{ES}(p)= \mathbb{E}\big[r_t \ | r_t < \mbox{VaR}(p)\big]$. La definición de predicción ES de un paso adelante se da a continuación.

**Definición**
Definimos el pron\'ostico $\text{ES}_{t|t-1}(p)$ realizado en el tiempo $t-1$ con un horizonte de una unidad de tiempo asociado al pronóstico $\mbox{VaR}_{t|t-1}(p)$, que satisface $p=Pr\big( r_t< \textnormal{\mbox{VaR}}_{t|t-1 }(p) \ |\Omega_{t-1} \big)$ para una información pasada $\Omega_{t-1}$, como la esperanza condicional:

$$
\textnormal{ES}_{t|t-1}(p)= \mathbb{E}\Big[r_t \ | r_t \leq \textnormal{VaR}_{t|t-1}(p) \Big]. 
$$

Como es descrito en la literatura roccioletti (2015), las medidas VaR y ES no cumplen la propiedad de coherencia.  Una medida que generaliza los cuantiles y son a su vez coeherentes son los espectiles propuestos
Newey (1987) definidos a continuación.

La previsión de un espectil a partir de la serie de retornos hasta $r_{t-1}$ es dada por la siguiente solución de minimización:

$$
\mbox{EX}_{t|t-1}(p) = \arg \min_{r \in  \mathbb{R}} \left[ \Big|  p - I_{ \{ r_{t} <  r \}} \Big| (r_{t} - r )^2  \big|  \Omega_{t-1} \right] .
$$

El EX es una extensión del VaR que cumpleo la propiedad de coherencia. Análogamente, al ES , el CARES (Conditional Autoregressive Expected Shortfall) introducido por Taylor (2008) es dado por

$$
\textnormal{CARES}_{t|t-1}(p)= \mathbb{E}\big[r_t \ | r_t \leq \textnormal{EX}_{t|t-1}(p)   \big]. 
$$


## Avaluaciones de las previsiones generadas por los métodos POT e DPOT con códigos de R

En esta sección listo algunos códigos de R usados y los graficos obtenidos para este trabajo publicado. Comenzamos cargando las librerias
usadas en el analisis.

```{r}
# Códigos de R para el analisis de datos,
# estimación de pronosticos y sus evaluaciones
# Librerias básicas de R

require(evir)
require(moments)
require(PerformanceAnalytics)
require(eva)
library(forecast)
```
Luego cargamos los datos y verificas la existencia o no de Nas

```{r}
# Cargo los datos
raw <- read.csv("BVSP.csv", header=TRUE,  sep = "," ,
                stringsAsFactors=FALSE)
str(raw)
Dia <- as.Date(raw$Dia, format= "%Y-%m-%d")
data1 <- data.frame( Dia = Dia, 
                     BVSP = as.numeric(raw$Adj.Close) )
summary(data1)

# Cuento los  Na
sum(is.na(data1$BVSP))

# Grafico y verifico los datos perdidos
tsoutliers(data1$BVSP)
data1 <- data.frame( Dia1 = Dia, 
                     ibovespa= tsclean(data1$BVSP, 
                                       replace.missing = TRUE,  lambda = 2.4) )
# Transformo a log-retornos y seleccion
# datos de entrenamiento y test
retornos <- diff (log(data1$ibovespa))
data2 <- data.frame(Dia2 = Dia[2:2006], retornos= retornos)
data2 <- data2[1:2000,]
dim(data2)

data2 <- data.frame( Dia2 = data2$Dia2, 
                     retornos= tsclean(data2$retornos, 
                                       replace.missing = TRUE,  lambda = NULL) )

outsample <- data2$retornos[1001: 2000]
# Verifico que los datos no tengan NAs
sum(is.na(outsample))
sum(is.na(data2$retornos))
```

Los siguientes códigos obtienes los gráficos exploratorios
```{r}
plot(ibovespa~Dia1, data1,type="l",xlab= "Tempo", ylab=" Ibovespa")
axis.Date(1, Dia1, format(Dia, "%y/%m/%d"))

plot(retornos~Dia2, data2, type="l",xlab= "Tempo", ylab="Retornos do Ibovespa")

hist(data2$retornos, prob=TRUE, ylim = c(0, 33),
     xlab="", ylab="", main="")
  lines(density(data2$retornos), # density plot
      lwd = 2, # thickness of line
      col = "blue")

qqnorm(retornos, pch = 1, main = "",
       xlab="Quantis teóricos", ylab="Quantis amostrais")
qqline(retornos, col = "black", lwd = 2)

```


![plot](https://github.com/jelincovil/Backtesting-VaR-ES/blob/master/Figuras%20VaR/Figura1.jpg)
![plot](https://github.com/jelincovil/Backtesting-VaR-ES/blob/master/Figuras%20VaR/Figura2.jpg)
![plot](https://github.com/jelincovil/Backtesting-VaR-ES/blob/master/Figuras%20VaR/Figura3.jpg)
![plot](https://github.com/jelincovil/Backtesting-VaR-ES/blob/master/Figuras%20VaR/Figura4.jpg)


Aprovechamos de obtner estadistias de resumen

```{r}
# Analisis descriptivo numerico
> summary(retornos)
      Min.    1st Qu.     Median       Mean    3rd Qu.       Max. 
-0.0921069 -0.0082590  0.0002285  0.0002477  0.0089303  0.0638867 
> skewness(retornos)
 -0.1523737
> kurtosis(retornos)
 1.940382
> sd(retornos)
 0.01452887
```


Los parametros para el pronóstico de un dia adelante del VaR y ES fueron estimados en un estudio separado. Los siguientes códigos 
estiman el VaR y ES para la muestra de entrenamiento.

```{r}

tt <- 500   ;      ws <- 60               
coverage <- 0.05  ; c <-1
th1 <- 0.1 ;    th2 <-  0.35    

# I VaR usando DPOT  ###
               
kk<- tt-ws
sample<- retornos[kk:1999]
length(sample)

VaR.dpot <-rep(0, tt)
ES.dpot <-rep(0, tt)

for(i in 1:tt) {
iws <- i+ws
m_iws <- iws-1
b <- sample[i:m_iws]
quantil <- RiskDPOT(b,th1,c, coverage)
VaR.dpot[i] <- quantil[1]
ES.dpot[i] <- quantil[2]
}


tt <- 500                 ## size of the hit sequence
ws <- 60                  ## window size
coverage <- 0.05  ## probabilidade de cobertura
c <-1
th1 <- 0.1     ## Proporcao  limiar DPOT
th2 <-  0.35     ## POT

# I VaR usando DPOT  ###

kk<- tt-ws
sample<- retornos[kk:1999]
length(sample)

VaR.dpot <-rep(0, tt)
ES.dpot <-rep(0, tt)

for(i in 1:tt) {
 print(i)
iws <- i+ws
m_iws <- iws-1
b <- sample[i:m_iws]
quantil <- RiskDPOT(b,th1,c, coverage)
VaR.dpot[i] <- quantil[1]
ES.dpot[i] <- quantil[2]
}

# III VaR e ES  Empiricos 

VaRh <-rep(0, tt)
ES.h<- rep(0, tt)
for(i in 1:tt) {
  iws <- i+ws
  m_iws <- iws-1
  b <- retornos[i:m_iws]
  Qp <- quantile(b, coverage)
ES.h<- rep(0, tt)
for(i in 1:tt) {
  iws <- i+ws
  m_iws <- iws-1
  b <- retornos[i:m_iws]
  Qp <- quantile(b, coverage)
  yy <- mean(b[b<Qp])
  VaRh[i] <- Qp
  ES.h[i] <- yy
  print(i)
}

# III Var e ES R package 

VaRh <-rep(0, tt) ; ESh <-rep(0, tt)
for(i in 1:tt) {
  iws <- i+ws
  m_iws <- iws-1
  b <- sample[i:m_iws]
es <- ES(b,coverage, method = "historical")[1]
var<- VaR( b , 1-coverage, method = "historical", invert = TRUE) [1]
  VaRh[i] <- var
  ESh[i] <- es
    print(i)
}

```

El siguiente gráfico muestra la serie de entrenamiento y el pronosticos del VaR.

```{r}
matplot(cbind(outsample, VaRh,  VaR.pot , VaR.dpot ),
        ylab= "Retornos e previsoes do VaR",
        xlab="Tempo", type="l",  lwd = c(0.5, 2, 1.5, 3.5),
        col=1, lty=c(1, 1, 3, 3)  )

legend("bottomright",c("Retorno", "HS", "POT", "DPOT" ), lwd = c(0.5, 2, 1.5, 3),
       lty=c(1, 1, 3, 3), col = 1, cex = 0.55)


```
![plot](https://github.com/jelincovil/Backtesting-VaR-ES/blob/master/Figuras%20VaR/VaRws250_005.pdf)


El siguiente gráfico muestra la serie de entrenamiento y el pronosticos del ES.

```{r}
matplot(cbind(outsample, ESh, ES.pot, ES.dpot),
        ylab= "Retornos e previsoes do ES",
        xlab="Dias", type="l",  lwd = c(0.5, 2, 2, 3.5),
        lty=c(1, 1, 3, 3), col = 1 )
legend("bottomright",c("Retorno","HS", "POT", "DPOT" ), lwd = c(0.5, 2, 2, 3.5),
       lty=c(1, 1, 3, 3), col = 1 , cex = 0.55 )

```

![plot](https://github.com/jelincovil/Backtesting-VaR-ES/blob/master/Figuras%20VaR/ESws250_005.pdf)


## Referencias

- Berkowitz, J., Christoffersen, P., \& Pelletier, D. (2011). Evaluating value--at--risk models with desk--level data. Management Science, 57(12), 2213--2227.

- Candelon, B., Colletaz, G., Hurlin, C., \& Tokpavi, S. (2010). Backtesting value-at-risk: a GMM duration-based test. Journal of Financial Econometrics, 9(2), 314--343.

- Christoffersen, P. F. (1998). Evaluating interval forecasts. International economic review, 841--862.

