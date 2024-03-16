 import excel "C:\Users\DELL\Documents\suicidios.xlsx", sheet("2019") firstrow
 
encode(Países), gen(pais_num)
encode(Cod), gen(cod_num)
encode Región, generate(region)
destring(Tasadesuicidiosporcada10000), gen(tsg_num)
destring(Tasademortalidadporsuicidio), gen(tsh_num)
destring(F), gen(tsm_num)
destring(Infalciónpreciosalconsumidor), gen(infla_num)
destring(PIBpercapitalUSapreciosa), gen(PPC_num)
destring(Balanzacomercialdebienesyse), gen (bcbs_num)
destring(GastocorrientedesaludGDP), gen(gsalud_num)
destring(Desempleototaldelapoblac), gen(up_num)
destring(GiniIndex), gen(GiniIndex_num)
destring(poblaciónporpaíses), gen(poblacion_num)
destring(Dosctoresporpais), gen(doctorespais_num)
destring(IDH), gen(IDH_num)
destring(GastopublicoeneducaciónPIB), gen(GPE_num)
destring(Empleovulnerablefemeninofemen), gen(EVM_num)
destring(Empleovulderablehombresdel), gen(EVH_num)
destring(Densidaddepoblaciónpersonasp), gen(DPPK_num)
destring(Superficieforestal), gen(SF_num)
 rename Densidaddepoblaciónpersonasp DDPK

//Región

. label define region 1 "Africaaltoingreso" 2 "Africaingresomedio" 3 "Africapobre" 4 "America Central" 5 "America Isla" 8 "Asia
>  " 7 "Europa " 6 "Latino America" 9 "Medio Oriente" 10 "Norte America" 11 "Oceania", replace

//missing values tsg_num
replace tsg_num = runiform(2.6, 6) if missing(tsg_num) & region == 4
replace tsg_num = runiform(0.3, 14.3) if missing(tsg_num) & region == 5
replace tsg_num = runiform(4.5, 27.4) if missing(tsg_num) & region == 7
replace tsg_num = runiform(2.1, 28.6) if missing(tsg_num) & region == 6
replace tsg_num = runiform(12, 15.7) if missing(tsg_num) & region == 10
replace tsg_num = runiform(2.9, 18.9) if missing(tsg_num) & region == 11

//missing values values tgh_num
replace tsh_num = runiform(4.8, 10.4) if missing(tsh_num) & region == 4
replace tsh_num = runiform(0, 22.7) if missing(tsh_num) & region == 5
replace tsh_num = runiform(6.2, 47.5) if missing(tsh_num) & region == 7
replace tsh_num = runiform(3.2, 41.2) if missing(tsh_num) & region == 6
replace tsh_num = runiform(17.9, 24.3) if missing(tsh_num) & region == 10
replace tsh_num = runiform(4.2, 48.2) if missing(tsh_num) & region == 11

//missing values values tgm_num_num
replace tsm_num = runiform(1, 2.2) if missing(tsm_num) & region == 4
replace tsm_num = runiform(0.3, 7.7) if missing(tsm_num) & region == 5
replace tsm_num = runiform(1.9, 11.9) if missing(tsm_num) & region == 7
replace tsm_num = runiform(0.8, 15.9) if missing(tsm_num) & region == 6
replace tsm_num = runiform(6.2, 7.2) if missing(tsm_num) & region == 10
replace tsm_num = runiform(1.5, 12.6) if missing(tsm_num) & region == 11

//missing values infla_num
replace infla_num = runiform(1.34988439, 4.74906652) if missing(infla_num) & region == 1
replace infla_num = runiform(-2.81469808, 83.5015295) if missing(infla_num) & region == 3
replace infla_num = runiform(0.76157836, 4.94723728) if missing(infla_num) & region == 4
replace infla_num = runiform(-1.03712214, 12.4814111) if missing(infla_num) & region == 5
replace infla_num = runiform(-0.22410325, 7.6065336) if missing(infla_num) & region == 8
replace infla_num = runiform(0.48837017, 10.9518559) if missing(infla_num) & region == 7
replace infla_num = runiform(-0.19510777, 18.0141183) if missing(infla_num) & region == 6
replace infla_num = runiform(0.25581558, 16.3324639) if missing(infla_num) & region == 9
replace infla_num = runiform(2.26822567, 2.4425833) if missing(infla_num) & region == 10
replace infla_num = runiform(0.56403049, 5.03209692) if missing(infla_num) & region == 11

