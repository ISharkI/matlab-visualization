%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE: visualizeSignal("inputFileLocation", [loaderModuleNumber], [FilterModuleArray, OutputModuleArray])
% Parameters
%   inputFileLocation,              % defines location of file to load
% 
% Optional Parameters
%   loaderModuleNumber,             % number of loader module
%   FilterModuleArray,              % single line array of filters to be executed
%   OutputModuleArray               % single line array of output methods

% examples
% display input signal from m file: visualizeSignal(example.m)
% display signal after low pass:    visualizeSignal(1, example.m, [2], [1])

% BEGIN, main function (supervisor)
function visualizeSignal(
    loaderModuleNumber,
    inputFileLocation,
    FilterModuleArray,
    OutputModuleArray
)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BEGIN check input parameters for consistency
    
    % check if loader is chosen and set matlab loader if not given

    % check if arrays are set and set defaults if not
    if ~exist('FilterModuleArray','var')
        FilterModuleArray = [1];
    end
    if ~exist('OutputModuleArray','var')
        OutputModuleArray = [1];
    end
    
    % check if arrays match in dimension
    [rf,cf] = size(FilterModuleArray);
    [ro,co] = size(OutputModuleArray);
    if ~(rf == 1 || ro == 1)
        fprintf('Array has more than 1 row!')
    end
    
    if ~(cf == co)
        fprintf('Arrays do not match in dimension!') 
    end

    % check if file exists
    if exist(inputFileLocation, 'file') ~= 2
        fprintf('Found no input File!')
    end
    
    
        
% only one plot at a time
if (sum(plot_en)!=1)
  plot_en = [1 0 0 0];
  warning("setting  'plot_en = [1 0 0 0]'");
