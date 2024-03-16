clear all

cd "G:\My Drive\Super Proyecto Ec2"

use "BASE DE TRABAJO DE HOGARES"
rename HID002 IDENTIF_HOG 
 merge 1:m IDENTIF_HOG using "ECV6R_PERSONAS"

*==========================
*Variables Endógenas
*=========================== 
rename PD06 P_JH
label var P_JH "Parentesco con jefe del núcleo familiar"
recode P_JH (1=1 "1. Jefe del núcleo") (2=2 "2. Esposo(a) conviviente") (3=3 "3. Hijo / Hija ") (4 =4 "4. Otros") (5 =4 "4. Otros "), gen(P_hj)
tab P_hj


 g satisf_material=2 if (P_hj==1  & (HVI042==3 | HVI042==4))
 replace satisf_material=1 if (P_hj==1  & (HVI042==1 | HVI042==2))
 label variable satisf_material "Calidad de Vida Material Subjetiva"
 label define SAT_mat 2 "1. Riqueza" 1 "0. Pobreza"
 label val satisf_material SAT_mat
 tab satisf_material
 
 g prob_satisf_material=1 if (P_hj==1  & (HVI042==3 | HVI042==4))
 replace prob_satisf_material=0 if (P_hj==1  & (HVI042==1 | HVI042==2))
 label variable prob_satisf_material "Calidad de Vida Material Subjetiva"
 label define PROBSATMAT 1 "1. Riqueza" 0 "0. Pobreza"
 label val prob_satisf_material PROBSATMAT
 tab prob_satisf_material
 

g sat_vida=2 if (PB06E==2 | PB06E==3)
 replace sat_vida=1 if (PB06E==4 | PB06E==5)
 label variable sat_vida "Satisfación Personal con uno mismo"
 label define SAT_vida 2 "1. Satisfecho" 1 "0. Inconforme"
 label val sat_vida SAT_vida
tab sat_vida

g prob_sat_vida=1 if (PB06E==2 | PB06E==3)
 replace prob_sat_vida=0 if (PB06E==4 | PB06E==5)
 label variable prob_sat_vida "Satisfación Personal con uno mismo"
 label define PROBSATVIDA 1 "1. Satisfecho" 0 "0. Inconforme"
 label val prob_sat_vida PROBSATVIDA
tab prob_sat_vida
*Se puede usar HVI042 o HVI039 para satisf material
 
*==============================
* Variables Demográficas 
*================================

*******Género************* 
g hombre=0 if (P_hj==1 & SEXO==2)
replace hombre=1 if (P_hj==1 & SEXO==1)

label var  hombre "Género"
	lab define GENERO 1 "Hombres" 0 "Mujeres" 
	lab val hombre GENERO
	

*************Estado Civil**************
g estado_civil=1 if (PD19==1)
replace estado_civil=2 if (PD19==2)
replace estado_civil=3 if (PD19==3)
replace estado_civil=4 if (PD19==4)
replace estado_civil=5 if (PD19==5)
replace estado_civil=6 if (PD19==6)

label var  estado_civil "Estado Civil"
	lab define CIVIL 1 "Casado" 2 "Unión Libre" 3 "Separado" 4 "Divorciado" 5 "Viudo" 6 "Soltero"
	lab val estado_civil CIVIL
tab estado_civil

******************** Etnia**************	

g etnia=1 if (PD18==6)
replace etnia=2 if (PD18==2)
replace etnia=3 if (PD18==3)
replace etnia=4 if (PD18==4)
replace etnia=5 if (PD18==5)
replace etnia=6 if (PD18==1)
replace etnia=7 if (PD18==7)


label var  etnia "Grupo Étnico"
	lab define ETNIA 1 "Mestizo" 2 "Afrodescendiante" 3 "Negro" 4 "Mulato" 5 "Montubio" 6 "Indigena" 7 "Blanco" 
	lab val etnia ETNIA
tab etnia
	
******* Ingreso *******

