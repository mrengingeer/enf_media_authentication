function [y1,y2,y3] = enf(x,Fs, BlockSize, ZeroPad, Overlap, Window, Frequency)
%Step 1: Create a function that can extract the ENF from a sound file
%Inputs: The signal, the sampling frequency of the signal, the size of your
%windows, the amount of zero padding, amount of overlap, windowing
%function, and which frequency you want to extract
%Outputs: The magnitude response, the weighted magnitude, and the max magnitude
%Steps: segment signal, window each segment, apply zero padding to each
%segment, perform FFT and get magnitude response, assign frequency indices,
%calculate weighted magnitude and maximum magnitude

diff =(BlockSize - (BlockSize*Overlap));                            %difference
c_length = (length(x) - (BlockSize +1));                            %column length
index_row = (1:BlockSize);                                          %index matrix row 
index_column = (0:diff:c_length);                                   %index matrix column
[IndexRow, IndexColumn] = meshgrid (index_row, index_column);       %meshgrid function
Result = x(IndexRow + IndexColumn);                                 %segmented result

[row_length, ~] = size(Result);
hanning_window = transpose(Window);                                  
window = repmat(hanning_window, row_length,1);                      %hanning window function
windowed_result = Result.*window;                                   %windowed result

z = repmat((zeros(1,ZeroPad)),row_length,1);                        %zero padding
zero_padded_arr = cat(2,windowed_result,z);                          
BlockSize = BlockSize + ZeroPad;                                    %account for zero padding and adjust the block size for preprocessing

fft_output = abs(fft(zero_padded_arr,length(zero_padded_arr),2));   %FFT  

freq = (Fs*(0:BlockSize-1))/(BlockSize);
desired_indicies = find(freq >=Frequency-1&freq<=Frequency+1);      %extract frequencies of interest
temp = freq(desired_indicies);

desired_freq = repmat(temp,length(index_column),1);                 %desired frequencies

y1 = fft_output(:,desired_indicies);                                %Magnitude Plot

[~,variable_maxmag] = max(y1,[],2);                     
y2 = temp(variable_maxmag);                                         %Maximum Magnitude Calculations

numerator = sum(desired_freq.*y1,2);                                %Weighthed Magnitude Calculations
denominator = sum(y1,2);

y3 = numerator ./denominator;               

end