//missing values PPC_num
replace PPC_num = runiform(238.783467, 2314.05096) if missing(PPC_num) & region == 3
replace PPC_num = runiform(1479.34583, 113023.186) if missing(PPC_num) & region == 5
replace PPC_num = runiform(2492.86897, 18703.8603) if missing(PPC_num) & region == 8
replace PPC_num = runiform(3096.5617, 185978.609) if missing(PPC_num) & region == 7
replace PPC_num = runiform(485.66419, 87526.08) if missing(PPC_num) & region == 6
replace PPC_num = runiform(1727.845, 57180.7794) if missing(PPC_num) & region == 11

//missing values bcbs_num

replace bcbs_num = runiform(-68.4365211, 1.02643957) if missing(bcbs_num) & region == 3
replace bcbs_num = runiform(-52.9230769, 26.0951539) if missing(bcbs_num) & region == 5
replace bcbs_num = runiform(-20.6415291, 4.96752226) if missing(bcbs_num) & region == 8
replace bcbs_num = runiform(-36.7577757, 32.7072672) if missing(bcbs_num) & region == 7
replace bcbs_num = runiform(-56.6569821, 49.4291739) if missing(bcbs_num) & region == 6
replace bcbs_num = runiform(-77.7800136, 0.35719983) if missing(bcbs_num) & region == 11

//missing values gsalud_num
replace gsalud_num = runiform(2.74500299, 8.85829735) if missing(gsalud_num) & region == 1
replace gsalud_num = runiform(2.50416446, 10.9953098) if missing(infla_num) & region == 3
replace gsalud_num = runiform(5.37870932, 8.58646584) if missing(gsalud_num) & region == 4
replace gsalud_num = runiform(4.41556692, 8.58646584) if missing(gsalud_num) & region == 5
replace gsalud_num = runiform(1.59628761, 11.4503889) if missing(gsalud_num) & region == 7
replace gsalud_num = runiform(2.24630332, 14.1267433) if missing(gsalud_num) & region == 6
replace gsalud_num = runiform(2.62514997, 8.67463875) if missing(gsalud_num) & region == 9
replace gsalud_num = runiform(10.8063746, 16.6871052) if missing(gsalud_num) & region == 10
replace gsalud_num = runiform(2.26630554, 19.036005) if missing(gsalud_num) & region == 11


//missing values up_num
replace up_num = runiform(6.42999983, 26.9099998) if missing(up_num) & region == 1
replace up_num = runiform(1.70000005, 19.1800003) if missing(up_num) & region == 5
replace up_num= runiform(2.24000001, 20.7399998) if missing(up_num) & region == 7
replace up_num = runiform(0.14300001, 26.2600002) if missing(up_num) & region == 6
replace up_num = runiform(3.9000001, 5.82999992) if missing(up_num) & region == 10
replace up_num = runiform(0.72399998, 14.8470001) if missing(up_num) & region == 11

//missing values GiniIndex_num
replace GiniIndex_num = runiform(32.1, 63) if missing(GiniIndex_num) & region == 1
replace GiniIndex_num = runiform(35.1, 51.3) if missing(GiniIndex_num) & region == 2
replace GiniIndex_num = runiform(29.6, 47.3) if missing(GiniIndex_num) & region == 3
replace GiniIndex_num = runiform(38.6, 49.2) if missing(GiniIndex_num) & region == 4
replace GiniIndex_num = runiform(43.7, 61) if missing(GiniIndex_num) & region == 5
replace GiniIndex_num = runiform(39.7, 53.9) if missing(GiniIndex_num) & region == 8
replace GiniIndex_num = runiform(24.6, 41.3) if missing(GiniIndex_num) & region == 7
replace GiniIndex_num = runiform(27.7, 42.3) if missing(GiniIndex_num) & region == 6
replace GiniIndex_num = runiform(26.00, 41.9) if missing(GiniIndex_num) & region == 9
replace GiniIndex_num = runiform(35.1, 41.4) if missing(GiniIndex_num) & region == 10
replace GiniIndex_num = runiform(30.1, 39) if missing(GiniIndex_num) & region == 11


