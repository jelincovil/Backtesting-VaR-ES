# Prueba de hipótesis para evaluar las previsiones del *Value-at-Risk*, *Expected Shortfall* y *Expectiles*
Autores: Dra. Chang Chann. IME USP.
         Dr. Jaime Lincovil. 

**Resumen:** La evaluación de pronósticos de medidas de riesgo, tales como Value-at-Risk (VaR) y Expected Shortfall (ES), 
es una actividad muy relevante para las instituciones financieras. Las pruebas de hip\'otesis que realizan esta evaluación se 
introdujeron con el objetivo de verificar la eficiencia de estas predicciones. En este trabajo comparamos el poder empírico de nuevas 
clases de pruebas de evaluación presentes en la literatura. Ademá, usamos estos procedimientos para evaluar la eficiencia de las 
predicciones generadas por el método Simulación Histórica y métodos basados en la distribuci\'on generalizada de Pareto. 
Para evaluar las predicciones del VaR, la clase de pruebas Geom\'etrico--VaR se destac\'o por tener un mayor poder empi\'ico que las 
dem\'as pruebas en los escenarios simulados. Esto destaca las ventajas de trabajar con duraciones discretas e incluir covariables en los 
modelos de prueba. Para evaluar las predicciones de ES, aquellas basadas en distribuciones condicionales de la rentabilidad del VaR mostraron 
una alta potencia para tama\~nos de muestra grandes. Adicionalmente, mostramos que el m\'etodo basado en la distribución de Pareto generalizada
utilizando duraciones y covariables resulta en un excelente desempeño en las predicciones VaR y ES de acuerdo a la evaluaci\'on realizada por 
las pruebas consideradas. 

**Palabras-clases:** Cobertura Condicional, Expected Shortfall, Poder empírico,  Prueba de evaluación, Value-at-Risk.

Nota: el texto completo lo pueden encontrar en portugues [Chang y Lincovil (2019)](https://bibliotecadigital.fgv.br/ojs/index.php/rbfin/article/view/78758).
Con motivos de difusión del conocimiento, en el pdf añadimos el conceptos *Expectil* y ejemplos.

## VaR, infraciones del VaR, duraciones y  ES

Sea $P_t$ el precio de un activo en el instante $t$ y $r_{t}= \log(P_{t}) - \log(P_{t-1})$ el correspondiente log-retorno (o simplemente retorno) al instante $t$. Para un $R_t=(P_t-P_{t-1})/P_t$ pequeno, se sabe que $r_t \approx R_t$, es decir, el retorno $r_t$ representa aproximadamente la variación de precios del activo desde el tiempo $ t-1$ a $t$. El VaR en el tiempo $t$ con probabilidad $p \in (0,1)$ y el $p$-cuantil $\inf\{l: F_t(l)\geq p\}$, donde $F_t $ es la función de distribución acumulada del retorno $r_t$. En particular, a continuación se da la definición formal de la previsión de VaR para una posición larga para distribuciones continuas.


::: Definition
Definimos la predicci\'on $\textnormal{VaR}_{t | t-1}(p)$ realizado en el tiempo $t-1$ con un horizonte de una unidad de tiempo y con probabilidad de cobertura $p$, como el $p$--cuantil que satisface 
$$
p= \textnormal{Pr} \Big[ r_{t}  <  \textnormal{VaR}_{t  | t-1}(p) \ | \Omega_{t-1} \Big],
$$
donde   $\Omega_{t-1}$ es  un conjunto que contiene   informaciones  hasta el tiempo $t-1$.
:::


## Referencias

- Berkowitz, J., Christoffersen, P., \& Pelletier, D. (2011). Evaluating value--at--risk models with desk--level data. Management Science, 57(12), 2213--2227.

- Candelon, B., Colletaz, G., Hurlin, C., \& Tokpavi, S. (2010). Backtesting value-at-risk: a GMM duration-based test. Journal of Financial Econometrics, 9(2), 314--343.

- Christoffersen, P. F. (1998). Evaluating interval forecasts. International economic review, 841--862.

