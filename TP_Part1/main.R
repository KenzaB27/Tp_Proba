#Ce fichier regroupe les diff�rentes fonctions qui nous permettent de r�aliser nos tests de 
#qualit� pour les g�n�rateurs �tudi�s 


#sources# 

source('generateurs.R')
source('calculProba.R')
source('fileAttente.R')
library('rngWELL')
library('randtoolbox')

########


#####################################Test Visuel################################################

## cette fonction fournit les histogrammes des s�quences produites par les diff�rents g�n�rateurs 
testVisuelHist<-function (k=1000,g=215)
{
  #par(mfrow=c(2,2))
  
  x<-VonNeumann(k,graine=g)
  hist(x[,1],100,xlab='',main='Von Neumann')
  #le 100 est pour d�finir le nombre de rectangle (plus de finesse)
  
  y<-MersenneTwister(k,graine=g)
  hist(y[,1],xlab='',main='Mersenne Twister')
  
  z<-Randu(k,graine = g)
  hist(z,xlab='',main='Randu')
  
  t<-StandardMinimal(k,graine = g)
  hist(t,xlab='',main='StandardMinimal')
    
}

## cette fonction fournit les courbes des s�quences produites par les diff�rents g�n�rateurs
testVisuelPlot<-function (n=1000, g=215)
{
  #par(mfrow=c(2,2))
  
  x<-VonNeumann(n,graine=g)
  plot(x[1:(n-1)], x[2:n],main='Von Neumann')
  
  y<-MersenneTwister(n,graine=g)
  plot(y[1:(n-1)], y[2:n],main='Mersenne Twister')
  
  z<-Randu(n,graine = g)
  plot(z[1:(n-1)], z[2:n],main='Randu')
  
  t<-StandardMinimal(n,graine = g)
  plot(t[1:(n-1)], t[2:n],main='StandardMinimal')
}

##############################################################################################




##################################Test fr�quence##############################################

#Cette fonction fournit un test de fr�quence pour le g�n�rateur Von Neumann 
# il s'agit de visualiser un histogramme des probabilit�s calcul�s pour t initialisations 
# diff�rentes , une courbe des probabilit� en fonctions de ces graines d'initialisation
# Ainsi qu'une repr�sentation de la loi de probabilit� suivi par le g�n�rateur 
# n repr�sente le nombre de bits pris en compte dans chacune des s�qeunces, il s'agit de 14
# pour Mersenne obtenu gr�ce � la partie enti�re de log2(9999) + 1
testFreqVon<-function(k=1000,t=100,n=14)
{
  #par(mfrow=c(2,2))
  
  freq<-rep(1,t)
  graine<-rep(1,t)
  sobs<-rep(1,t)
  
  for( i in 1:t)
  {
    graine[i]<-sample.int(10000,1)
    y<-VonNeumann(k,graine=graine[i])
    freq[i]<-Frequency(y,n)
    sobs[i]<-Sobs(y,n)
  }
  
  
  plot(graine,freq, main='Courbe de pvaleur en fonction de graines - Von Neuman')
  abline(h=0.01, col="red")
  hist(freq,100,xlab='',main='Fr�quence des pvaleurs - Von Neuman')
  plot(sobs,freq,main='Verification de la loi normal - Von Neumann')
}

#Cette fonction fournit un test de fr�quence pour le g�n�rateur Mersenne Twister
# il s'agit de visualiser un histogramme des probabilit�s calcul�s pour t initialisations 
# diff�rentes , une courbe des probabilit� en fonctions de ces graines d'initialisation
# Ainsi qu'une repr�sentation de la loi de probabilit� suivi par le g�n�rateur 
# n repr�sente le nombre de bits pris en compte dans chacune des s�qeunces, il s'agit de 32
# pour Mersenne 
testFreqMers<-function(k=1000,t=100,n=32)
{
  #par(mfrow=c(2,2))
  
  freq<-rep(1,t)
  graine<-rep(1,t)
  sobs<-rep(1,t)
  
  for( i in 1:t)
  {
    graine[i]<-sample.int(10000,1)
    y<-MersenneTwister(k,graine=graine[i])
    freq[i]<-Frequency(y,n)
    sobs[i]<-Sobs(y,n)
  }
  

  plot(graine,freq, main='Courbe de pvaleur en fonction de graines - Mersenne Twister')
  abline(h=0.01, col="red")
  hist(freq,100,xlab='',main='Fr�quence des pvaleurs - Mersenne Twister')
  plot(sobs,freq,main='Verification de la loi normal - Mersenne Twister')
}