//missing values IDH
replace IDH_num = runiform(0.592, 0.804) if missing(IDH_num) & region == 1
replace IDH_num = runiform(0.48, 0.74) if missing(IDH_num) & region == 2
replace IDH_num = runiform(0.397, 0.646) if missing(IDH_num) & region == 3
replace IDH_num = runiform(0.66, 0.815) if missing(IDH_num) & region == 4
replace IDH_num = runiform(0.51, 0.851) if missing(IDH_num) & region == 5
replace IDH_num = runiform(0.634, 0.851) if missing(IDH_num) & region == 8
replace IDH_num = runiform(0.75, 0.957) if missing(IDH_num) & region == 7
replace IDH_num = runiform(0.511, 0.949) if missing(IDH_num) & region == 6
replace IDH_num = runiform(0.47, 0.919) if missing(IDH_num) & region == 9
replace IDH_num = runiform(0.926, 0.929) if missing(IDH_num) & region == 10
replace IDH_num = runiform(0.555, 0.944) if missing(IDH_num) & region == 11

//Missing values GPE_num

replace GPE_num = runiform(2.7678299, 9.48040962) if missing(GPE_num) & region == 1
replace GPE_num = runiform(1.82117999, 5.64554977) if missing(GPE_num) & region == 2
replace GPE_num = runiform(1.76871002, 7.80014992) if missing(GPE_num) & region == 3
replace GPE_num = runiform(3.38515997, 3.44283009) if missing(GPE_num) & region == 4
replace GPE_num = runiform(2.39893007, 7.13839006) if missing(GPE_num) & region == 5
replace GPE_num = runiform(1.32632005, 7.00186014) if missing(GPE_num) & region == 8
replace GPE_num = runiform(1.15266001, 6.10457993) if missing(GPE_num) & region == 7
replace GPE_num = runiform(3.46971011, 7.23706007) if missing(GPE_num) & region == 6
replace GPE_num = runiform(2.50755, 6.49243021) if missing(GPE_num) & region == 9
replace GPE_num = runiform(10.5601901, 10.5601902) if missing(GPE_num) & region == 10
replace GPE_num = runiform(1.78587997, 12.39466) if missing(GPE_num) & region == 11


//Missing values EVM_num

replace EVM_num = runiform(10.5899998, 79.610001) if missing(EVM_num) & region == 1
replace EVM_num = runiform(3.29000002, 81.2700005) if missing(EVM_num) & region == 5
replace EVM_num = runiform(2.1499999, 89.4700012) if missing(EVM_num) & region == 8
replace EVM_num = runiform(2.11999991, 51.0500011) if missing(EVM_num) & region == 7
replace EVM_num = runiform(3.4700001, 9.34999964) if missing(EVM_num) & region == 10
replace EVM_num = runiform(8.0699999, 84.0100021) if missing(EVM_num) & region == 11
replace EVM_num = runiform(2.1499999, 89.4700012) if missing(EVM_num) 

//Missing values EVH_num

replace EVH_num = runiform(10.7299996, 79.610001) if missing(EVH_num) & region == 1
replace EVH_num = runiform(3.29000002, 65.6100016) if missing(EVH_num) & region == 5
replace EVH_num = runiform(4.39000013, 85.7599983) if missing(EVH_num) & region == 8
replace EVH_num = runiform(4.64999988, 51.3000011) if missing(EVH_num) & region == 7
replace EVH_num = runiform(4.25000004, 12.1900004) if missing(EVH_num) & region == 10
replace EVH_num = runiform(9.16000038, 65.6699985) if missing(EVH_num) & region == 11
replace EVH_num = runiform(4.39000013, 85.7599983) if missing(EVH_num)

//Missing values SF_num

replace SF_num = runiform(1.26882246, 72.1062619) if missing(SF_num) & region == 8
replace SF_num = runiform(0.05730659, 73.7332193) if missing(SF_num) & region == 7
replace SF_num = runiform(1.45679012, 91.9857143) if missing(SF_num) & region == 11
replace SF_num = runiform(1.26882246, 72.1062619) if missing(SF_num) 

sum tsg_num tsh_num tsm_num infla_num PPC_num bcbs_num gsalud_num up_num GiniIndex_num IDH_num


corr (tsh_num tsm_num tsg_num infla_num PPC_num bcbs_num gsalud_num up_num GiniIndex_num IDH_num)


corr (tsh_num infla_num PPC_num bcbs_num gsalud_num up_num GiniIndex_num IDH_num)

corr (tsm_num  infla_num PPC_num bcbs_num gsalud_num up_num GiniIndex_num IDH_num)

corr (tsh_num tsm_num infla_num PPC_num bcbs_num gsalud_num up_num GiniIndex_num IDH_num) 

//poniendo entre 0 y 1 índice Gini y IDH_num

generate Indexdeci = IDH_num * (1/100)
generate Ginideci = GiniIndex_num * (1/100)


