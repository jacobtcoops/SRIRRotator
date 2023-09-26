HOALibraryPath = 'externals\Higher-Order-Ambisonics';
S

addpath(HOALibraryPath);

inputPath = 'D:\_RESOURCE\MaidaVale-IRs\230907-Zenodo-MV4_5\MV4\AS2\AS2\TOA';
rotatedPath = ['D:\_RESOURCE\MaidaVale-IRs\230925_1-Rotation-Compensated-MV4_5' ...
    '\MV4\AS2\AS2\TOA'];

% Place all .wav files in structs
fileStruct = dir(fullfile(inputPath,'*.wav'));

% Requried rotations for MV4
MV4_yaw = 0;
MV4_pitch = 0;
MV4_roll = 180;

MV5_yaw = 0;
MV5_pitch = 90;
MV5_roll = 180;

i = 1;

Fs = 48000;

% for i = 1:numel(wavlist)

    % Convert SRIRs from SN3D to N3D for rotation
    N3D = convert_N3D_SN3D(fileStruct(i).name, 'sn2n');
    
    % Rotate SRIRs by the required amount
    rotated = rotateHOA_N3D(N3D, MV4_yaw, MV4_pitch, MV4_roll);
    
    % Convret SRIRs from N3D to SN3D post-rotation
    SN3D = convert_N3D_SN3D(rotated, 'n2sn');

    audiowrite( strcat(rotatedPath, fileStruct(i).name), SN3D, ...
                Fs, 'BitsPerSample', 24);

% end
    
% end

