function SN3DtoN3D(inputPath,outputPath)
%SRIRRotator converts SRIRs from SN3D to N3D
%   function takes a set of SRIRs, rotates them by the input yaw, pitch and
%   roll values (in the order given) and saves them
%   INPUTS
%       inputFilePath   directory for input SRIRs
%       outputFilePath  directory for output SRIRs

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
    
        % write to file
        audiowrite( strcat(outputPath, '\', SRIRs(i).name), N3D, ...
                    Fs, 'BitsPerSample', 24);

    end

    toc

end