//generando los ln

generate lntsg = ln( tsg_num )
generate lntsh = ln(tsh_num)
generate lntsm = ln(tsm_num)
generate lnup = ln( up_num )
generate lninfla = ln(infla_num)
generate lnPPC = ln( PPC_num )
generate lngsalud = ln( gsalud_num )
generate lnGini = ln( GiniIndex_num )
generate lnIDH = ln(IDH_num)
generate lnGPE = ln(GPE_num)
generate lnEVM = ln(EVM_num)
generate lnEVH = ln(EVH_num)
generate lnSF = ln(SF_num)
generate lnDPPK = ln(DDPK)
generate lnGinideci = ln(Ginideci)
generate lnIndexdeci = ln(Indexdeci)

//missing values log
replace lntsh = runiform(-0.1053605,4.825109) if missing(lntsh) 
replace lninfla = runiform(-1.91074, 4.424865) if missing(lninfla) 
replace lngsalud = runiform(0.4676807, 2.946332) if missing(lngsalud)
replace lnGPE = runiform(0.1420723, 2.517266) if missing(lnGPE)
replace lnEVM = runiform(-3.2118876, 4.592794) if missing(lnEVM)
replace lnEVH = runiform(-1.89712, 4.517868) if missing(lnEVH)
replace lnSF = runiform(-1.89712, 4.517868) if missing(lnSF)
replace lnDPPK = runiform(-1.89712, 4.517868) if missing(lnDPPK)




//correlaciones para probar que las variables no son dependientes entre si-de esto analiza correlación y estadística descriptiva

corr (lntsg lntsh lntsm lnPPC lnDPPK lngsalud lnup lnGini lnIDH lnGPE)

sum lntsg lntsh lntsm  lnup lngsalud lnPPC lnDPPK lnSF lnGPE lnIDH lnGini



//correlacion con nuevas formas, es decir con los logaritmos-estás debemos analizar en el paper

correlate lngsalud lnGini, covariance
correlate lngsalud lnGini

correlate lnup lnIDH, covariance
correlate lnup lnIDH

correlate lnGini lnIDH, covariance
correlate lnGini lnIDH

correlate lnDPPK lnSF, covariance
correlate lnDPPK lnSF

correlate lngsalud lnIDH, covariance
correlate lngsalud lnIDH

correlate lnPPC lnIDH, covariance
correlate lnPPC lnIDH

correlate lnPPC lnGini, covariance
correlate lnPPC lnGini

correlate lnGPE lngsalud, covariance,
correlate lnGPE lngsalud


correlate lnPPC lnup, covariance,
correlate lnPPC lnup


twoway (scatter lngsalud lnGini), name(g1)
twoway (scatter lnup lnIDH), name(g2)
twoway (scatter lnGini lnIDH), name(g3)
twoway (scatter lnDPPK lnSF), name(g4)
twoway (scatter lngsalud lnIDH), name(g5)
twoway (scatter lnPPC lnIDH), name(g6)
twoway (scatter lnPPC lnGini), name(g8)
twoway (scatter lnGPE lngsalud), name(g9)
twoway (scatter lnPPC lnup), name(g10)

graph combine g1 g2 g3 g4 g5 g6 g7 g8 g9 g10



//modelo en mata 1- relación general de la tasa de suicidios con crecimiento economico-variables significativas