bysort IDENTIF_HOG: egen hh_inc=total(PA23A)
bysort IDENTIF_HOG: g hh_size=_N
g hh_incpc=hh_inc/hh_size

*******Educación********
g nvl_edu=1 if (PE47==2 | PE47==3 | PE47==4 | PE47==5)
replace nvl_edu=2 if (PE47==6 | PE47==7)
replace nvl_edu=3 if (PE47==8 | PE47==9 | PE47==10)

label var  nvl_edu "Nivel de Educación Alcanzado"
	lab define NIVELEDU 1 "Básico" 2 "Colegio" 3 "Superior"
	lab val nvl_edu NIVELEDU

tab nvl_edu
	
*===============================================
*Variables para Regresión
*===============================================

******** Satisfacción Salud *********

g salud=1 if (PB07D==1 & PS57==1)
replace salud=1 if (PB07D==2 & PS57==1)
replace salud=0 if (PB07D==1 & PS57==2)
replace salud=0 if (PB07D==2 & PS57==2)


label var  salud "Satisfacción con Salud"
	lab define SALUD 1 "1. Satisfecho" 0 "0. No Satisfecho" 
	lab val salud SALUD
tab salud


********Empleo jefe de hogar**********	
g empleo_jh=0 if (P_hj==1 & (HJH010==2 | HJH010==3))
 replace empleo_jh=1 if (P_hj==1 & HJH010==1)
	label var empleo_jh "Situación de Empleo Jefe del Hogar"
	label define EMPLEOJH 0 "0. Desempleado" 1 "1. Empleado"
	label val empleo_jh EMPLEOJH
	
tab empleo_jh

**********Gastos Alimenticios***********

gen gasto_alim=0 if (P_hj==1 & HVI034==2)
 replace gasto_alim=1 if (P_hj==1 & HVI034==1)
 label variable gasto_alim "¿Las últimas dos semanas tuvo problemas para pagar la comida?"
 label define GASTO_ALIM 1 "1. Sí" 0 "0. No"
 label val gasto_alim GASTO_ALIM
 tab gasto_alim

**********Afiliación seguro de Jefe de hogar***********
tab HJH009
recode HJH009 (1=1 "1.Seguro Salud Privada") (2=2 "2.IESS, Seguro General") (3=3 "3.IESS, Seguro Campesino") (4=4 "4. ISFFA o ISSPOL"), gen(seguro_jefeH)
tab seguro_jefeH

g Seguro_JH=1 if (P_hj==1 & seguro_jefeH==1)
 replace Seguro_JH=2 if (P_hj==1 & seguro_jefeH==2)
 replace Seguro_JH=3 if (P_hj==1 & seguro_jefeH==3)
 replace Seguro_JH=4 if (P_hj==1 & seguro_jefeH==4)
 label variable  Seguro_JH "Afiliación a seguro médico de jefe de hogar"
 label define SEGURO_JH 1 "1. Seguro Salud Privada" 2 "2.IESS, Seguro General" 3 "3.IESS, Seguro Campesino" 4 "4. ISFFA o ISSPOL"
 label val Seguro_JH SEGURO_JH
 
 tab Seguro_JH
 
*********Préstamos***********************
g prestamos=1 if (P_hj==1  & HVI036==1)
 replace prestamos=0 if (P_hj==1  & HVI036==2)
 label variable prestamos "Realizó préstamos el último año"
 label define PRESTAMOS 1 "1. Sí" 0 "0. No"
 label val prestamos PRESTAMOS
 
 tab prestamos

 
************Tiene Animales******************
g animalitos=0 if (P_hj==1 & HVI054==2)
 replace animalitos=1 if (P_hj==1 & HVI054==1)
 label variable animalitos "Tiene Animales"
 label define ANIMALITOS 1 "1. Sí" 0 "0. No"
 label val animalitos ANIMALITOS
 
 tab animalitos

	
