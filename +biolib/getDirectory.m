function value = getDirectory(macro)
%GETEMSCRIPTENCOMPILERPATH Summary of this function goes here
%   Detailed explanation goes here

[filepath,~,~] = fileparts(mfilename('fullpath'));

switch upper(macro)
    case "EMSCRIPTEN"
        value = fullfile(filepath,'..','emsdk','upstream','emscripten');
    case "EMSCRIPTENSDK"
        value = fullfile(filepath,'..','emsdk');
    case "SUPPORTPACKAGEROOT"
        value = fullfile(filepath,'..');
    otherwise
        error("Unknown MACRO.");    
end


end