end

  if (plot_en(1) && (Nsym>128))  Nsym = 128; warning("setting  'Nsym = 128'");  end

  if (Nsym>100000)  Nsym=100000; warning("setting  'Nsym = 100000'");  end
  if (Nsym<1)       Nsym=1;      warning("setting  'Nsym = 1'");       end

  if (nb_bits_per_real_comp>8)     nb_bits_per_real_comp=8;    warning("setting  'nb_bits_per_real_comp = 8'");     end
  if (nb_bits_per_real_comp<1)     nb_bits_per_real_comp=1;    warning("setting  'nb_bits_per_real_comp = 1'");     end

  if (ovsamp>32)     ovsamp=32;    warning("setting  'ovsamp = 32'");     end
  if (ovsamp<1)      ovsamp=1;     warning("setting  'ovsamp = 1'");      end

  if (h_rc_sym_len>64)  h_rc_sym_len=64;    warning("setting  'h_rc_sym_len = 64'");     end
  if (h_rc_sym_len<4)   h_rc_sym_len=4;     warning("setting  'h_rc_sym_len = 4'");      end

  if (h_rc_alpha>1)  h_rc_alpha=1;    warning("setting  'h_rc_alpha = 1'");     end
  if (h_rc_alpha<0)  h_rc_alpha=0;    warning("setting  'h_rc_alpha = 0'");     end


  % adjust input parameters
  if (h_rc_alpha==0) h_rc_alpha = 0.00001; end
  if (h_rc_alpha==1) h_rc_alpha = 0.9999;  end


  % END check input parameters for consistency
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % RGB color definitions, http://www.rapidtables.com/web/color/RGB_Color.htm
  gray =    [[0,0,0]; [32,32,32]; [64,64,64]; [96,96,96]; [128,128,128]; [160,160,160]; [192,192,192]; [224,224,224]; [255,255,255]]/255;
  violett = [[51,0,25]; [102,0,51]; [153,0,76]; [204,0,102]; [255,0,127]; [255,51,153]; [255,102,178]; [255,153,204]; [255,204,229]]/255;
  magenta = [[51,0,51]; [102,0,102]; [153,0,153]; [204,0,204]; [255,0,255]; [255,51,255]; [255,102,255]; [255,153,255]; [255,204,255]]/255;
  lilac   = [[25,0,51]; [51,0,102]; [76,0,153]; [102,0,204]; [127,0,255]; [153,51,255]; [178,102,255]; [204,153,255]; [229,204,255]]/255;
  blue    = [[0,0,51]; [0,0,102]; [0,0,153]; [0,0,204]; [0,0,255]; [51,51,255]; [102,102,255]; [153,153,255]; [204,204,255]]/255;
  seablue = [[0,25,51]; [0,51,102]; [0,76,153]; [0,102,204]; [0,128,255]; [51,153,255]; [102,178,255]; [153,204,255]; [204,229,255]]/255;
  cyan    = [[0,51,51]; [0,102,102]; [0,153,153]; [0,204,204]; [0,255,255]; [51,255,255]; [102,255,255]; [153,255,255]; [204,255,255]]/255;
  seagreen = [[0,51,25]; [0,102,51]; [0,153,76]; [0,204,102]; [0,255,128]; [51,255,153]; [102,255,178]; [153,255,204]; [204,255,229]]/255;
  green   = [[0,51,0]; [0,102,0]; [0,153,0]; [0,204,0]; [0,255,0]; [51,255,51]; [102,255,102]; [153,255,153]; [204,255,204]]/255;
  lightgreen = [[25,51,0]; [51,102,0]; [76,153,0]; [102,204,0]; [128,255,0]; [153,255,51]; [178,255,102]; [204,255,153]; [229,255,204]]/255;
  yellow  = [[51,51,0]; [102,102,0]; [153,153,0]; [204,204,0]; [255,255,0]; [255,255,51]; [255,255,102]; [255,255,153]; [255,255,204]]/255;
  amber   = [[51,25,0]; [102,51,0]; [153,76,0]; [204,102,0]; [255,128,0]; [255,153,51]; [255,178,102]; [255,204,153]; [255,229,204]]/255;
  red     = [[51,0,0]; [102,0,0]; [153,0,0]; [204,0,0]; [255,0,0]; [255,51,51]; [255,102,102]; [255,153,153]; [255,204,204]]/255;

  % other initializations
  if (plot_en(2))
    normalize_en=1;  % to make f-domain plot look nice (use =1 for t-domain plot)
  else
    normalize_en=0;
  end


  % time base
  Tsamp = Tsym/ovsamp; % for labeling x-axis: duration of one discrete time index (in seconds)

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % BEGIN, set up graphical output

  % Create an invisible figure.
  if (webdemo_en)
    fig = figure(1); set(fig, "visible", "off");
  else
    fig = figure(1); set(fig, "visible", "on");
  end


  landscape = "-S930,350";
  portrait  = "-S640,480";

  output_format = landscape;     % default


  set(0, "defaultlinelinewidth", 2);

  if (webdemo_en)
    set(0, "defaultaxesfontsize", 8);
    set(0, "defaultaxesfontname", "Arial");
    set(0, "defaulttextfontsize", 8);
    set(0, "defaulttextfontname", "Arial");
    const_lw = 2;
    const_msize = 4;
  elseif (svg_en)
    set(0, "defaultaxesfontsize", 6);
    set(0, "defaultaxesfontname", "Arial");
    set(0, "defaulttextfontsize", 6);
    set(0, "defaulttextfontname", "Arial");
    const_lw = 1;
    const_msize = 3;
  else
    set(0, "defaultaxesfontsize", 10);
    set(0, "defaultaxesfontname", "Arial");
    set(0, "defaulttextfontsize", 8);
    set(0, "defaulttextfontname", "Arial");
    const_lw = 2;
    const_msize = 2;
  end

  % END, set up graphical output
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




  % reset random variable generator
  if (rnd_data_en==0)
    rnd_val_gen_seed = (1:200); % arbitrary vector of length <=625 to init. rnd val generator to always same sequence
    rand("state", rnd_val_gen_seed);
  end



  % get pulse used for pulse shaping
  [h_rc0, t_rc_n0, rc_av_pow0] = get_rc_t_imp_resp_h(0, h_rc_sym_len, ovsamp, normalize_en, complex_en);     % alpha=0, for power norm.
  [h_rc, t_rc_n, rc_av_pow] = get_rc_t_imp_resp_h(h_rc_alpha, h_rc_sym_len, ovsamp, normalize_en, complex_en);
  h_rc_len = length(h_rc);

  % NOTE: power of raised cosine imp. only normalized to 1 for alpha=0 (then spectrum rect.)
  % alpha>0 has greater power... need this factor to correctly plot analyt. ref. curve in spectrum
  rc_pow_corr_factor = rc_av_pow0/rc_av_pow;




  [s_re, rampup_len, rampdown_len, u_re] = generate_t_domain_pulse_drain(Nsym, nb_bits_per_real_comp, ovsamp, h_rc, rnd_data_en, normalize_en, exclude_rampup_en);

  if (complex_en==0)
    s=s_re;
  else
    [s_im, rampup_len, rampdown_len, u_im] = generate_t_domain_pulse_drain(Nsym, nb_bits_per_real_comp, ovsamp, h_rc, rnd_data_en, normalize_en, exclude_rampup_en);
    s = s_re+j*s_im;
  end





  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % BEGIN, generate plots
  % note: always generate plots from main function

  clf
  hold on

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%% plot time domain signal (real part only)
  if plot_en(1)
    s_len = length(s_re);
    xlim([0, (s_len-1)*Tsamp]);
    ylim([-2.5, 2.5]);
    xlabel("time t in sec.");
    ylabel("discrete-time sample-value");

    if (exclude_rampup_en==0)
      rectangle("Position",[0,-2.5,(rampup_len-1)*Tsamp,5],"FaceColor", magenta(7,:),"EdgeColor", magenta(7,:));              % mark filter ramp-up
      rectangle("Position",[(s_len-rampdown_len)*Tsamp,-2.5,(s_len-1)*Tsamp,5],"FaceColor",magenta(7,:),"EdgeColor",magenta(7,:));  % mark filter ramp-down
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% for illustration, plot individual impulses
    if (show_indiv_imp_en)

      if (exclude_rampup_en)
        t_offset = -floor(length(h_rc)/2);
      else
        t_offset = 0;
      end

      RGBpalette=jet(Nsym);    % returns Nsym x 3 matrix
      for t_n = (1:Nsym)
        RGBcolor=RGBpalette(t_n,:);          % get t_n's row, i.e., returns 1x3 vector
        plot(  (((t_n-1)*ovsamp:h_rc_len-1+(t_n-1)*ovsamp)+t_offset)*Tsamp , u_re(t_n)*h_rc, "o-", "markersize", 2, 'linewidth', 1, "color", RGBcolor);
      end
    end

    plot((0:s_len-1)*Tsamp, s_re, "o-", "markersize", 1, 'linewidth',3, "color", "b");            % oversampled signal
    stem((rampup_len:ovsamp:rampup_len+Nsym*ovsamp-1)*Tsamp, u_re, 'linewidth',2, "markerfacecolor", "r", "color", "r");

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%% plot spectrum
  elseif plot_en(2)

    [H_magn_sq, f_axis, N_disp_fbins, N_nyq_fbins] = compute_spectrum(s, ovsamp);
    
    fsamp = 1/(N_nyq_fbins*Tsamp*ovsamp);   % sampling frequency for x-axis labeling

    % set up plot output
    xlabel("frequency f in Hz");
    xlim([-N_disp_fbins/2, N_disp_fbins/2]*fsamp);       % fix to relevant spectral portions

    if (spectrum_dB_en)

      if (H_magn_sq_en)  ylabel("squared spectral magnitude |H(f)|^2 in dB");
                   else  ylabel("spectral magnitude |H(f)| in dB");    end

      rectangle("Position",[-N_disp_fbins/2*fsamp,-60, (N_disp_fbins-N_nyq_fbins)/2*fsamp,80],"FaceColor",magenta(7,:),"EdgeColor",magenta(7,:));
      rectangle("Position",[+(N_disp_fbins-N_nyq_fbins)/2*fsamp,-60, (N_disp_fbins-N_nyq_fbins)/2*fsamp,80],"FaceColor",magenta(7,:),"EdgeColor",magenta(7,:));

      if (complex_en==0)
        rectangle("Position",[-N_nyq_fbins/2*fsamp,-60, N_nyq_fbins/2*fsamp,80],"FaceColor",magenta(9,:),"EdgeColor",magenta(9,:));
      end

      ylim([-60, 20]);

      if (H_magn_sq_en)
        y_plot = 10*log10(H_magn_sq);
      else
        y_plot =  10*log10(H_magn_sq .^ (0.5));
      end

      plot(f_axis*fsamp, y_plot, 'linewidth',2, "b");
    else
      if (H_magn_sq_en)  ylabel("squared spectral magnitude |H(f)|^2");
                   else  ylabel("spectral magnitude |H(f)|");    end

      rectangle("Position",[-N_disp_fbins/2*fsamp,-0.5, (N_disp_fbins-N_nyq_fbins)/2*fsamp,2.5],"FaceColor",magenta(7,:),"EdgeColor",magenta(7,:));
      rectangle("Position",[+(N_disp_fbins-N_nyq_fbins)/2*fsamp,-0.5, (N_disp_fbins-N_nyq_fbins)/2*fsamp,2.5],"FaceColor",magenta(7,:),"EdgeColor",magenta(7,:));

      if (complex_en==0)
        rectangle("Position",[-N_nyq_fbins/2*fsamp,-0.5, N_nyq_fbins/2*fsamp,2.5],"FaceColor",magenta(9,:),"EdgeColor",magenta(9,:));
      end

      ylim([-0.5, 2]);

      if (H_magn_sq_en)
        y_plot = H_magn_sq;
      else
        y_plot = H_magn_sq .^ (0.5);
      end

      plot(f_axis*fsamp, y_plot, 'linewidth',2, "b");
    end

    % also plot theoret. curve
    H_ref_magn_sq = get_rc_f_imp_resp_H(h_rc_alpha, N_nyq_fbins/2) .^ 2;
    H_ref_magn_sq = H_ref_magn_sq * rc_pow_corr_factor;
    H_ref_len = length(H_ref_magn_sq);
    if (spectrum_dB_en)
      if (H_magn_sq_en)   y_plot = 10*log10(H_ref_magn_sq);  else   y_plot = 10*log10(H_ref_magn_sq .^ (0.5));   end
      plot((-floor(H_ref_len/2):floor(H_ref_len/2))*fsamp, y_plot, 'linewidth', 4, "r");
    else
      if (H_magn_sq_en)   y_plot = H_ref_magn_sq;  else   y_plot = H_ref_magn_sq .^ (0.5);   end
      plot((-floor(H_ref_len/2):floor(H_ref_len/2))*fsamp, y_plot, 'linewidth', 4, "r");
    end

    output_format = portrait;

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%  plot phase diagram ("Ortskurve") for illustrating offset QAM (mainly OQPSK)
  elseif plot_en(3)
    xlabel("real, inphase component");
    ylabel("imaginary, quadrature component");
    plot(s_re, s_im, "color", "r");
    t_offset = ovsamp/2;
    plot(s_re(1+t_offset:end), s_im(1:end-t_offset), "color", "b"); % to illustrate offset-QPSK

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%% plot individual pulse
  elseif plot_en(4)
    grid on
    xlabel("time t in sec.");
    ylabel("discrete-time sample-value");
    plot(t_rc_n, h_rc, 'linewidth',2, "o-", "markersize", 2, "color", "b");   % for debugging
  end

  hold off

  % END, generate plots
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % BEGIN, output to file

  print(filename, "-dpng",output_format);

  if (svg_en)
    print(["fig_",filename], "-dsvg",output_format);
  end

  % END, output to file
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end

