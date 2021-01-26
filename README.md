[BioLib](https://biolib.com) is a library of bioinformatics applications written in a wide range of programming languages. Conveniently, BioLib applications can also be developed in MATLAB by using the **BioLib-MATLAB-Coder-Toolchain**. The toolchain achieves this by compiling MATLAB code to a BioLib-compatible WebAssembly executable.

## Getting Started
**Download this project**

You can either download this project from the current page or by cloning it from GitHub. To setup the toolchain, open the project in MATLAB.

**Setup Tooling**

Add the `biolib-matlab-coder-toolchain` and `biolib-matlab-coder-toolchain/registry` folders to the MATLAB path. You can do this by right clicking on the folder and selecting **Add to Path**. This is required for the toolchain to be registered. Make sure that the root directory is on a path without spaces or a mapped network drive.

Next, run the following code to download the emscripten tools into the Add-On directory.

```matlab
filepath = biolib.getDirectory("SUPPORTPACKAGEROOT");
cd(filepath)
!git clone https://github.com/emscripten-core/emsdk.git --branch 1.39.8
```

After this, install the emscripten tools in the selected directory.  Importantly, the version of emscripten needs to be `1.39.8`.

```matlab
switch true
    case ispc
        !emsdk\emsdk.bat install 1.39.8-upstream
    case isunix || ismac
        !./emsdk/emsdk install 1.39.8-upstream 
end
```

Then generate the BioLib toolchain and register with MATLAB Coder™.  NB: Remember to install the MATLAB Coder™, it can be found [here](https://se.mathworks.com/help/coder/getting-started-with-matlab-coder.html). Your MATLAB code needs to be supported by MATLAB Coder in order to be compiled using the toolchain. 

```matlab
biolib.generateToolchainFile();
RTW.TargetRegistry.getInstance('reset');
```

Depending on your machine's default shell, the generation of the toolchain might fail. If so, in [this file](https://github.com/biolibtech/biolib-matlab-coder-toolchain/blob/master/%2Bbiolib/getToolchain.m) line 81, try exchanging `bash` by `source` or vice-versa, to solve the problem. 


**Build Sample Function**

Navigate to the example directory:

```matlab
cd(fullfile(biolib.getDirectory("SUPPORTPACKAGEROOT"),"example"));
```

Create a single entry-point function called `main(parameters)`. In the example below, this function takes in a DNA string and it calculates the proportion of Adenine, Thymine, Cytosine and Guanine.

```matlab
% Example function
function out = main(parameters)
%parameters = '-i atcgagctatgctagATGAT'
% Parse input arguments
args = split_arguments_by_space(parameters);
dna = upper(args{3});

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

In the above example, the parameters are a string formed by two words `-i <dna_string>`. Depending on the arguments that will be entered in the tool, the developer may want take into account that each parameter needs an argument name to pass it from BioLib. We split the parameter string in the example, and assign each position to a variable.

To show the output, one can (1) print them as stdout or (2) write them in a file. To return an exit code, use `out = 0` to inform the system that the tool has successfully run. 

Finally, run the below code to produce a WebAssembly file that runs on BioLib.

```matlab
cfg = coder.config("dll");
cfg.GenerateExampleMain = "DoNotGenerate";

cfg.TargetLang = "C";
cfg.Toolchain = 'BiolibWasm';

cfg.BuildConfiguration = 'Biolib Default';
cfg.CustomSource = 'main.c';

codegen -config cfg main_biolib -args {'a',[1 inf]} main.c
```
To view a full example of the required commands, see the `setup.mlx` file.

The last step is to upload the WebAssembly file, `biolib_main.wasm`, as an emscripten module to a BioLib application. You can see an example of this [here](https://biolib.com/laurabiolib/BioLib-MATLAB-ToolChain/). You can learn how to create your first BioLib application [here](https://biolib.com/docs/building-applications/creating-your-first-application) and share it with fellow bioinformaticians.
