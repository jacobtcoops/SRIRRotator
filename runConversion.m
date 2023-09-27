close all
clear

% Paths for MV4
MV4_rotatedPath = ['D:\_RESOURCE\MaidaVale-IRs\230925_1-Rotation-Compensated-MV4_5' ...
        '\MV4\AS2\AS2\TOA'];
MV4_convertedPath = ['D:\_RESOURCE\MaidaVale-IRs\230925_2-N3D-All' ...
        '\MV4\AS2\AS2\TOA'];

% MV4 Conversion
SN3DtoN3D(MV4_rotatedPath, MV4_convertedPath);

% Paths for MV5
MV5_rotatedPath = ['D:\_RESOURCE\MaidaVale-IRs\230925_1-Rotation-Compensated-MV4_5' ...
        '\MV5\AS1\AS1\TOA'];
MV5_convertedPath = ['D:\_RESOURCE\MaidaVale-IRs\230925_2-N3D-All' ...
        '\MV5\AS1\AS1\TOA'];

% MV5 Rotation
SN3DtoN3D(MV5_rotatedPath, MV5_convertedPath);