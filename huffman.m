% Step 1: Read the stereo audio file and quantize the signal
[audio_data, sample_rate] = audioread('223.wav');
quant_levels = 256;  % Adjust this value for different quantization levels
quantized_data = round(audio_data * (quant_levels - 1));

% Initialize variables for channels
encoded_data_channels = cell(1, 2);
dict_channels = cell(1, 2);

for channel = 1:2
    % Step 2: Calculate the symbol frequencies and probabilities
    symbols = unique(quantized_data(:, channel));
    frequencies = histcounts(quantized_data(:, channel), [symbols; max(symbols)+1]);
    probabilities = frequencies / numel(quantized_data(:, channel));
    
    % Step 3: Build the Huffman tree and create the codebook
    dict_channels{channel} = huffmandict(symbols, probabilities);
    
    % Step 4: Encode the audio data using the codebook
    encoded_data_channels{channel} = huffmanenco(quantized_data(:, channel), dict_channels{channel});
end

% Step 5: Save the compressed data and codebooks to a file
save('compressed_stereo_audio.mat', 'encoded_data_channels', 'dict_channels', 'sample_rate');

% Optional - Step 6: Decode the compressed data and compare it with the original
decoded_data_channels = cell(1, 2);

for channel = 1:2
    decoded_data_channels{channel} = huffmandeco(encoded_data_channels{channel}, dict_channels{channel});
end

decoded_audio = [double(decoded_data_channels{1}), double(decoded_data_channels{2})] / (quant_levels - 1);

% Output the decoded audio as a WAV file
audiowrite('decoded_audio.wav', decoded_audio, sample_rate);

% Play the decoded audio (optional)
sound(decoded_audio, sample_rate);
