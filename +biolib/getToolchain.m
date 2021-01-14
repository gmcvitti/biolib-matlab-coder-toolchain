function [tc, results] = getToolchain()
%GETSCRIPTENTOOLCHAIN Specifications for emscripten toolchain.
%
% Copyright 2019 The MathWorks, Inc.
%

toolchain.Platforms  = {computer('arch')};
toolchain.Versions   = {'1.0'};
toolchain.Artifacts  = {'gmake'};
toolchain.FuncHandle = str2func('getToolchainInfoFor');
toolchain.ExtraFuncArgs = {};

[tc, results] = ...
    coder.make.internal.generateToolchainInfoObjects(...
    mfilename, toolchain, nargout...
    );

end

% -------------------------------------------------------------------------
% Generate the ToolchainInfo object for the specified attributes.
% -------------------------------------------------------------------------
function tc = getToolchainInfoFor(...
    platform, version, artifact, varargin...
    )

% Toolchain Information
tc = coder.make.ToolchainInfo(...
    'BuildArtifact','gmake makefile',...
    'SupportedLanguages',{'C/C++'});

toolChainName = 'BioLibWasm';
tc.Name = coder.make.internal.formToolchainName(...
    toolChainName,...
    platform,...
    version,...
    artifact...
    );
tc.Platform = platform;
tc.setBuilderApplication(platform);

% Override Macros


