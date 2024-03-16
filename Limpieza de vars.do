clear all
cd "G:\My Drive\Super Proyecto Ec2"

use "BASE DE TRABAJO DE HOGARES"
rename HID002 IDENTIF_HOG 
 merge 1:m IDENTIF_HOG using "ECV6R_PERSONAS"
 
*cd "/Users/beto/Desktop/Super_Proyecto/Databases"

*****BTO*********
*use BASE_DE_TRABAJO_DE_HOGARES.dta
*rename HID002 IDENTIF_HOG 
* merge 1:m IDENTIF_HOG using ECV6R_PERSONAS.dta

*==========================
*Variables Endógenas
*=========================== 
 rename HVI039 satisf_material
	lab var satisf_material "Calidad de Vida Material Subjetiva"
 
 tab satisf_material
 
*==============================
* Variables Demográficas 
*================================

*g grupo_edad=1 if (EDAD>=4  & EDAD<=15)
*replace grupo_edad=2 if (EDAD>=16 & EDAD<=30)
*replace grupo_edad=3 if (EDAD>=31 & EDAD<=60)
*replace grupo_edad=4 if (EDAD>=61)

*label var  grupo_edad "Grupos de Edad"
*	lab define GEDAD 1 "Niños" 2 "Jóvenes" 3 "Adultos" 4 "Viejos"
*	lab val grupo_edad GEDAD

rename PD06 P_JH
label var P_JH "Parentesco con jefe del núcleo familiar"
recode P_JH (1=1 "1. Jefe del núcleo") (2=2 "2. Esposo(a) conviviente") (3=3 "3. Hijo / Hija ") (4 =4 "4. Otros") (5 =4 "4. Otros "), gen(P_hj)
tab P_hj

 
g genero=1 if (P_hj==1 & SEXO==1)
replace genero=2 if (P_hj==1 & SEXO==2)

label var  genero "Género"
	lab define GENERO 1 "1. Hombres" 2 "2. Mujeres" 
	lab val genero GENERO
	
	
g estado_civil=1 if (P_hj==1 & PD19==1)
replace estado_civil=2 if (P_hj==1 & PD19==2)
replace estado_civil=3 if (P_hj==1 & PD19==3)
replace estado_civil=4 if (P_hj==1 & PD19==4)
replace estado_civil=5 if (P_hj==1 & PD19==5)
replace estado_civil=6 if (P_hj==1 & PD19==6)

label var  estado_civil "Estado Civil"
	lab define CIVIL 1 "1. Casado" 2 "2. Unión Libre" 3 "3. Separado" 4 "4. Divorciado" 5 "5. Viudo" 6 "6. Soltero"
	lab val estado_civil CIVIL
	
	

g salud=1 if (P_hj==1 & PB07D==1 & PS57==1)
replace salud=1 if (P_hj==1 & PB07D==2 & PS57==1)
replace salud=2 if (P_hj==1 & PB07D==1 & PS57==2)
replace salud=2 if (P_hj==1 & PB07D==2 & PS57==2)


label var  salud "Satisfacción con Salud"
	lab define SALUD 1 "1. Satisfecho" 2 "2. Poco Satisfecho" 
	lab val salud SALUD	
	

g etnia=1 if (P_hj==1  & PD18==1)
replace etnia=2 if (P_hj==1  & PD18==2)
replace etnia=3 if (P_hj==1  & PD18==3)
replace etnia=4 if (P_hj==1  & PD18==4)
replace etnia=5 if (P_hj==1  & PD18==5)
replace etnia=6 if (P_hj==1  & PD18==6)
replace etnia=7 if (P_hj==1  & PD18==7)


label var  etnia "Grupo Étnico"
	lab define ETNIA 1 "1. Indígena" 2 "2. Afrodescendiante" 3 "3. Negro" 4 "4. Mulato" 5 "5. Montubio" 6 "6. Mestizo" 7 "7. Blanco" 
	lab val etnia ETNIA
	
	

	
********* SIIUUUU
	
	
*===============================================
*Variables para Regresión
*===============================================

*******Educación********
g nvl_edu=1 if (P_hj==1  & PE47==1)
replace nvl_edu=2 if (P_hj==1  & PE47==2)
replace nvl_edu=3 if (P_hj==1  & PE47==3)
replace nvl_edu=4 if (P_hj==1  & PE47==4)
replace nvl_edu=5 if (P_hj==1  & PE47==5)
replace nvl_edu=6 if (P_hj==1  & PE47==6)
replace nvl_edu=7 if (P_hj==1  & PE47==7)
replace nvl_edu=8 if (P_hj==1  & PE47==8)
replace nvl_edu=9 if (P_hj==1  & PE47==9)
replace nvl_edu=10 if (P_hj==1  & PE47==10)