% END, main program (control)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%














%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BEGIN, function definitions


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y=get_random_PAM_vector(nb_bits, N)
  M = 2^nb_bits;                          % nb of ampl. levels
  ampl_vec = (-M+1:2:M-1);                % ampl. levels
  prob_vec = ones(1,M)*1/M;               % all equally probable
  P_av = 1/M*sum(ampl_vec.^2);
  y=discrete_rnd(ampl_vec/sqrt(P_av), prob_vec, 1, N);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% note: len is nb of taps without considering oversampling
function [h, t_n, av_pow] = get_rc_t_imp_resp_h(alpha, len, ovsamp, normalize_en, complex_en)

  if (mod(len,2)==0)
    t_n = (-floor(len/2):1/ovsamp:floor(len/2)-1/ovsamp);
  else
    t_n = (-floor(len/2)-1.0/2:1/ovsamp:ceil(len/2)-1.0/2-1/ovsamp);
  end

  h = zeros(1,length(t_n));

  k=1;
  for n=t_n
    numerator   = sinc(n)*cos(pi*alpha*n);
    denominator = 1-(2*alpha*n)^2;

%    if (denominator==0) denominator=1e-5; end
    if (denominator==0)
      numerator = sinc(1/2/alpha)*pi/4;    % limit
      denominator=1;
    end

    h(k) = numerator/denominator;
    k=k+1;
