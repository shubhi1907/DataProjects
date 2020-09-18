# ALY 6015 Assignment 5 - Time Series Analysis


#Part A-1
#Use birth dataset to plot a timeseries
#install.packages("tseries")
library(tseries)
#Reading in time series data
births <- scan("https://robjhyndman.com/tsdldata/data/nybirths.dat", skip=0)
head(births)

#Decompese the timeseries and plot the components
births_ts <- ts(births,start = c(1946,1),frequency=12)
head(births_ts)

#Plot time series
plot.ts(births_ts)

#Decompinsing time series
births_tsda <- decompose(births_ts,type = 'additive')
head(births_tsda)

births_tsdm <- decompose(births_ts,type = 'multiplicative')
head(births_tsdm)

#Plot the trend over time
plot(births_tsda)
plot(births_tsdm)

#Part A-2
#Estimating the time seies is additive or multiplicative model
#It is a additive model
#Remove the seasonality made the time series would contain only the trend component and an irregular component
#We have two ways to do it
#1st way
stlbirths_ts <- stl(births_ts,s.window = 'periodic')
plot(stlbirths_ts)
tsbirths_ts_without_seasonal=stlbirths_ts$time.series[,2]+
  stlbirths_ts$time.series[,3]
plot(tsbirths_ts_without_seasonal)

#2nd way
births_timeseries_seasonally_adjusted <- births_ts-births_tsda$seasonal
plot(births_timeseries_seasonally_adjusted)

#Part B-1
#1.Using the births dataset and plot a time series keeping start=c(1500)
births_tsb <-ts(births,start = c(1500))
births_tsb
plot.ts(births_tsb)

#Plot ACF and PACF and add coment
volcanodust <- scan("http://robjhyndman.com/tsdldata/annual/dvi.dat", skip=1)
volcanodust_ts <- ts(volcanodust,frequency = 12)
adf.test(volcanodust_ts,alternative = 'stationary')
#Thus d=0

#Part B-2
# install.packages("forecast")
# install.packages("ggplot2")
library(forecast)
library(ggplot2)

#To determine q,plot a partial autocorrelation correlogram:
#It is useful for helping determine the order for AR(P)
ggAcf(volcanodust_ts)
#According to this plot we should choose q=3

#To determine p, plot an autocorrelation correlogram (correlations by number of lags:
#It is useful for helping determine the order for MA(q) )
ggPacf(volcanodust_ts)
#According to this plot we should choose p=1

auto.arima(volcanodust_ts,seasonal=FALSE)
#Thus,proper p=1,q=0,d=2
Arima(1,0,2)


#Part B-3
#Fit an ARIMA model and make use of appropriate p, d, q values
#Fit model to training data (observed time serie data)
#volcanodust_ts
fit<-auto.arima(volcanodust_ts, seasonal=FALSE)
tsdisplay(residuals(fit), lag.max=45, main='(1,0,2) Model Residuals')

fit1=arima(volcanodust_ts, order=c(1,0,3))
tsdisplay(residuals(fit1), lag.max=15, main='Seasonal Model Residuals')

#Part B-3
#Perform forecast on the model and plot the forecast
#Make Predictions
#Let's forecast 30 days into the future:

#volcanodust
forecast <- forecast(fit, h=30)
plot(forecast)
forecast1 <- forecast(fit1, h=30)
plot(forecast1)








