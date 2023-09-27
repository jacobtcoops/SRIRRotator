function SN3DtoN3D(inputPath,outputPath)
%SRIRRotator converts SRIRs from SN3D to N3D
%   function takes a set of SRIRs and converts them from SN3D normalisation
%   to N3D
%   in the case where any SRIR exceeds a value of 1, the entire dataset
%   will be normalised against the highest value (this will be scaled to
%   0.99)
%   INPUTS
%       inputPath   directory for input SRIRs
%       outputPath  directory for output SRIRs

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
    
    % find sample rate of first SRIR
    [~, Fs] = audioread(strcat(inputPath, '\', SRIRs(1).name));
    
    % % array to hold N3D output and normalised output
    N3D = cell(1, numel(SRIRs));
    N3D_Normalised = cell(1, numel(SRIRs));
    
    tic
    
    % convert to N3D
    parfor i = 1:numel(SRIRs)
        % read in SRIR
        [rawIR, Fs] = audioread(strcat(inputPath, '\', SRIRs(i).name));
    
        % convert SRIRs from SN3D to N3D
        N3D{i} = convert_N3D_SN3D(rawIR, 'sn2n');
    end
    
    % array to hold the maximum value of each SRIR
    maxima = zeros(1, numel(N3D));
    
    % find maximum peak across all IRs
    parfor j = 1: numel(N3D)
        % array of maxima across the IRs
        maxima(j) = max(abs(N3D{j}), [], 'all');
    end
    
    % maximum value across dataset
    maximum = max(maxima);

    if maximum >= 1
        % normalise IRs relative to the maximum peak across all of them
        parfor k = 1: numel(N3D)
            % set maximum value across dataset to 0.99
            N3D_Normalised{k} = 0.99 * N3D{k}./maximum;
        end
    end
    
    % write all SRIRs to audio files
    for m = 1: numel(N3D)
        % write to file
        audiowrite( strcat(outputPath, '\', SRIRs(m).name), N3D_Normalised{m}, ...
                    Fs, 'BitsPerSample', 24);
    end
    
    toc
end