function SRIRRotator(inputPath,outputPath, yaw, pitch, roll)
%SRIRRotator rotates SRIRs by given yaw, pitch and roll values
%   function takes a set of SRIRs, rotates them by the input yaw, pitch and
%   roll values (in the order given) and saves them
%   INPUTS
%       inputPath   directory for input SRIRs
%       outputPath  directory for output SRIRs
%       yaw         yaw rotation (degrees)
%       pitch       pitch rotation (degrees)
%       roll        roll rotation (degrees)

    % paths for externals
    HOALibraryPath = 'externals\Higher-Order-Ambisonics';
    SHTLibraryPath = 'externals\Spherical-Harmonic-Transform';
    
    % add required paths
    addpath(HOALibraryPath);
    addpath(SHTLibraryPath);
    
    % if the output file path does not excist, create it (surpress warning)
    mkdir(outputPath);

    % place all .wav files in struct
    SRIRs = dir(fullfile(inputPath,'*.wav'));

    tic

    parfor i = 1:numel(SRIRs)
        % read in SRIR
        [rawIR, Fs] = audioread(strcat(inputPath, '\', SRIRs(i).name));
    
        % convert SRIRs from SN3D to N3D
        N3D = convert_N3D_SN3D(rawIR, 'sn2n');
        
        % rotate SRIRs by the required amount
        rotated = rotateHOA_N3D(N3D, yaw, pitch, roll);
        
        % convert SRIRs from N3D to SN3D post-rotation
        SN3D = convert_N3D_SN3D(rotated, 'n2sn');
    
        % write to file
        audiowrite( strcat(outputPath, '\', SRIRs(i).name), SN3D, ...
                    Fs, 'BitsPerSample', 24);
    end

    toc

end