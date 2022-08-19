library(strucchange)
library(tseries)
library(astsa)
library(forecast)

#Fit different possible ARIMA models taking into account 
#the ACF and PACF plots (after adjusting 
#for stationarity and seasonality). Take approx 90% of
#the data and perform a head-to-head forecasting analysis 
#between 2 or 3 possible ARIMA models. Come up with the final model.

data("AirPassengers")
print(AirPassengers)
plot.ts(AirPassengers)
length(AirPassengers)
AirPassengers90<-AirPassengers[1:126]

#check for stationarity 
acf(AirPassengers90)
#not stationary as above the blue line
pacf(AirPassengers90)

#make it stationary by homogenizing the variance
plot(log(AirPassengers))

#remove the trend component by homogenizing the mean
AirPass<-diff(log(AirPassengers))
plot(AirPass)
#appears to be stationary

adf.test(AirPass)
#P-value is < 0.01, so we can assume is it stationary

#seasonality

acf(AirPass) #q=1
#Spikes after every 4th lag, showing seasonality
pacf(AirPass) #p=0
#appears to be an MA1 

plot(AirPass[20:50],type="l")

#taking seasonal difference
seasAP<-diff(AirPass,lag=12)
plot(seasAP[20:50],type="l")
#appears less seasonal

acf(seasAP) #q value =1
pacf(seasAP) #p value = 0
#appears to be an MA 1

#ARIMA (p,d,q)(P,D,Q)s

sarima(AirPass,0,0,1,0,0,1,12)
#aic = -331.42

#compare with other models to make sure the AIC is lowest
sarima(AirPass,0,0,1,1,1,2,12)
#aic = -478.92

sarima(AirPass,1,0,1,0,1,1,12)
#aic = -479.94

sarima(AirPass,0,0,2,0,1,1,12)
#aic = -479.64

#the  AR1MA1 & SMA1 appears with the first difference appears to be the best model
finalAP<-sarima(AirPass,1,0,1,0,1,1,12)
finalAP
#check t values

#fitted values Yt-et hat =Ythat
ArimaAPfit<-AirPassengers90-residuals(finalAP)

#forecast
APForecast<-sarima.for(AirPassengers90,12,1,0,1,0,1,1,12)
APForecast
#captures the overall trend and magnitude

checkresiduals(finalAP)

#mean reverting so white noise
#more or less bw blue bands so covariance = 0
#more or less normal bell shaped
