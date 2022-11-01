%Comparison of recording.wav and ground truth.wav sound files WITH preprocessing: 
%surface plots for 120Hz, cross correlation plot, max and weighted magnitude plots after alignment

%input parameters
Fs = 441;                                           %sampling frequency for step 3
BlockSize = Fs*16;                                  %block size
ZeroPad = 16384 - (16*Fs);                          %zero padding is done in this step
Overlap = 0.5;                                      %50% overlapping
Window = hanning(BlockSize, 'periodic');            %windowing function
Frequency = 120;                                    %tested at 120Hz

load('SOS.mat');                                    %load filter variables  
load('G.mat');
x = audioread("recording.wav");                     %read audio test file 'Recording.wav'
y = audioread("ground truth.wav");                  %read audio reference file 'Ground Truth.wav'
x_filtered = filtfilt(SOS,G,x);                     %filter reference signal
y_filtered = filtfilt(SOS,G,y);                     %filter test signal 
x_processed = downsample(x_filtered,100);           %downsample by 100
y_processed = downsample(y_filtered,100);           %downsample by 100

[y1, y2, y3] = enf(x_processed, Fs, BlockSize, ZeroPad, Overlap, Window, Frequency);
[y1_ref, y2_ref, y3_ref] = enf(y_processed, Fs, BlockSize, ZeroPad, Overlap, Window, Frequency);

[a,b] = size(y1);
i = Frequency - 1;
j = Frequency + 1;
k = (j-i)/b;
l = i:k:(j-k);
m = 1:a;

surf(l,m,y1); 
title("Surface Plot for 'Recording.wav' at 120Hz With Preprocessing"'); 
figure; 

[a_ref,b_ref] = size(y1_ref);
i_ref = Frequency - 1;
j_ref = Frequency + 1;
k_ref = (j_ref-i_ref)/b_ref;
l_ref = i_ref:k_ref:(j_ref-k_ref);
m_ref = 1:a_ref;

surf(l_ref,m_ref,y1_ref); 
title("Surface Plot for 'Ground Truth.wav' at 120Hz With Preprocessing"); 
figure;

%Used the weighted magnitude for the correlation 
%Instead of normalized cross correlation, a zero mean cross correlation was used(did not
%divide by variances)
%Matlab’s xcorr function zero pads the shorter signal to be the same length as the longer one
x_difference = y3 - mean(y3);
y_difference = y3_ref - mean(y3_ref);
[n_diff, o_diff] = xcorr(y_difference, x_difference);

plot(o_diff,n_diff); 
title("Cross Correlation Plot"); 
figure;

plot(y3); 
hold on; 
plot(y3_ref); 
title("Weighted Magnitude Plot Before Allignment (Preprocessed)"); 
figure;
hold off;

parray = padarray(y3,2,mean(y3));           %padding the array with the delay to allign 
plot(y3_ref); 
hold on; 
plot(parray); 
title("Weighted Magnitude Plot After Allignment (Preprocessed)"); 
