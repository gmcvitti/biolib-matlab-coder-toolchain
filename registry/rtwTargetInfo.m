function rtwTargetInfo(tr)
%RTWTARGETINFO Registration file for custom toolchains.
%
% Copyright 2019 The MathWorks, Inc.
%

tr.registerTargetInfo(...
    @loc_addToolchain);

end

function config = loc_addToolchain

config      =       coder.make.ToolchainInfoRegistry;
config.Name =       'BiolibWasm';
config.FileName =   fullfile(...
    biolib.getDirectory("SUPPORTPACKAGEROOT"),...
    'registry','biolibwasm_tc.mat');
end

