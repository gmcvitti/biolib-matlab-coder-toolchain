BioLib is a collection of bioinformatics apps that is built with privacy and data security in mind; your input data stays on your machine to ensure the confidentiality of your data. Conveniently, BioLib tools can also be developed in MATLAB by using **BioLib-MATLAB-Coder-JavaScript-Toolchain**. This toolchain contains MATLAB files and one example of a simple tool.

## How to set it up:

**Setup Tooling**

Add the `biolib-matlab-coder-toolchain` and `biolib-matlab-coder-toolchain/registry` folders to the MATLAB path. You can do this by right clicking on the folder and selecting **Add to Path**. This is required for the toolchain to be registered. Make sure that the root directory is on a path without spaces or a mapped network drive.

The following code downloads the emscripten tools into this Add-On directory.

```matlab
filepath = biolib.getDirectory("SUPPORTPACKAGEROOT");
cd(filepath)
!git clone https://github.com/emscripten-core/emsdk.git --branch 1.39.8
```

After this, install the emscripten tools in the selected directory.  Important, the version of emscripten needs to be < 1.40.0. 

```matlab
switch true
    case ispc
        !emsdk\emsdk.bat install 1.39.8-upstream
    case isunix || ismac
        !./emsdk/emsdk install 1.39.8-upstream 
end
```

Generate the BioLib toolchain and register with MATLAB Coder™.  NB: Remember to install the MATLAB Coder™, it can be found [here](https://se.mathworks.com/help/coder/getting-started-with-matlab-coder.html). Your MATLAB code needs to be supported by MATLAB Coder in order to be compiled correctly to WASM. 

```matlab
biolib.generateToolchainFile();
RTW.TargetRegistry.getInstance('reset');
```

**Build Sample Function**

Navigate to the example directory, you can optionally create the function in another directory.

```matlab
cd(fullfile(biolib.getDirectory("SUPPORTPACKAGEROOT"),"example"));
```

Create a single entry-point function. This simple example takes a DNA string and it counts the proportion of Adenine, Thymine, Cytosine and Guanine. 

 In this example, the parameters are a string formed by two words `-i <dna string>`  , depending on the arguments that will be entered in the tool the developer may take into account that each parameter needs a an argument to call it in BioLib. Afterwards, split the parameters and assign each position to a variable.

To show the output, one can (1) print them as stdout or (2) write them in a file. It is needed to use the line `out = 0` as it informs that the tool has successfully run. 

```matlab
% Example function
function out = main(parameters)
	
	% Parse input arguments
	args = split_arguments_by_space(parameters);
	dna = upper(args{2});
	
	adenine = int8(0);
	thymine = int8(0);
	cytosine = int8(0);
	guanine = int8(0);

	for i = 1:length(dna)
    if dna(i) == 'A'
        adenine = adenine + 1
    elseif dna(i) == 'T'
        thymine = thymine + 1
    elseif dna(i) == 'C'
        cytosine = cytosine + 1
    elseif dna(i) == 'G'
        guanine = guanine + 1
    end
	end

	fprintf('A:%d; T:%d; C:%d; G:%d', adenine, thymine, cytosine, guanine)

	% Return code
	out = 0;
end

% Needed function that reads the input arguments
function args = split_arguments_by_space(argument_string)         
    if any(isspace(argument_string))      
        space_diff = diff(isspace(argument_string));
        start_positions = [1, find(space_diff == -1) + 1];
        end_positions = [find(space_diff == 1), length(argument_string)];
        number_of_args = numel(start_positions);
        args = cell(1, number_of_args);
        for i = 1 : number_of_args
            args{i} = argument_string(start_positions(i):end_positions(i));
        end                
    else
        args = {argument_string};
    end
end
```

The calls to `coder.updateBuildInfo` allow the function to be exported and accessed from the Module when loaded in the JavaScript runtime environment.

```matlab
cfg = coder.config("dll");
cfg.GenerateExampleMain = "DoNotGenerate";

cfg.TargetLang = "C";
cfg.Toolchain = 'BiolibWasm';

cfg.BuildConfiguration = 'Biolib Default';
cfg.CustomSource = 'main.c';
```

Finally, run these two lines. t refers to the input type that the function accepts and it needs to be defined according to it. 

```matlab
codegen -config cfg main_biolib -args {'a',[1 inf]} main.c
```

Find a setup file here, that running it with the correct function name (included in the last line), it will produce a WASM file that runs in BioLib.

[setup_biolib.mlx](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/87465617-f1c3-499d-a389-8faa3bc0e234/setup_biolib.mlx)

The last step is to upload the WASM file as an emscripten module in a BioLib application, just like in the previous example now also on [BioLib](https://biolib.com/laurabiolib/BioLib-MATLAB-ToolChain/). One can learn how to create your first BioLib application [here](https://biolib.com/docs/building-applications/creating-your-first-application) and share it with fellow developers and bioinformaticians.