%%    h = sinc(t_n).*cos(pi.*alpha.*t_n)./(1-(2.*alpha.*t_n).^2);
%%    h( t_n == inf ) = sinc(1./(2.*alpha)).*pi./4; % for t_n = 1 / (2*alpha) formula for h_t_n yields 0/0 --> bring to limit value
  end


  % normalize
  if (normalize_en)
    av_pow = sum(h .^ 2);
    h = h/sqrt(av_pow);
    if (complex_en)
      h = h/sqrt(2);
    end
  end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% normalized?
function H_f_n = get_rc_f_imp_resp_H(alpha, ovsamp)

  f_n = (0:1/ovsamp:3)/2/pi;

  % compute H(f_n)
  % first positive frequency axis (0 <= f_ n<= 3)
  H_f_n = (cos(pi./4./alpha.*(2*pi*f_n-1+alpha))).^2;
  H_f_n (f_n <=(1-alpha)/2/pi) = 1;
  H_f_n (f_n >= (1+alpha)/2/pi) = 0;
  % add negative axis
  H_f_n = [H_f_n(end:-1:2), H_f_n];
  f_n = [-f_n(end:-1:2), f_n];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% insert zeroes
function y = upsample(x, usf)
  len = length(x);
  y = zeros(1,len*usf);
  for k=0:len-1
    y(1+k*usf) = x(1+k);
  end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [y, rampup_len, rampdown_len, u] = generate_t_domain_pulse_drain(Nsym, nb_bits_per_real_comp, ovsamp, h_rc, rnd_data_en, normalize_en, exclude_rampup_en)

  % generate random BPSK data
  u = get_random_PAM_vector(nb_bits_per_real_comp, Nsym);
  % for small nb of PAM symbols, impose constant sign pattern for better illustration
  if ((Nsym<6) & (rnd_data_en==0))
    u = [1,1,-1,1,-1,-1](1:Nsym) .* abs(u);
  end

  u_up = upsample(u,ovsamp);

  % remove trailing zeros
  u_up = u_up(1:end-(ovsamp-1));

  rampup_len   = floor(length(h_rc)/2);
  rampdown_len = rampup_len-1;

