function generateToolchainFile()
%GENERATETOOLCHAINFILE Generate and save toolchain MAT file
%
% Copyright 2019 The MathWorks, Inc.
%

[toolchain, ~] = biolib.getToolchain();

fileName = fullfile(...
    biolib.getDirectory("SUPPORTPACKAGEROOT"),...
    'registry','biolibwasm_tc.mat');

file = matfile(...
    fileName,...
    'Writable',true);
file.tc = toolchain;

assert(logical(toolchain.validate),'Toolchain failed validation');

rehash;