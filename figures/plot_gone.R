#--------------------------------------------------------
#########################################################
# plot GONE results
#########################################################
#--------------------------------------------------------

library(scales)
library(matrixStats)
library(ggplot2)
#options(scipen = 999)

# plot GONE reps assuming 0.25 years/generation and assuming present is 2024 (figure in manuscript)
par(xpd=FALSE)

plot(c(0,200),c(0,5000000),type="n",ylab=expression(paste("Historical ",italic(""*N*"")[e],sep="")), 
     xlab="Years before present", cex.lab=1, xaxt="n")
mtext("Generations before present", col = "gray", side = 1, line = 4)
axis1<-seq(0,660,12) # years
axis2<-seq(0,200,20) # generations
axis(1, at=axis1, labels=axis1*0.25)
axis(1, at=axis2, col.axis="gray", line = 1, tick=FALSE)

files <- paste("outfileLD_",1:100, "_GONE_Nebest", sep="")

NeMat <- NULL
for(i in 1:100){
  dat <- read.table(files[i],skip=2)
  NeMat <- cbind(NeMat,dat[,2])
}

# get CI
NeCI <- matrix(NA,nrow=200,ncol=2)
NeCI2 <- matrix(NA,nrow=200,ncol=2)

for(i in 1:200){
  NeCI[i,] <- quantile(NeMat[i,],probs=c(0.025,0.975))
  NeCI2[i,] <- quantile(NeMat[i,],probs=c(0.05,0.95))
}


# add gray polygon highlighting the years 2010-2014 (assuming present is 2024)
y <- c(0,0,5e06,5e06)
x <- c((14/0.25),(10/0.25),(10/0.25),(14/0.25))
polygon(x,y,col= "grey99")


lines(1:200,rowMedians(NeMat[1:200,]),col="orange",lwd=4)
#polygon(x=c(1:200,rev(1:200)),y=c(NeCI[1:200,1],rev(NeCI[1:200,2])),col=adjustcolor("#05BFC4",alpha.f=0.2),border=NA)
polygon(x=c(1:200,rev(1:200)),y=c(NeCI2[1:200,1],rev(NeCI2[1:200,2])),col=adjustcolor("orange",alpha.f=0.15),border=NA)



# setting plotting dimensions with par for the supplemental figure 
par(mfrow=c(2,2))

# plot GONE reps assuming 0.25 years/generation and assuming present is 2024
plot(c(0,200),c(0,5000000),type="n",ylab=expression(paste("Historical ",italic(""*N*"")[e],sep="")), 
     xlab="Years before present", cex.lab=1, xaxt="n")
mtext("Generations before present", col = "gray", side = 1, line = 4, cex = 0.8)
axis1<-seq(0,660,12) # years
axis2<-seq(0,200,20) # generations
axis(1, at=axis1, labels=axis1*0.25)
axis(1, at=axis2, col.axis="gray", line = 1, tick=FALSE)

files <- paste("outfileLD_",1:100, "_GONE_Nebest", sep="")

NeMat <- NULL
for(i in 1:100){
  dat <- read.table(files[i],skip=2)
  NeMat <- cbind(NeMat,dat[,2])
}

# get CI
NeCI <- matrix(NA,nrow=200,ncol=2)
NeCI2 <- matrix(NA,nrow=200,ncol=2)

for(i in 1:200){
  NeCI[i,] <- quantile(NeMat[i,],probs=c(0.025,0.975))
  NeCI2[i,] <- quantile(NeMat[i,],probs=c(0.05,0.95))
}


# add gray polygon highlighting the years 2010-2014 (assuming present is 2024)
y <- c(0,0,5e06,5e06)
x <- c((14/0.25),(10/0.25),(10/0.25),(14/0.25))
polygon(x,y,col= "grey99")


lines(1:200,rowMedians(NeMat[1:200,]),col="orange",lwd=4)
#polygon(x=c(1:200,rev(1:200)),y=c(NeCI[1:200,1],rev(NeCI[1:200,2])),col=adjustcolor("#05BFC4",alpha.f=0.2),border=NA)
polygon(x=c(1:200,rev(1:200)),y=c(NeCI2[1:200,1],rev(NeCI2[1:200,2])),col=adjustcolor("orange",alpha.f=0.15),border=NA)