%printf("rampup_len = %hd\n",rampup_len);

  y = conv(u_up, h_rc);                % convolution in t-domain

  if (exclude_rampup_en)
    y = y(1+rampup_len:end-rampdown_len);
    rampup_len=0;
    rampdown_len=0;
  end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [y_magn_sq, f_axis, N_disp_fbins, N_nyq_fbins] = compute_spectrum(s, ovsamp)

  s_len = length(s);

%sum(s .* conj(s))  % power ok

  N_nyq_fbins = 101;  % fix nb of freq. bins in Nyq. bandwidth


  % Note:
  % - each frequency bin has bandwidth (1/(Ts/ovsamp))/s_len; if Ts is the PAM symbol duration, then the Nyquist bw is 1/Ts
  % - fix to  (1/Ts)/N_nyq_fbins *1/2  (*1/2, since a total bandwidth of 2 Ny BW should be displayed)
  % - for this: 1. append zeros prior to fft such that s_len/ovsamp is integer mult. of 2*N_nyq_fbins = N_disp_fbins

  N_disp_fbins = 2*N_nyq_fbins;   % display a spectrum of twice the Nyq-BW

  N_append_zeros = rem(N_disp_fbins-rem(s_len/ovsamp, N_disp_fbins),N_disp_fbins) * ovsamp;

  s = [s, zeros(1, N_append_zeros)];


  s_len = length(s);

  y = fft(s)/sqrt(s_len);
  y_magn_sq = real(y .* conj(y));

%sum(y .* conj(y))   % power ok

  % re-sort neg.freq. for plotting
  y_magn_sq = [y_magn_sq(1+floor(s_len/2):s_len), y_magn_sq(1:floor(s_len/2))];

  %             2. after fft, sum up, each, energy of (s_len/ovsamp)/N_nyq_fbins freq. bins

  N_sum_bins = (s_len/ovsamp)/N_nyq_fbins;
  N_tot_fbins = s_len/N_sum_bins;         % total nb of freq. bins after summation

  % sum over freq. bins
  for new_bin = 0:N_tot_fbins-1-1
%    y_magn_sq(1+new_bin) = sum(y_magn_sq( 1+new_bin*N_sum_bins : 1+new_bin*N_sum_bins+N_sum_bins-1 ))/N_sum_bins;
    % NOTE: done this way (average of neighboring bin-sums over 2) to get sym. spectrum for s real
    y_magn_sq(1+new_bin) = (sum(y_magn_sq( 1+new_bin*N_sum_bins : 1+new_bin*N_sum_bins+N_sum_bins-1 ))/N_sum_bins
                           +sum(y_magn_sq( 1+1+new_bin*N_sum_bins : 1+1+new_bin*N_sum_bins+N_sum_bins-1 ))/N_sum_bins ) /2;
  end

  y_magn_sq = y_magn_sq(1:N_tot_fbins);  % set new length

%N_sum_bins
%y_magn_sq = y_magn_sq/16;

%sum(y_magn_sq)    % power ok

  f_axis = ((-floor(N_tot_fbins/2):ceil(N_tot_fbins/2)-1) + 0.5); % +0.5 due to averaging of neighboring bins

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% END, function definitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%