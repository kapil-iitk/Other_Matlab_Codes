clc;
clear all;
      f0 = input('Enter the operating frequency, f (in MHZ)             :');
      z0 = input('Enter the characteristic impedance on line, z (in ohm):');
      e0 = input('Enter the Dielectric constant of substrate, er        :');
      h0 = input('Enter the height of substrate, h (in mm)              :');
      t0 = input('Enter the thickness of conductor, t (in um)            :')
      
      t0=t0*1e-3;
      w0 = 1;
      ww = 0.5;
      ee = 1;
      n  = 0;
      PI = 3.141592659;
      
    while ee>0.001
      a  = (1+1/e0)/2;
      k1=(t0/h0)^2;
      k2=(PI*(w0/t0+1.1))^2;
      k3 = sqrt(k1+1/k2);
      k4 = log(4/k3);
      dw = t0*(1+k4)/PI;
      w1 = w0+a*dw;
      k5 = 4*h0/w1;
      b  = ((14+8/e0)/11)*k5;
      k6 = b^2;
      k7 = PI^2;
      k8 = sqrt(k6+a*k7);
      k9 = log(1+k5*(b+k8));
      k10= sqrt(e0+1);
      z  = 42.4/k10*k9;
      ao = 1;
      wo = w0+ao*dw;
      k11= 4*h0/wo;
      bo = 2*k11;
      k12= bo^2;
      k13= sqrt(k12+ao*k7);
      k14= log(1+k11*(bo+k13));
      k15= sqrt(2);
      zo = 42.4/k15*k14;
      ef0= (zo/z)^2;
      fp = z/(0.8*PI*h0);
      g  = 0.6+0.009*z;
      k16= ((f0/fp/1e3)^2);
      ef = e0-(e0-ef0)/(1+g*k16);
      k17= sqrt(ef0/ef);
      zz = z*k17;
      err= zz-z0;
      ee = abs(err);
      
      if(n==0)
           n=1;
           if (err<0)
             frg=0; 
           else
             frg=1;
           end
      end
  
      if err<0
           if frg==0
           w0 = w0-ww;
           else
               frg = 0;
               ww = ww/2;
           end
      else
           if frg==1
           w0 = w0+ww;
           else
               frg = 1;
               ww = ww/2;
           end
      end
    end
      clc
      fprintf('The characteristics impedance is    : %i\n', w0);
      fprintf('The width of microstrip feed line is: %i\n', w0);
      fprintf('The Effective Dielectric constant is: %i\n', ef);
      k  = sqrt(1/ef);
      lemb = 30*1e10*k/(f0*1e6);
      fprintf('The wavelength is                   : %i\n', lemb);
      l_pre=((300000/(3.328692*f0))-2.2);
      fprintf('The total slot length is            : %i\n', l_pre);
      freqs=input('Enter second discrete frequency (in MHz) :');
      l_pre_switch=((300000/(3.328692*freqs))-2.2);
      en_sw_loc=(l_pre-l_pre_switch);
      fprintf('The Switch location from slot end is, (in cm):%i\n', en_sw_loc);