*********Variables HOGAR********
g tot_born_chld=1 if (P_hj==1  & PF15==1)
replace tot_born_chld=2 if (P_hj==1  & PF15==2)
replace tot_born_chld=3 if (P_hj==1  & PF15==3)
replace tot_born_chld=4 if (P_hj==1  & PF15==4)
replace tot_born_chld=5 if (P_hj==1  & PF15==5)
replace tot_born_chld=6 if (P_hj==1  & PF15==6)
replace tot_born_chld=7 if (P_hj==1  & PF15==7)
replace tot_born_chld=8 if (P_hj==1  & PF15==8)
replace tot_born_chld=9 if (P_hj==1  & PF15==9)
replace tot_born_chld=10 if (P_hj==1  & PF15==10)
replace tot_born_chld=11 if (P_hj==1  & PF15==11)
replace tot_born_chld=12 if (P_hj==1  & PF15==12)
replace tot_born_chld=13 if (P_hj==1  & PF15==13)
replace tot_born_chld=14 if (P_hj==1  & PF15==14)
replace tot_born_chld=15 if (P_hj==1  & PF15==15)
replace tot_born_chld=16 if (P_hj==1  & PF15==16)
label var  tot_born_chld "Total de hijos nacidos vivos"
	lab define TOT_BORN_CHLD 1 "1" 2 "2" 3 "3" 4 "4"
	lab val tot_born_chld TOT_BORN_CHLD
tab tot_born_chld

g neg_home=0 if (P_hj==1 & HVI044==2)
replace neg_home=1 if (P_hj==1 & HVI044==1)
label variable neg_home "¿El hogar tiene negicios?"
 label define NEGHOME 1 "1. Sí" 0 "0. No"
 label val neg_home NEGHOME
 
tab neg_home

g terrenos=0 if (P_hj==1 & HVI045==2)
replace terrenos=1 if (P_hj==1 & HVI045==1)
label variable terrenos "¿El hogar tiene tierras propias adicionales?"
 label define TERRENOS 1 "1. Sí" 0 "0. No"
 label val terrenos TERRENOS
 
tab terrenos

g q_agua=1 if (P_hj==1  & PH34B==1)
 replace q_agua=0 if (P_hj==1  & PH34B==2)
 label variable q_agua "¿Hay contaminación de agua en su barrio?"
 label define Q_agua 1 "1. Sí" 0 "0. No"
 label val q_agua Q_agua
 
tab q_agua

g twitter=1 if (P_hj==1  & PH14B==1)
 replace twitter=0 if (P_hj==1  & PH14B==2)
 label variable twitter "Utiliza Twitter"
 label define TWITTER 1 "1. Sí" 0 "0. No"
 label val twitter TWITTER
 
tab twitter

g internet=0 if (P_hj==1 & HVI007==2)
replace internet=1 if (P_hj==1 & HVI007==1)
label variable internet "Tiene servicio de internet"
 label define INTERNET 1 "1. Sí" 0 "0. No"
 label val internet INTERNET
 
tab internet


g celular=0 if (P_hj==1  & PH09A==1)
 replace celular=1 if (P_hj==1 & PH09A==2)
 label variable celular "Tiene teléfono celular activado"
 label define celular 1 "1. Sí" 0 "0. No"
 label val celular
 
tab celular

*===============================================
*Índice de depresión *
*===============================================

** Composite of depresión 
**** Pros: (+): multi-dimensional, (+) robust
***** Cons (-): negatives may make the interpretation trickier

global varlist_2 PB05A PB05C PB05F PB05I PB05K PB05N PB05Q PB05R PB05T
foreach x in $varlist_2 {
replace `x'=. if `x' < 1
}
corr PB05A PB05C PB05F PB05I PB05K PB05N PB05Q PB05R PB05T // matriz de correlacion, superior a 30% -> variables aceptables
alpha PB05A PB05C PB05F PB05I PB05K PB05N PB05Q PB05R PB05T // score superior a '.70' -> relación suficientemente fuerte entre variables
zsxore PB05A PB05C PB05F PB05I PB05K PB05N PB05Q PB05R PB05T // estandarización-z de variables. Sino funciona, instalar mediante 'findit zscore' en ventana de comando