# plot GONE reps assuming 0.20 years/generation and assuming present is 2024
plot(c(0,200),c(0,5000000),type="n",ylab=expression(paste("Historical ",italic(""*N*"")[e],sep="")), 
     xlab="Years before present", cex.lab=1, xaxt="n")
mtext("Generations before present", col = "gray", side = 1, line = 4, cex = 0.8)
axis1<-seq(0,660,12) # years
axis2<-seq(0,200,20) # generations
axis(1, at=axis1, labels=round(axis1*0.20))
axis(1, at=axis2, col.axis="gray", line = 1, tick=FALSE)

files <- paste("outfileLD_",1:100, "_GONE_Nebest", sep="")

NeMat <- NULL
for(i in 1:100){
  dat <- read.table(files[i],skip=2)
  NeMat <- cbind(NeMat,dat[,2])
}

# get CI
NeCI <- matrix(NA,nrow=200,ncol=2)
NeCI2 <- matrix(NA,nrow=200,ncol=2)

for(i in 1:200){
  NeCI[i,] <- quantile(NeMat[i,],probs=c(0.025,0.975))
  NeCI2[i,] <- quantile(NeMat[i,],probs=c(0.05,0.95))
}


# add gray polygon highlighting the years 2010-2014 (assuming present is 2024)
y <- c(0,0,5e06,5e06)
x <- c((14/0.20),(10/0.20),(10/0.20),(14/0.20))
polygon(x,y,col= "grey99")


lines(1:200,rowMedians(NeMat[1:200,]),col="orange",lwd=4)
#polygon(x=c(1:200,rev(1:200)),y=c(NeCI[1:200,1],rev(NeCI[1:200,2])),col=adjustcolor("#05BFC4",alpha.f=0.2),border=NA)
polygon(x=c(1:200,rev(1:200)),y=c(NeCI2[1:200,1],rev(NeCI2[1:200,2])),col=adjustcolor("orange",alpha.f=0.15),border=NA)






# plot GONE reps assuming 0.25 years/generation and assuming present is 2023
plot(c(0,200),c(0,5000000),type="n",ylab=expression(paste("Historical ",italic(""*N*"")[e],sep="")), 
     xlab="Years before present", cex.lab=1, xaxt="n")
mtext("Generations before present", col = "gray", side = 1, line = 4, cex = 0.8)
axis1<-seq(0,660,12) # years
axis2<-seq(0,200,20) # generations
axis(1, at=axis1, labels=axis1*0.25)
axis(1, at=axis2, col.axis="gray", line = 1, tick=FALSE)

files <- paste("outfileLD_",1:100, "_GONE_Nebest", sep="")

NeMat <- NULL
for(i in 1:100){
  dat <- read.table(files[i],skip=2)
  NeMat <- cbind(NeMat,dat[,2])
}

# get CI
NeCI <- matrix(NA,nrow=200,ncol=2)
NeCI2 <- matrix(NA,nrow=200,ncol=2)

for(i in 1:200){
  NeCI[i,] <- quantile(NeMat[i,],probs=c(0.025,0.975))
  NeCI2[i,] <- quantile(NeMat[i,],probs=c(0.05,0.95))
}


# add gray polygon highlighting the years 2010-2014 (assuming present is 2023)
y <- c(0,0,5e06,5e06)
x <- c((13/0.25),(9/0.25),(9/0.25),(13/0.25))
polygon(x,y,col= "grey99")


lines(1:200,rowMedians(NeMat[1:200,]),col="orange",lwd=4)
#polygon(x=c(1:200,rev(1:200)),y=c(NeCI[1:200,1],rev(NeCI[1:200,2])),col=adjustcolor("#05BFC4",alpha.f=0.2),border=NA)
polygon(x=c(1:200,rev(1:200)),y=c(NeCI2[1:200,1],rev(NeCI2[1:200,2])),col=adjustcolor("orange",alpha.f=0.15),border=NA)



# plot GONE reps assuming 0.20 years/generation and assuming present is 2023
plot(c(0,200),c(0,5000000),type="n",ylab=expression(paste("Historical ",italic(""*N*"")[e],sep="")), 
     xlab="Years before present", cex.lab=1, xaxt="n")
