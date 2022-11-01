%Surface plots for [60,120,180,240]Hz magnitude spectrum for recording.wav
%input parameters
Fs = 44100;                                     %sampling freq for step 1
BlockSize = Fs * 16;                            %block size 
ZeroPad = 0;                                    %no zero padding in this step
Overlap = 0.5;                                  %50% overlap
Window = hanning(BlockSize, 'periodic');        %windowing function
Frequency = 60;                                 %first frequency tested is 60Hz                    
x = audioread("recording.wav");                 %read audio test file 'Recording.wav'

[y1,y2,y3] = enf(x,Fs,BlockSize,ZeroPad,Overlap,Window,Frequency);
[a_60,b_60] = size(y1);
i_60 = Frequency - 1;
j_60 = Frequency + 1;
k_60 = (j_60 - i_60)/b_60;
l_60 = i_60:k_60:(j_60-k_60);
m_60 = 1:a_60;

surf(l_60,m_60,y1); 
title("Surface Plot for 60Hz Magnitude Spectrum of 'Recording.wav'");
figure;

%Repeat above steps at 120Hz
Frequency = 120; 
[y1,y2,y3] = enf(x,Fs,BlockSize,ZeroPad,Overlap,Window,Frequency);
[a_120,b_120] = size(y1);
i_120 = Frequency - 1;
j_120 = Frequency + 1;
k_120 = (j_120 - i_120)/b_120;
l_120 = i_120:k_120:(j_120-k_120);
m_120 = 1:a_120;

surf(l_120,m_120,y1); 
title("Surface Plot for 120Hz Magnitude Spectrum of 'Recording.wav'");
figure;

%Repeat above steps at 180Hz
Frequency = 180; 
[y1,y2,y3] = enf(x,Fs,BlockSize,ZeroPad,Overlap,Window,Frequency);
[a_180,b_180] = size(y1);
i_180 = Frequency - 1;
j_180 = Frequency + 1;
k_180 = (j_180 - i_180)/b_180;
l_180 = i_180:k_180:(j_180-k_180);
m_180 = 1:a_180;

surf(l_180,m_180,y1);
title("Surface Plot for 180Hz Magnitude Spectrum of 'Recording.wav'");
figure;

%Repeat above steps at 240Hz
Frequency = 240; 
[y1,y2,y3] = enf(x,Fs,BlockSize,ZeroPad,Overlap,Window,Frequency);
[a_240,b_240] = size(y1);
i_240 = Frequency - 1;
j_240 = Frequency + 1;
k_240 = (j_240 - i_240)/b_240;
l_240 = i_240:k_240:(j_240-k_240);
m_240 = 1:a_240;

surf(l_240,m_240,y1); 
title("Surface Plot for 240Hz Magnitude Spectrum of 'Recording.wav'");
