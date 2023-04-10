% Clear workspace, command window, and close all figures
close all; clear; clc;

% Load the audio file
[input_audio, fs] = audioread('223.wav');

% Scale the audio signal to the range [0, 1023]
audio_scaled = rescale(input_audio, 0, 1023);

% Convert the audio signal to a vector
audio_vector = audio_scaled(:);

% Calculate the probability distribution of the audio samples
pdf = hist(audio_vector, 0:1023);
pdf = pdf / sum(pdf);

% Add an offset to the audio signal to ensure that all symbols have a non-zero probability
offset = 10;
audio_vector_offset = audio_vector + offset;

% Build a larger Huffman codebook using the probability distribution
codebook = huffmandict(0:1023, pdf);

% Encode the audio signal using the Huffman code
encoded_audio = huffmanenco(audio_vector_offset, codebook);

% Save the compressed audio as a WAV file
audiowrite('compressed_audio.wav', encoded_audio, fs);
