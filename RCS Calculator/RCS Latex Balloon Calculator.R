# R code to calculate the RCS of a latex balloon 
# based on MATLAB code by Geoffrey Goldman in September 2009 

ep <- 2.5     # epsilon for latex
nt <- sqrt(ep)  # latex index of refraction 
ni <- 1       # air 
c <- 3e8      # speed of light 

mass <- 1.6  # kg 
p <- 940     # density 
radius <- 1  # radius of sphere (meters) 

area <- 4*pi*radius^2  # approximate surface area of balloon 

dr <- mass/(p*area)    # approximate width of balloon 

radius <- radius-dr    # radius of air sphere 
area <- 4*pi*(radius+dr/2)^2  # surface area of balloon 

dr <- mass/(p*area)    # width of balloon 

r_par <- (nt-ni)/(nt+ni)   # 4.47, pg 75, E Hecht, A Zajac, Optics 
r_per <- -r_par 

t <- 2*ni/(ni + nt)  # both par and perpen 4.48 pg 75 ,E Hecht, A Zajac, Optics 

tp_par <- 2*nt/(ni + nt) 
tp_per <- 2*nt/(ni + nt) 

t_tp <- 1-r_par^2 

E0 <- (pi*radius^2)^0.5 

freq_array <- seq(2, 10, by = 0.0025)*1e9  # calculate at these frequencies 
Nfreq <- length(freq_array)

rcs_par <- numeric(Nfreq)
rcs_per <- numeric(Nfreq)

for (freq1 in 1:Nfreq) {
  
  freq <- freq_array[freq1]     
  lambda_air <- c/freq 
  lambda_balloon <- c/(freq*nt) 
  phase_term <- exp(-1i*4*pi*dr/lambda_balloon) 
  
  E0r_par <- E0*r_par*(1-phase_term)/(1-phase_term*r_par^2)  # pg 305 , 9.29 b, E Hecht, A Zajac, Optics
  E0r_per <- E0*r_per*(1-phase_term)/(1-phase_term*r_per^2)  # pg 305 , 9.29 b, E Hecht, A Zajac, Optics 
  
  E0t_par <- E0*t_tp/(1-phase_term*r_par^2)  # pg 305 , 9.29 b, E Hecht, A Zajac, Optics 
  E0t_per <- E0*t_tp/(1-phase_term*r_per^2)  # pg 305 , 9.29 b, E Hecht, A Zajac, Optics 
  
  E0r_par <- E0r_par + E0t_par^2*(E0r_par/E0)*exp(-1i*radius*8*pi/lambda_air) 
  E0r_per <- E0r_per + E0t_per^2*(E0r_par/E0)*exp(-1i*radius*8*pi/lambda_air) 
  
  rcs_par[freq1] <- abs(E0r_par)^2 
  rcs_per[freq1] <- abs(E0r_per)^2 
}

# Plot the RCS as a function of frequency
plot(freq_array/1e9, 10*log10(rcs_par/E0^2), type='l', xlab='Frequency (GHz)', ylab='RCS (dBsm)', ylim=c(-50,-20))

# Set the plot title and adjust the font size
title('RCS of a Latex Balloon')
par(cex.lab=1.5, cex.main=2)