switch true
    case isunix || ismac
        tc.addMacro('EMSCRIPTEN',...
            RTW.transformPaths(biolib.getDirectory("EMSCRIPTEN")));
        tc.addMacro('SUPPORTPACKAGEROOT',...
            RTW.transformPaths(biolib.getDirectory("SUPPORTPACKAGEROOT")));
    case ispc
        emscriptenDir = biolib.getDirectory("EMSCRIPTEN");
        emscriptenDir = replace(emscriptenDir,'\','/');
        tc.addMacro('EMSCRIPTEN',...
            RTW.transformPaths(emscriptenDir));
        supportPackageRootDir = biolib.getDirectory("SUPPORTPACKAGEROOT");
        supportPackageRootDir = replace(supportPackageRootDir,'\','/');
        tc.addMacro('SUPPORTPACKAGEROOT',...
            RTW.transformPaths(supportPackageRootDir));        
end
    
% ------------------------------
% Setup
% ------------------------------
% Initialize Emscripten environment in the local SHELL.
switch true
    case ispc
        tc.ShellSetup{1} = [...
            'call ',...
            fullfile(...
                biolib.getDirectory("EMSCRIPTENSDK"),...
                'emsdk'),...
            ' activate latest'...
        ];
        
    case isunix || ismac
        tc.ShellSetup{1} = [...
            fullfile(biolib.getDirectory("EMSCRIPTENSDK"),'emsdk'),...
            ' activate latest'...
            ' &&',...
            ' bash ',fullfile(biolib.getDirectory("EMSCRIPTENSDK"),'emsdk_env.sh')
            ];
    otherwise
        error('Unknown OS')
end


% Toolchain's attribute
tc.addAttribute('TransformPathsWithSpaces', true);
tc.addAttribute('SupportsUNCPaths',     false);
tc.addAttribute('SupportsDoubleQuotes', true);
if ispc
    tc.addAttribute('RequiresBatchFile', true);
end


% ------------------------------
% C Compiler
% ------------------------------
c_compiler = tc.getBuildTool( 'C Compiler');
c_compiler.setName(           'Emscripten C Compiler');
if strcmp(tc.Platform,'win64')
    c_compiler.setCommand(        'emcc.bat');
else % glnxa64 or maci64
    c_compiler.setCommand(        '$(EMSCRIPTEN)/emcc');
end
c_compiler.setPath(           '');
c_compiler.setDirective(      'CompileFlag',          '-c');
c_compiler.setDirective(      'PreprocessFile',       '-E');
c_compiler.setDirective(      'IncludeSearchPath',    '-I');
c_compiler.setDirective(      'PreprocessorDefine',   '-D');
c_compiler.setDirective(      'OutputFlag',           '-o ');
c_compiler.setDirective(      'Debug',                '-g');
c_compiler.setFileExtension(  'Source',               '.c');
c_compiler.setFileExtension(  'Header',               '.h');
c_compiler.setFileExtension(  'Object',               '.bc');
c_compiler.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<||>OUTPUT<|');

% ------------------------------
% C++ Compiler
% ------------------------------
cpp_compiler = tc.getBuildTool( 'C++ Compiler');
cpp_compiler.setName(           'Emscripten C++ Compiler');
if strcmp(tc.Platform,'win64')
    cpp_compiler.setCommand(        'emcc.bat');
else % glnxa64 or maci64
    cpp_compiler.setCommand(        '$(EMSCRIPTEN)/emcc');
end
cpp_compiler.setPath(           '');
cpp_compiler.setDirective(      'CompileFlag',          '-c');
cpp_compiler.setDirective(      'PreprocessFile',       '-E');
cpp_compiler.setDirective(      'IncludeSearchPath',    '-I');
cpp_compiler.setDirective(      'PreprocessorDefine',   '-D');
cpp_compiler.setDirective(      'OutputFlag',           '-o ');
cpp_compiler.setDirective(      'Debug',                '-g');
cpp_compiler.setFileExtension(  'Source',               '.cpp');
cpp_compiler.setFileExtension(  'Header',               '.h');
cpp_compiler.setFileExtension(  'Object',               '.bc');
cpp_compiler.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<||>OUTPUT<|');


% ------------------------------
% C Linker
% ------------------------------
c_linker = tc.getBuildTool( 'Linker');
c_linker.setName(           'Emscripten C Linker');
if strcmp(tc.Platform,'win64')
    c_linker.setCommand(        'emcc.bat');
else % glnxa64 or maci64
    c_linker.setCommand(        fullfile('$(EMSCRIPTEN)','emcc'));
end
c_linker.setPath(           '');
c_linker.setDirective(      'Library',              '-l');
c_linker.setDirective(      'LibrarySearchPath',    '-L');
c_linker.setDirective(      'OutputFlag',           '-o ');
c_linker.setDirective(      'Debug',                '-g');
c_linker.setDirective(      'FileSeparator',        '/');
c_linker.setFileExtension(  'Executable',           '.js');
c_linker.setFileExtension(  'Shared Library',       '.js');
c_linker.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<||>OUTPUT<|');

% ------------------------------
% C++ Linker
% ------------------------------
cpp_linker = tc.getBuildTool( 'C++ Linker');
cpp_linker.setName(           'Emscripten C++ Linker');
if strcmp(tc.Platform,'win64')
    cpp_linker.setCommand(        'emcc.bat');
else % glnxa64 or maci64
    cpp_linker.setCommand(        fullfile('$(EMSCRIPTEN)','emcc'));
end
cpp_linker.setPath(           '');
cpp_linker.setDirective(      'Library',              '-l');
cpp_linker.setDirective(      'LibrarySearchPath',    '-L');
cpp_linker.setDirective(      'OutputFlag',           '-o ');
cpp_linker.setDirective(      'Debug',                '-g');
cpp_linker.setDirective(      'FileSeparator',        '/');
cpp_linker.setFileExtension(  'Executable',           '.js');
cpp_linker.setFileExtension(  'Shared Library',       '.js');
cpp_linker.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<||>OUTPUT<|');





% ------------------------------
% Archiver
% ------------------------------
archiver = tc.getBuildTool( 'Archiver');
archiver.setName(           'Emscripten C Archiver');
if strcmp(tc.Platform,'win64')
    archiver.setCommand(        'emcc.bat');
else % glnxa64 or maci64
    archiver.setCommand(        fullfile('$(EMSCRIPTEN)','emcc'));
end
archiver.setPath(           '');
archiver.setDirective(      'OutputFlag',           '-o ');
archiver.setDirective(      'FileSeparator',        '/');
archiver.setFileExtension(  'Static Library',       '.bc');
archiver.setCommandPattern( '|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<||>OUTPUT<|');


% --------------------------------------------
% BUILD CONFIGURATIONS
% --------------------------------------------

optimsOffOpts    = {'-O0'};
optimsOnOpts     = {'-O2'};
cCompilerOpts    = {''};
cppCompilerOpts  = {'-Wall -std=c++1z'};
linkerOpts       = {'-s DEMANGLE_SUPPORT=1'};

archiverOpts     = {};

% Get the debug flag per build tool
debugFlag.CCompiler   = '-g -D"_DEBUG"';   
debugFlag.Linker      = '-g';    
debugFlag.Archiver    = '-g';  

% Set the toolchain flags for 'Faster Builds' build configuration
cfg = tc.getBuildConfiguration('Faster Builds');
cfg.setOption( 'C Compiler',            horzcat(cCompilerOpts,   optimsOffOpts));
cfg.setOption( 'C++ Compiler',          horzcat(cppCompilerOpts,   cCompilerOpts,   optimsOffOpts));
cfg.setOption( 'Linker',                linkerOpts);
cfg.setOption( 'C++ Linker',            linkerOpts);
cfg.setOption( 'Archiver',              archiverOpts);

% Set the toolchain flags for 'Faster Runs' build configuration
cfg = tc.getBuildConfiguration('Faster Runs');
cfg.setOption( 'C Compiler',            horzcat(cCompilerOpts,   optimsOnOpts));
cfg.setOption( 'C++ Compiler',          horzcat(cCompilerOpts,   optimsOnOpts));
cfg.setOption( 'Linker',                linkerOpts);
cfg.setOption( 'C++ Linker',            linkerOpts);
cfg.setOption( 'Archiver',              archiverOpts);

% Set the toolchain flags for 'Debug' build configuration
cfg = tc.getBuildConfiguration('Debug');
cfg.setOption( 'C Compiler',            horzcat(cCompilerOpts,   optimsOffOpts, debugFlag.CCompiler));
cfg.setOption( 'C++ Compiler',          horzcat(cCompilerOpts,   optimsOffOpts, debugFlag.CCompiler));
cfg.setOption( 'Linker',                horzcat(linkerOpts,       debugFlag.Linker));
cfg.setOption( 'C++ Linker',            horzcat(linkerOpts,       debugFlag.Linker));
cfg.setOption( 'Archiver',              horzcat(archiverOpts,     debugFlag.Archiver));



% Set the toolchain flags for 'Biolib Default' build configuration
biolib_req_flags = {'-s WASM_MEM_MAX=512MB -s TOTAL_MEMORY=512MB -s -g2 -s EMIT_EMSCRIPTEN_METADATA=1 -s LEGALIZE_JS_FFI=1 -s FORCE_FILESYSTEM=1 -lidbfs.js -lnodefs.js -s EXIT_RUNTIME=1'};
app_additional_flags = {'-s ERROR_ON_UNDEFINED_SYMBOLS=0'};
es6_module_flags = {'-s EXTRA_EXPORTED_RUNTIME_METHODS="[''ccall'', ''cwrap'']" -s EXPORT_ES6=1 -s MODULARIZE=1'};

tc.addBuildConfiguration('Biolib Default');
cfg = tc.getBuildConfiguration('Biolib Default');
cfg.setOption( 'C Compiler',                horzcat(es6_module_flags,biolib_req_flags,app_additional_flags));
cfg.setOption( 'C++ Compiler',              horzcat(es6_module_flags,biolib_req_flags,app_additional_flags));
cfg.setOption( 'Linker',                    horzcat(es6_module_flags,biolib_req_flags,app_additional_flags));
cfg.setOption( 'C++ Linker',                horzcat(es6_module_flags,biolib_req_flags,app_additional_flags));
cfg.setOption( 'Shared Library Linker',     horzcat(es6_module_flags,biolib_req_flags,app_additional_flags));
cfg.setOption( 'C++ Shared Library Linker', horzcat(es6_module_flags,biolib_req_flags,app_additional_flags));
cfg.setOption( 'Archiver',                  horzcat(es6_module_flags,biolib_req_flags,app_additional_flags));




% Set the toolchain flags for 'All' build configuration
tc.setBuildConfigurationOption('all', 'Download',      '');
tc.setBuildConfigurationOption('all', 'Execute',       '');
tc.setBuildConfigurationOption('all', 'Make Tool',     '-j32 -f $(MAKEFILE)');

end