egen float dep_miss = rowmiss(z_PB05A z_PB05C z_PB05F z_PB05I z_PB05K z_PB05N z_PB05Q z_PB05R z_PB05T)
egen float dep_comp = rowmean(z_PB05A z_PB05C z_PB05F z_PB05I z_PB05K z_PB05N z_PB05Q z_PB05R z_PB05T) if (dep_miss<9 & P_hj==1) 


*===============================================
* Descriptivos
*===============================================
foreach tit in satisf_material sat_vida hombre estado_civil etnia nvl_edu hh_incpc salud gasto_alim seguro_jefeH prestamos animalitos tot_born_chld neg_home terrenos empleo_jh q_agua twitter internet celular dep_comp {
graph bar, ///
	over (`tit') ///
	ytitle ("%") ///
	title ("") ///
	blabel(bar,format(%4.1f)) ///
	intensity(45) ///
	bar(1, color(orange)) //

}


*===============================================
* Regresiones
*===============================================
/*
Variables Subjetivas

nvl_edu;  Nivel de Educación Alcanzado 
tot_born_chld; Total de hijos nacidos vivos
twitter; Utiliza twitter 
pobreza_h; Usted considera que su hogar es.....
depression; En los últimos 7 se ha sentido deprimida 
*/

g lsat_vida = ln(sat_vida)
g ls_material = ln(satisf_material)

* Etiqueta de weight
    gen int int_fexp = round(FEXP)
	lab var int_fexp "Factor de expansión"

* OLS regresión sobre satisfacción material
regress ls_material i.estado_civil i.etnia i.nvl_edu hh_incpc salud i.gasto_alim i.seguro_jefeH i.prestamos animalitos tot_born_chld neg_home terrenos empleo_jh q_agua twitter internet celular [w=int_fexp], robust
outreg2 using "tb.xls", ctitle(MCO1) replace

* OLS regresión sobre "satisfacción con la vida" 
regress lsat_vida i.estado_civil i.etnia i.nvl_edu hh_incpc salud i.gasto_alim i.seguro_jefeH i.prestamos animalitos tot_born_chld neg_home terrenos empleo_jh q_agua twitter internet celular dep_comp [w=int_fexp], robust
outreg2 using "tb.xls", ctitle(MCO2) append

*Logit regresión sobre satisfacción material
logit prob_satisf_material i.estado_civil i.etnia i.nvl_edu hh_incpc salud i.gasto_alim i.seguro_jefeH i.prestamos animalitos tot_born_chld neg_home terrenos empleo_jh q_agua twitter internet celular [w=int_fexp]
margins, dydx(*) post
outreg2 using tb.xls, ctitle(LOG1) stats(coef se) append


*Logit regresión sobre "satisfacción con la vida" 
logit prob_sat_vida i.estado_civil i.etnia i.nvl_edu hh_incpc salud i.gasto_alim i.seguro_jefeH i.prestamos animalitos tot_born_chld neg_home terrenos empleo_jh q_agua twitter internet celular dep_comp [w=int_fexp]
margins, dydx(*) post
outreg2 using tb.xls, ctitle(LOG2) stats(coef se) append

*Probit regresión sobre satisfacción material
probit prob_satisf_material i.estado_civil i.etnia i.nvl_edu hh_incpc salud i.gasto_alim i.seguro_jefeH i.prestamos animalitos tot_born_chld neg_home terrenos empleo_jh q_agua twitter internet celular [w=int_fexp]
margins, dydx(*) post
outreg2 using tb.xls, ctitle(PROB1) stats(coef se) append

*Probit regresión sobre "satisfacción con la vida" 
probit prob_sat_vida i.estado_civil i.etnia i.nvl_edu hh_incpc salud i.gasto_alim i.seguro_jefeH i.prestamos animalitos tot_born_chld neg_home terrenos empleo_jh q_agua twitter internet celular dep_comp [w=int_fexp]
margins, dydx(*) post
outreg2 using tb.xls, ctitle(PROB2) stats(coef se) append