label var  nvl_edu "Nivel de Educación Alcanzado"
	lab define NIVELEDU 1 "1. Ninguno" 2 "2. Alfabetización" 3 "3. Educación Inicial" 4 "4. Eduación básica" 5 "5. Primaria" 6 "6. Bachillerato" 7 "7. Secundaria" 8 "8. Superior No Universitaria" 9 "9. Superior" 10 "10. Postgrado"
	lab val nvl_edu NIVELEDU

tab nvl_edu
	
********Aporte jefe de hogar**********	
g condact_jh=1 if (P_hj==1  & HJH010==1)
 replace condact_jh=2 if (P_hj==1  & HJH010==2)
	label var condact_jh "Condición de Actividad Jefe del Hogar"
	label define CONDACTJH 1 "1. Aporta" 2 "2. No aporta"
	label val condact_jh CONDACTJH
	recode condact_jh (3=2)
	
tab condact_jh

**********Gastos Alimenticios***********
tab HVI034
recode HVI034(1=1 "1.Si") (2=2 "2.No") , gen(HVI034_1)
tab HVI034_1
gen gasto_alim = 1 if (P_hj==1 & HVI034_1==1)
 replace gasto_alim= 2 if (P_hj==1  & HVI034_1==2)
 label variable gasto_alim "¿Las últimas dos semanas tuvo problemas para pagar la comida?"
 label define GASTO_ALIM 1 "Sí" 2 "No"
 label val gasto_alim GASTO_ALIM
 tab gasto_alim

**********Afiliación seguro de Jefe de hogar***********
tab HJH009
recode HJH009 (1=1 "1.Seguro Salud Privada") (2=2 "2.IESS, Seguro General") (3=3 "3.IESS, Seguro Campesino") (4=4 "4. ISFFA o ISSPOL"), gen(seguro_jefeH)
tab seguro_jefeH

g Seguro_JH=1 if (P_hj==1  & seguro_jefeH==1)
 replace Seguro_JH=2 if (P_hj==1  & seguro_jefeH==2)
 replace Seguro_JH=3 if (P_hj==1  & seguro_jefeH==3)
 replace Seguro_JH=4 if (P_hj==1  & seguro_jefeH==4)
 label variable  Seguro_JH "Afiliación a seguro médico de jefe de hogar"
 label define SEGURO_JH 1 "1. Seguro Salud Privada" 2 "2.IESS, Seguro General" 3 "3.IESS, Seguro Campesino" 4 "4. ISFFA o ISSPOL"
 label val Seguro_JH SEGURO_JH
 
 tab Seguro_JH
 
*********Préstamos***********************
g prestamos=1 if (P_hj==1  & HVI036==1)
 replace prestamos=2 if (P_hj==1  & HVI036==2)
 label variable prestamos "Realizó préstamos el último año"
 label define PRESTAMOS 1 "1. Sí" 2 "2. No"
 label val prestamos PRESTAMOS
 
 tab prestamos

 
************Tiene Animales******************
g animalitos=1 if (P_hj==1 & HVI054==1)
 replace animalitos=2 if (P_hj==1 & HVI054==2)
 label variable animalitos "Tiene Animales"
 label define ANIMALITOS 1 "Sí" 2 "No"
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
	lab define TOT_BORN_CHLD 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10" 11 "11" 12 "12" 13 "13" 14 "14" 15 "15" 16 "16"	
	lab val tot_born_chld TOT_BORN_CHLD
tab tot_born_chld

rename HVI044 neg_home
label var neg_home "El hogar tiene negocios"
tab neg_home

rename HVI045 terrenos
label var terrenos "El hogar tiene tierras propias"
tab terrenos

g q_agua=1 if (P_hj==1  & PH34B==1)
 replace q_agua=2 if (P_hj==1  & PH34B==2)
 label variable q_agua "¿Hay contaminación de agua en su barrio?"
 label define Q_agua 1 "Sí" 2 "No"
 label val q_agua Q_agua
tab q_agua