mata 
I = J(217,1,1)
X = st_data(.,("lnup lngsalud lnPPC lnDPPK lnSF lnGPE lnGini lnIDH"))
Y = st_data(.,("lntsg"))
xhat = (luinv(X'X))*X'*Y
yhat = X*xhat

resi = Y - yhat
obs = I'*I


sigmachat = (resi'*resi) / (obs-9)
vare = sigmachat * luinv(X'*X)
desv = sqrt(vare)
ymed = (I'*Y)/obs
SEC = yhat'*yhat-obs*((ymed)^2)
SRC = resi'*resi
STC=SRC+SEC

rc = 1-(SRC/STC)
rca = 1-(((obs-1)/(obs-4))*(1-rc))

xhat
vare
desv
rc
rca

end


reg lntsg lnup lngsalud lnPPC lnDPPK lnSF lnGPE lnIDH lnGini

vif

predict tsgbarra, xb 
twoway (scatter tsgbarra lnup), name (gts1)
twoway (scatter tsgbarra lngsalud), name (gts2)
twoway (scatter tsgbarra lnPPC), name (gts3)
twoway (scatter tsgbarra lnDPPK), name (gts4)
twoway (scatter tsgbarra lnSF), name (gts5)
twoway (scatter tsgbarra lnGPE), name (gts6) 
twoway (scatter tsgbarra lnIDH), name (gts7) 
twoway (scatter tsgbarra lnGini), name (gts8)


graph combine gts1 gts2 gts3 gts4 gts5 gts6 gts7 gts8
 

//Modelo tasa de suicidios mujeres


//modelo en mata 2- relación general de la tasa de suicidios mujeres -variables significativas

mata 
I = J(217,1,1)
X = st_data(.,("lnup lngsalud lnPPC lnDPPK lnSF lnGPE lnEVH lnEVM lnGini lnIDH"))
Y = st_data(.,("lntsm"))
xhat = (luinv(X'X))*X'*Y
yhat = X*xhat

resi = Y - yhat
obs = I'*I


sigmachat = (resi'*resi) / (obs-9)
vare = sigmachat * luinv(X'*X)
desv = sqrt(vare)
ymed = (I'*Y)/obs
SEC = yhat'*yhat-obs*((ymed)^2)
SRC = resi'*resi
STC=SRC+SEC

rc = 1-(SRC/STC)
rca = 1-(((obs-1)/(obs-4))*(1-rc))

xhat
vare
desv
rc
rca

end


reg lntsm lnup lngsalud lnPPC lnDPPK lnSF lnGPE lnIDH lnGini

vif

predict tsmbarra, xb 

twoway (scatter tsmbarra lnup), name (gtsm1)
twoway (scatter tsmbarra lngsalud), name (gtsm2)
twoway (scatter tsmbarra lnPPC), name (gtsm3)
twoway (scatter tsmbarra lnDPPK), name (gtsm4)
twoway (scatter tsmbarra lnSF), name (gtsm5)
twoway (scatter tsmbarra lnGPE), name (gtsm6) 
twoway (scatter tsmbarra lnIDH), name (gtsm7) 
twoway (scatter tsmbarra lnGini), name (gtsm8)


graph combine gtsm1 gtsm2 gtsm3 gtsm4 gtsm5 gtsm6 gtsm7 gtsm8
 

 //Modelo tasa de suicidios hombres
 
 
//modelo en mata 2- relación general de la tasa de suicidios mujeres -variables significativas

mata 
I = J(217,1,1)
X = st_data(.,("lnup lngsalud lnPPC lnDPPK lnSF lnGPE lnEVH lnEVM lnGini lnIDH"))
Y = st_data(.,("lntsh"))
xhat = (luinv(X'X))*X'*Y
yhat = X*xhat

resi = Y - yhat
obs = I'*I


sigmachat = (resi'*resi) / (obs-9)
vare = sigmachat * luinv(X'*X)
desv = sqrt(vare)
ymed = (I'*Y)/obs
SEC = yhat'*yhat-obs*((ymed)^2)
SRC = resi'*resi
STC=SRC+SEC

rc = 1-(SRC/STC)
rca = 1-(((obs-1)/(obs-4))*(1-rc))

xhat
vare
desv
rc
rca

end


reg lntsh lnup lngsalud lnPPC lnDPPK lnSF lnGPE lnIDH lnGini

vif

predict tshbarra, xb 

twoway (scatter tshbarra lnup), name (gtsh1)
twoway (scatter tshbarra lngsalud), name (gtsh2)
twoway (scatter tshbarra lnPPC), name (gtsh3)
twoway (scatter tshbarra lnDPPK), name (gtsh4)
twoway (scatter tshbarra lnSF), name (gtsh5)
twoway (scatter tshbarra lnGPE), name (gtsh6) 
twoway (scatter tshbarra lnIDH), name (gtsh7) 
twoway (scatter tshbarra lnGini), name (gtsh8)


graph combine gtsh1 gtsh2 gtsh3 gtsh4 gtsh5 gtsh6 gtsh7 gtsh8
 
 
 
 
 
//Modelos sugerido por Jorge 

 reg lntsg lnup lngsalud lnPPC lnGPE lnDPPK lnSF
 
 vif

correlate lntsg lnup lngsalud lnPPC lnGPE lnDPPK lnSF

 reg lntsh lnup lngsalud lnPPC lnGPE lnDPPK lnSF
 
 vif
 
 reg lntsm lnup lngsalud lnPPC lnGPE lnDPPK lnSF
 
 vif
 
 predict tsgbarra, xb

  twoway (scatter tsgbarra PPC_num)

//Fin