#Cette fonction fournit un test de fr�quence pour le g�n�rateur Randu
# il s'agit de visualiser un histogramme des probabilit�s calcul�s pour t initialisations 
# diff�rentes , une courbe des probabilit� en fonctions de ces graines d'initialisation
# Ainsi qu'une repr�sentation de la loi de probabilit� suivi par le g�n�rateur 
# n repr�sente le nombre de bits pris en compte dans chacune des s�qeunces, il s'agit de 31
# pour Randu 
testFreqRandu<-function(k=1000, t=100, n=31)
{
  #par(mfrow=c(2,2))
  
  freq<-rep(1,t)
  graine<-rep(1,t)
  sobs<-rep(1,t)
  
  for( i in 1:t)
  {
    graine[i]<-sample.int(10000,1)
    y<-Randu(k,graine=graine[i])
    freq[i]<-Frequency(y,n)
    sobs[i]<-Sobs(y,n)
  }
  plot(graine,freq, main='Courbe de pvaleur en fonction de graines - Randu')
  abline(h=0.01, col="red")
  hist(freq,100,xlab='',main='Fr�quence des pvaleurs - Randu')
  plot(sobs,freq,main='Verification de la loi normal - Randu')
  
}

#Cette fonction fournit un test de fr�quence pour le g�n�rateur Standard Minimal
# il s'agit de visualiser un histogramme des probabilit�s calcul�s pour t initialisations 
# diff�rentes , une courbe des probabilit� en fonctions de ces graines d'initialisation
# Ainsi qu'une repr�sentation de la loi de probabilit� suivi par le g�n�rateur
# n repr�sente le nombre de bits pris en compte dans chacune des s�qeunces, il s'agit de 31
# pour Standard Minimal 
testFreqStd<-function(k=1000, t=100, n=31)
{
  #par(mfrow=c(2,2))
  
  freq<-rep(1,t)
  graine<-rep(1,t)
  sobs<-rep(1,t)
  
  for( i in 1:t)
  {
    graine[i]<-sample.int(10000,1)
    y<-StandardMinimal(k,graine=graine[i])
    freq[i]<-Frequency(y,n)
    sobs[i]<-Sobs(y,n)
  }
  plot(graine,freq, main='Courbe de pvaleur en fonction de graines - StandardMinimal')
  abline(h=0.01, col="red")
  hist(freq,100,xlab='',main='Fr�quence des pvaleurs - StandardMinimal')
  plot(sobs,freq,main='Verification de la loi normal - StandardMinimal')
  
}

##############################################################################################




###################################Test Runs##################################################

testV�rifRuns<-function()
{
  #par(mfrow=c(1,2))
  ##varier les valeurs de graines 
  g<-sample.int(10000,1)
  
  x<-VonNeumann(1000,graine=g)
  ##??? on prend log2 de 9999 pour d�finir le nbre de bit de von neumann
  Runs(x,14)
  Runsbis(x,14)
  
  y<-MersenneTwister(100,graine=g)
  Runs(y,32)
  Runsbis(y,32)
  
  z<-Randu(1000,graine = g)
  Runs(z,31)
  Runsbis(z,31)
  
  t<-StandardMinimal(1000,graine = g)
  Runs(t,31)
  Runsbis(t,31)
}

