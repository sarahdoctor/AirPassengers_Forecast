# AirPassengers_Forecast
Using the Airplane package on R, a head-to-head forecasting analysis was conducted using apporximately 90% of the data. 

- The variance and mean of the data was homogenized to make it stationary and to remove the trend component.
- The Augmented Dickey-Fuller Test was employed to satisfy the condition of stationarity.
- The spikes after every 4th lag in the ACF showed the prevalence of seasonality, which was adjusted for by taking the seasonal difference.
- Multiple ARIMA models were tested to find the model of best fit. 
- The AR1MA1 & SMA1 was used for the forecast and appeared to capture the overall trend and magnitude.
- The residuals were checked and appeared to be mean reverting and relavitely bell shaped with a covariance of 0.