mtext("Generations before present", col = "gray", side = 1, line = 4, cex = 0.8)
axis1<-seq(0,660,12) # years
axis2<-seq(0,200,20) # generations
axis(1, at=axis1, labels=round(axis1*0.20))
axis(1, at=axis2, col.axis="gray", line = 1, tick=FALSE)

files <- paste("outfileLD_",1:100, "_GONE_Nebest", sep="")

NeMat <- NULL
for(i in 1:100){
  dat <- read.table(files[i],skip=2)
  NeMat <- cbind(NeMat,dat[,2])
}

# get CI
NeCI <- matrix(NA,nrow=200,ncol=2)
NeCI2 <- matrix(NA,nrow=200,ncol=2)

for(i in 1:200){
  NeCI[i,] <- quantile(NeMat[i,],probs=c(0.025,0.975))
  NeCI2[i,] <- quantile(NeMat[i,],probs=c(0.05,0.95))
}


# add gray polygon highlighting the years 2010-2014 (assuming present is 2023)
y <- c(0,0,5e06,5e06)
x <- c((13/0.20),(9/0.20),(9/0.20),(13/0.20))
polygon(x,y,col= "grey99")


lines(1:200,rowMedians(NeMat[1:200,]),col="orange",lwd=4)
#polygon(x=c(1:200,rev(1:200)),y=c(NeCI[1:200,1],rev(NeCI[1:200,2])),col=adjustcolor("#05BFC4",alpha.f=0.2),border=NA)
polygon(x=c(1:200,rev(1:200)),y=c(NeCI2[1:200,1],rev(NeCI2[1:200,2])),col=adjustcolor("orange",alpha.f=0.15),border=NA)

# plot eastern pop trends in hectares

par(mfrow=c(2,1))


plot(c(0,120),c(0,5000000),type="n",ylab=expression(paste("Historical ",italic(""*N*"")[e],sep="")), 
     xlab="Years before present", cex.lab=1, xaxt="n")
#mtext("Generations before present", col = "gray", side = 1, line = 4)
axis1<-seq(0,660,20) # years
#axis2<-seq(0,200,20) # generations
axis(1, at=axis1, labels=axis1*0.25)
#axis(1, at=axis2, col.axis="gray", line = 1, tick=FALSE)

files <- paste("outfileLD_",1:100, "_GONE_Nebest", sep="")

NeMat <- NULL
for(i in 1:100){
  dat <- read.table(files[i],skip=2)
  NeMat <- cbind(NeMat,dat[,2])
}

# get CI
NeCI <- matrix(NA,nrow=200,ncol=2)
NeCI2 <- matrix(NA,nrow=200,ncol=2)

for(i in 1:200){
  NeCI[i,] <- quantile(NeMat[i,],probs=c(0.025,0.975))
  NeCI2[i,] <- quantile(NeMat[i,],probs=c(0.05,0.95))
}


# add gray polygon highlighting the years 2010-2014 (assuming present is 2024)
y <- c(0,0,5e06,5e06)
x <- c((14/0.25),(10/0.25),(10/0.25),(14/0.25))
polygon(x,y,col= "grey99")


lines(1:120,rowMedians(NeMat[1:120,]),col="orange",lwd=4)
#polygon(x=c(1:200,rev(1:200)),y=c(NeCI[1:200,1],rev(NeCI[1:200,2])),col=adjustcolor("#05BFC4",alpha.f=0.2),border=NA)
polygon(x=c(1:120,rev(1:120)),y=c(NeCI2[1:120,1],rev(NeCI2[1:120,2])),col=adjustcolor("orange",alpha.f=0.15),border=NA)

eastern_hectares <- as.data.frame(read.table(file = "eastern_monarch_pop_trends.csv", sep = ",", header = T))


#plot(c(0,30), c(0,19), ylab="Hectares Occupied", xlab="Years before present", cex.lab=1, type="n")

plot(eastern_hectares$Years.before.Present..assuming.2023.is.present.[-32], eastern_hectares$Hectares.Occupied[-32],
     ylab="Hectares Occupied", xlab="Years before present", cex.lab=1)

y <- c(0.1,0.1,18.1,18.1)
x <- c((14),(10),(10),(14))
polygon(x,y)

smoothed_fit <- lowess(eastern_hectares$Years.before.Present..assuming.2023.is.present.[-32], eastern_hectares$Hectares.Occupied[-32], f = 2/3) 

lines(smoothed_fit, col = "orange", lwd = 4)