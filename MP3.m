% Read WAV file
input_file = '223.wav';
[signal, sample_rate] = audioread(input_file);

% Set output MP3 file name
output_file = 'output_audio.mp3';

% Path to LAME executable (If LAME is in your system PATH, you can just use 'lame')
lame_executable = 'C:\Users\BXLCS\Desktop\lame\lame.exe'; % Replace with the path to your lame.exe

% Compress WAV to MP3 using LAME
command = sprintf('%s -b 128 "%s" "%s"', lame_executable, input_file, output_file);
system(command);