g twitter=1 if (P_hj==1  & PH14B==1)
 replace twitter=2 if (P_hj==1  & PH14B==2)
 label variable twitter "Utiliza Twitter"
 label define TWITTER 1 "Sí" 2 "No"
 label val twitter TWITTER
tab twitter

rename HVI007 internet
tab internet

rename PB06E sat_vida
tab sat_vida

g sat_vida=1 if (P_hj==1  & PB06E==1)
 replace sat_vida=2 if (P_hj==1  & PB06E==2)
 replace sat_vida=3 if (P_hj==1  & PB06E==3)
 replace sat_vida=4 if (P_hj==1  & PB06E==4)
 replace sat_vida=5 if (P_hj==1  & PB06E==5)
 label variable sat_vida "Satisfación Personal con uno mismo"
 label define SAT_vida 1 "1. No informa " 2 " 2. Muy de acuerdo " 3 "3. De acuerdo " 4 "4. En desacuerdo" 5 "5. Muy en desacuerdo"
 label val sat_vida SAT_vida
tab sat_vida

rename HVI042 pobreza_h
tab pobreza_h

g celular=1 if (P_hj==1  & PH09A==1)
 replace celular=2 if (P_hj==1  & PH09A==2)
 label variable celular "Tiene teléfono celular activado"
 label define celular 1 "Sí" 2 "No"
 label val celular
tab celular

rename PB05F depression
tab depression

//tengo un par de problemas aquí, inicialmente PB05F me bota 7 días, no se que hago que al final me bota solo hasta el 5 día. 
g  depression=1 if (P_hj==1  &  PB05F==1)
replace  depression=2 if (P_hj==1  &  PB05F==2)
replace  depression=3 if (P_hj==1  &  PB05F==3)
replace  depression=4 if (P_hj==1  &  PB05F==4)
replace  depression=5 if (P_hj==1  &  PB05F==5)
replace  depression=6 if (P_hj==1  &  PB05F==6)
replace  depression=7 if (P_hj==1  &  PB05F==7)
replace  depression=8 if (P_hj==1  &  PB05F==8)
replace  depression=9 if (P_hj==1  &  PB05F==9)
label var   depression "Días que se sintió deprimido en la última semana."
	lab define DEPRESSION 1 "No informa" 2 "Ninguno" 3 "1" 4 "2" 5 "3" 6 "4" 7 "5" 8 "6" 9 "7"
	lab val  depression DEPRESSION
tab  depression



*===============================================
***** Dummy potencial  **** REVISAR URGENTLY !!!!!!!!!
*===============================================

rename HVI025 tipo_hogar
tab tipo_hogar, gen(tipohogar_d)

*===============================================
* Descriptivos
*===============================================
foreach tit in grupo_edad estado_civil salud etnia nvl_edu condact_jh gasto_alim seguro_jefeH prestamos animales tot_born_chld terrenos q_agua twitter internet sat_vida {
graph bar, ///
	over (`tit') ///
	ytitle ("%") ///
	title ("") ///
	blabel(bar,format(%4.1f)) ///
	intensity(45) ///
	bar(1, color(orange)) //

}


**** HACER LOOP DE LOGARITMOS ******
g ln_satis=ln(satisf_material)
g ln_satvida=ln(sat_vida)

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


* OLS regresión sobre satisfacción material
regress satisf_material nvl_edu condact_jh gasto_alim seguro_jefeH prestamos neg_home terrenos tot_born_chld q_agua internet pobreza_h celular

* OLS regresión sobre "satisfacción con la vida" 
regress sat_vida nvl_edu tot_born_chld twitter pobreza_h depression

*Logit regresión sobre satisfacción material
logit ln_satis nvl_edu condact_jh gasto_alim seguro_jefeH prestamos neg_home terrenos tot_born_chld q_agua internet pobreza_h celular celular

*Logit regresión sobre "satisfacción con la vida" 
logit ln_satvida nvl_edu tot_born_chld twitter pobreza_h depression

*Probit regresión sobre satisfacción material
probit ln_satis nvl_edu condact_jh gasto_alim seguro_jefeH prestamos neg_home terrenos tot_born_chld q_agua internet pobreza_h celular celular

*Probit regresión sobre "satisfacción con la vida" 
probit ln_satvida nvl_edu tot_born_chld twitter pobreza_h depression


bysort IDENTIF_HOG: egen hh_inc=total(PA23A)
bysort IDENTIF_HOG: g hh_size=_N
g hh_incpc=hh_inc/hh_size



























