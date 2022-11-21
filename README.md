# Prueba de hipótesis para evaluar las previsiones del *Value-at-Risk*, *Expected Shortfall* y *Expectiles*
Autores: Dra. Chang Chann. IME USP.
         Dr. Jaime Lincovil. 

**Resumen:** <div align="center">La evaluación de pronósticos de medidas de riesgo, tales como Value-at-Risk (VaR) y Expected Shortfall (ES), 
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
Definimos la predicci\'on $\textnormal{VaR}_{t | t-1}(p)$ realizado en el tiempo $t-1$ con un horizonte de una unidad de tiempo y con probabilidad de cobertura $p$, como el $p$--cuantil que satisface 

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
Definimos el pron\'ostico $\mbox{ES}_{t|t-1}(p)$ realizado en el tiempo $t-1$ con un horizonte de una unidad de tiempo asociado al pronóstico $\mbox{VaR}_{t|t-1}(p)$, que satisface $p=Pr\big( r_t< \textnormal{\mbox{VaR}}_{t|t-1 }(p) \ |\Omega_{t-1} \big)$ para una información pasada $\Omega_{t-1}$, como la esperanza condicional:

$$
\textnormal{ES}_{t|t-1}(p)= \mathbb{E}\Big[r_t \ | r_t \leq \textnormal{VaR}_{t|t-1}(p) \Big]. 
$$

Como es descrito en la literatura roccioletti (2015), las medidas VaR y ES no cumplen la propiedad de coherencia.  Una medida que generaliza los cuantiles y son a su vez coeherentes son los espectiles propuestos
Newey (1987) definidos a continuación.

La previsión de un espectil a partir de la serie de retornos hasta $r_{t-1}$ es dada por la siguiente solución de minimización:

$$
\mbox{EX}_{t|t-1}(p) = \arg \min_{r \in  \mathbb{R}} \left\{ \Big|  p - I_{ \{ r_{t} <  r \}} \Big| (r_{t} - r )^2  \big|  \Omega_{t-1} \right\} .
$$

El EX es una extensión del VaR que cumpleo la propiedad de coherencia. Análogamente, al ES , el CARES (Conditional Autoregressive Expected Shortfall) introducido por Taylor (2008) es dado por

$$
\textnormal{CARES}_{t|t-1}(p)= \mathbb{E}\big[r_t \ | r_t \leq \textnormal{EX}_{t|t-1}(p)   \big]. 
$$

 
## Referencias

- Berkowitz, J., Christoffersen, P., \& Pelletier, D. (2011). Evaluating value--at--risk models with desk--level data. Management Science, 57(12), 2213--2227.

- Candelon, B., Colletaz, G., Hurlin, C., \& Tokpavi, S. (2010). Backtesting value-at-risk: a GMM duration-based test. Journal of Financial Econometrics, 9(2), 314--343.

- Christoffersen, P. F. (1998). Evaluating interval forecasts. International economic review, 841--862.

