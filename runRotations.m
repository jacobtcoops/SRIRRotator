close all
clear

% Paths for MV4
MV4_inputPath = 'D:\_RESOURCE\MaidaVale-IRs\230907-Zenodo-MV4_5\MV4\AS2\AS2\TOA';
MV4_rotatedPath = ['D:\_RESOURCE\MaidaVale-IRs\230925_1-Rotation-Compensated-MV4_5' ...
        '\MV4\AS2\AS2\TOA'];

% Required rotations for MV4
MV4_yaw = 0;
MV4_pitch = 0;
MV4_roll = 180;

% MV4 Rotation
SRIRRotator(MV4_inputPath, MV4_rotatedPath, MV4_yaw, MV4_pitch, MV4_roll);

% Paths for MV5
MV5_inputPath = 'D:\_RESOURCE\MaidaVale-IRs\230907-Zenodo-MV4_5\MV5\AS1\AS1\TOA';
MV5_rotatedPath = ['D:\_RESOURCE\MaidaVale-IRs\230925_1-Rotation-Compensated-MV4_5' ...
        '\MV5\AS1\AS1\TOA'];

% Required rotations for MV4
MV5_yaw = 90;
MV5_pitch = 0;
MV5_roll = 180;

% MV5 Rotation
SRIRRotator(MV5_inputPath, MV5_rotatedPath, MV5_yaw, MV5_pitch, MV5_roll);