#Cette fonction fournit un test de runs pour le g�n�rateur Von Neumann 
# il s'agit de visualiser un histogramme des probabilit�s calcul�s pour t initialisations 
# diff�rentes et une courbe des probabilit� en fonctions de ces graines d'initialisation
# n repr�sente le nombre de bits pris en compte dans chacune des s�qeunces, il s'agit de 14
# pour Von Neumann obtenu gr�ce � la partie enti�re de log2(9999) + 1
testRunsVon<-function(k=1000,t=100,n=14)
{
  #par(mfrow=c(1,2))
  
  freq<-rep(1,t)
  graine<-rep(1,t)
  
  for( i in 1:t)
  {
    graine[i]<-sample.int(10000,1)
    freq[i]<-Runsbis(y<-VonNeumann(k,graine=graine[i]),n)
  }
  hist(freq,100,xlab='',main='Fr�quence des pvaleurs - Von Neumann - runs')
  plot(graine,freq, main='Courbe de pvaleur en fonction de graines - Von Neumann - Runs')
  abline(h=0.01, col="red")
}
#Cette fonction fournit un test de runs pour le g�n�rateur Mersenne Twister 
# il s'agit de visualiser un histogramme des probabilit�s calcul�s pour t initialisations 
# diff�rentes et une courbe des probabilit� en fonctions de ces graines d'initialisation
# n repr�sente le nombre de bits pris en compte dans chacune des s�qeunces, il s'agit de 32
# pour Mersenne
testRunsMers<-function(k=1000,t=100,n=32)
{
  #par(mfrow=c(1,2))
  
  freq<-rep(1,t)
  graine<-rep(1,t)
  
  for( i in 1:t)
  {
    graine[i]<-sample.int(10000,1)
    freq[i]<-Runsbis(y<-MersenneTwister(k,graine=graine[i]),n)
  }
  
  hist(freq,100,xlab='',main='Fr�quence des pvaleurs - Mersenne Twister - runs')
  plot(graine,freq, main='Courbe de pvaleur en fonction de graines - Mersenne Twister - Runs')
  abline(h=0.01, col="red")
}

#Cette fonction fournit un test de runs pour le g�n�rateur Randu 
# il s'agit de visualiser un histogramme des probabilit�s calcul�s pour t initialisations 
# diff�rentes et une courbe des probabilit� en fonctions de ces graines d'initialisation
# n repr�sente le nombre de bits pris en compte dans chacune des s�qeunces, il s'agit de 31
# pour Randu
testRunsRandu<-function(k=1000,t=100,n=31)
{
  #par(mfrow=c(1,2))
  
  freq<-rep(1,t)
  graine<-rep(1,t)
  
  for( i in 1:t)
  {
    graine[i]<-sample.int(10000,1)
    freq[i]<-Runsbis(y<-Randu(k,graine=graine[i]),n)
  }
  
  hist(freq,100,xlab='',main='Fr�quence des pvaleurs - Randu - runs')
  plot(graine,freq, main='Courbe de pvaleur en fonction de graines - Randu - Runs')
  abline(h=0.01, col="red")
  
}

#Cette fonction fournit un test de runs pour le g�n�rateur Standard Minimal 
# il s'agit de visualiser un histogramme des probabilit�s calcul�s pour t initialisations 
# diff�rentes et une courbe des probabilit� en fonctions de ces graines d'initialisation
# n repr�sente le nombre de bits pris en compte dans chacune des s�qeunces, il s'agit de 31
# pour Standard Minimal
testRunsStd<-function(k=1000,t=100,n=31)
{
  #par(mfrow=c(1,2))
  
  freq<-rep(1,t)
  graine<-rep(1,t)
  
  for( i in 1:t)
  {
    graine[i]<-sample.int(10000,1)
    freq[i]<-Runsbis(y<-StandardMinimal(k,graine=graine[i]),n)
  }
  
  hist(freq,100,xlab='',main='Fr�quence des pvaleurs - StandardMinimal - runs')
  plot(graine,freq, main='Courbe de pvaleur en fonction de graines - StandardMinimal - Runs')
  abline(h=0.01, col="red")
}
##############################################################################################




###################################Test Ordre#################################################


testOrdreVon<-function(k=1000,t=100)
{
  #par(mfrow=c(1,2))
  
  ordre<-rep(1,t)
  graine<-rep(1,t)
  
  for( i in 1:t)
  {
    graine[i]<-sample.int(10000,1)
    x<-VonNeumann(k,graine=graine[i])
    ordre[i]<-order.test(x[,1],d=4,echo=FALSE)$p.value
  }
  
  hist(ordre,100,xlab='',main='Fr�quence des pvaleurs - Mersenne Twister - ordre')
  plot(graine,ordre, main='Courbe de pvaleur en fonction des graines - Mersenne Twister - ordre')
  abline(h=0.01, col="red")
}

