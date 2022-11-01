%Comparison of recording.wav and ground truth.wav sound files without preprocessing: 
%surface plots for 120Hz, cross correlation plot, max and weighted magnitude plots after alignment
Fs = 44100;                                                 %sampling freq for step 1 
BlockSize = Fs * 16;                                        %block size
ZeroPad = 0;                                                %no zero padding in this step
Overlap = 0.5;                                              %50% overlap
Window = hanning(BlockSize, 'periodic');                    %windowing function
x = audioread("recording.wav");                             %read audio test file 'Recording.wav'
y = audioread("ground truth.wav");                          %read audio reference file 'Ground Truth.wav'

Frequency = 120;                                                                     %frequence tested at is 120Hz 
[y1,y2,y3] = enf(x,Fs,BlockSize,ZeroPad,Overlap,Window,Frequency);                   %function for test audio
[y1_ref,y2_ref,y3_ref] = enf(y,Fs,BlockSize,ZeroPad,Overlap,Window,Frequency);       %function for reference audio

[a,b] = size(y1);
i = Frequency - 1;
j = Frequency + 1;
k = (j - i)/b;
l = i:k:(j-k);
m = 1:a;

surf(l,m,y1); 
title("Surface Plot for 'Recording.wav' at 120Hz With No Preprocessing");
figure;

[a_ref, b_ref] = size(y1_ref);
i_ref = Frequency -1;
j_ref = Frequency + 1;
k_ref = (j_ref - i_ref)/b_ref;
l_ref = i_ref:k_ref:(j_ref - k_ref);
m_ref = 1:a_ref;

surf(l_ref,m_ref,y1_ref);
title("Surface Plot for 'Ground Truth.wav' at 120Hz With No Preprocessing");
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

plot(y3_ref); 
hold on; 
plot(y3); 
title("Weighted Magnitude Plot before Alignment"); 
figure; 
hold off;

parray = padarray(y2,2,mean(y2));       %padding the arrays with the delay
parray2 = padarray(y3,2,mean(y3));

plot(y2_ref); 
hold on; 
plot(parray); 
title ("Max Magnitude Plot after Alignment");
hold off;
figure;

plot(y3_ref); 
hold on; 
plot(parray2); 
title("Weighted Magnitude Plot after Alignment"); 

