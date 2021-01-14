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