testOrdreMers<-function(k=1000,t=100)
{
  #par(mfrow=c(1,2))
  
  ordre<-rep(1,t)
  graine<-rep(1,t)
  
  for( i in 1:t)
  {
    graine[i]<-sample.int(10000,1)
    x<-MersenneTwister(k,graine=graine[i])
    ordre[i]<-order.test(x[,1],d=4,echo=FALSE)$p.value
  }
  hist(ordre,100,xlab='',main='Fr�quence des pvaleurs - Mersenne Twister - ordre')
  plot(graine,ordre, main='Courbe de pvaleur en fonction des graines - Mersenne Twister - ordre')
  abline(h=0.01, col="red")
}

testOrdreRandu<-function(k=1000,t=100)
{
  #par(mfrow=c(1,2))
  
  ordre<-rep(1,t)
  graine<-rep(1,t)
  
  for( i in 1:t)
  {
    graine[i]<-sample.int(10000,1)
    ordre[i]<-order.test(Randu(k,graine=graine[i]),d=4,echo=FALSE)$p.value
  }
  hist(ordre,100,xlab='',main='Fr�quence des pvaleurs - Randu - ordre')
  plot(graine,ordre, main='Courbe de pvaleur en fonction des graines - Randu - ordre')
  abline(h=0.01, col="red")
}

testOrdreStd<-function(k=1000,t=100)
{
  #par(mfrow=c(1,2))
  
  ordre<-rep(1,t)
  graine<-rep(1,t)
  
  for( i in 1:t)
  {
    graine[i]<-sample.int(10000,1)
  
    ordre[i]<-order.test(StandardMinimal(k,graine=graine[i]),d=4,echo=FALSE)$p.value
  }
  
  hist(ordre,100,xlab='',main='Fr�quence des pvaleurs - StandardMinimal - ordre')
  plot(graine,ordre, main='Courbe de pvaleur en fonction des graines - StandardMinimal - ordre')
  abline(h=0.01, col="red")
}

##############################################################################################
# cette fonction permet de tracer des courbes de simulation pour des files d'attente
testFileAttente<-function( lambda , mu ,d ){
  par(mfrow=c(1,2))
  liste1<-FileMM1(lambda ,mu,d);
  evolution1<-Evolution(liste1[[1]],liste1[[2]]); 
  plot(evolution1[[2]],evolution1[[1]], main='Courbe �volution file-Simu1', type='s');
  
  liste1<-FileMM1(lambda ,mu,d);
  evolution1<-Evolution(liste1[[1]],liste1[[2]]); 
  plot(evolution1[[2]],evolution1[[1]], main='Courbe �volution file-Simu2', type='s');
}

testLittle<-function(lambda, mu , d)
{
  liste<-FileMM1(lambda ,mu,d);
  evolution<-Evolution(liste[[1]],liste[[2]]); 
  moy<-MoyenneClient(evolution[[1]],evolution[[2]]);
  temps<-TempsPresence(liste[[1]],liste[[2]]);
  moyTheo<-(lambda/mu)/(1-lambda/mu); 
  tempsLittle<-moy/lambda; 
  ecartTheoMoy<-abs(moyTheo-moy);
  ecartTheoTemps<-abs(tempsLittle-temps); 
  return(list(moy,temps,tempsLittle,ecartTheoTemps))
}

testnfois<-function(lambda,mu,d,n)
{
  moy<-0; 
  ecartTheoMoy<-0;
  temps<-0;
  tempsLittle<-0; 
  ecartTheoTemps<-0;
  liste<-0;
  for (i in 1:n)
  {
    liste<-testLittle(lambda,mu,d);
    moy<-moy+liste[[1]];
    temps<-temps+liste[[2]]; 
    tempsLittle<-tempsLittle+liste[[3]];
    ecartTheoTemps<-ecartTheoTemps+liste[[4]];
  }
  moy<-moy/n; 
  temps<-temps/n; 
  tempsLittle<-tempsLittle/n; 
  ecartTheoTemps<-(ecartTheoTemps/n);
  return(list(moy,temps,tempsLittle,ecartTheoTemps)); 
}
  
  


