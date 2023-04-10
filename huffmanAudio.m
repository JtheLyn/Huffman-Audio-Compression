close all; clear; clc;

%% Read the audio file
[sig, Fs] = audioread('swamp.mp3');

%% Extract the audio signal from the first channel
sigl = sig(:,1);

%% Quantize the audio signal
sig_quantized = round(sigl*(2^8-1))/(2^8-1);

%% Calculate the probability of occurrence of each symbol
symbols = unique(sig_quantized);
counts = histcounts(sig_quantized, length(symbols));
prob = counts/sum(counts);

%% Create a Huffman dictionary
dict = huffmandict(symbols, prob);

%% Encode the audio signal using the Huffman code
encoded_audio = huffmanenco(sig_quantized, dict);

%% Save the compressed audio as a WAV file
audiowrite('swamp_compressed.mp3', encoded_audio, Fs);
dequantized_audio = encoded_audio * (2^8-1);
audiowrite('swamp_deq.mp3', dequantized_audio, Fs);
