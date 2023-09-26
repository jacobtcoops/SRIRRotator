function [outputArg1,outputArg2] = SRIRRotator(inputPath,outputPath, yaw, pitch, roll)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    HOALibraryPath = 'externals\Higher-Order-Ambisonics';
    SHTLibraryPath = 'externals\Spherical-Harmonic-Transform';
    
    addpath(HOALibraryPath);
    addpath(SHTLibraryPath);
    
    mkdir(outputPath);

    % Place all .wav files in structs
    fileStruct = dir(fullfile(inputPath,'*.wav'));

    tic

    parfor i = 1:numel(fileStruct)
    
        [rawIR, Fs] = audioread(strcat(inputPath, '\', fileStruct(i).name));
    
        % Convert SRIRs from SN3D to N3D for rotation
        N3D = convert_N3D_SN3D(rawIR, 'sn2n');
        
        % Rotate SRIRs by the required amount
        rotated = rotateHOA_N3D(N3D, yaw, pitch, roll);
        
        % Convret SRIRs from N3D to SN3D post-rotation
        SN3D = convert_N3D_SN3D(rotated, 'n2sn');
    
        audiowrite( strcat(outputPath, '\', fileStruct(i).name), SN3D, ...
                    Fs, 'BitsPerSample', 24);

    end

    toc

end