function out = main_biolib(parameters)

% parse input arguments
args = strsplit(parameters, ' ');

x1_double = str2double(args{3});
x2_double = str2double(args{5});
fprintf('Got input arguments %f and %f\n', x1_double, x2_double);

result = x1_double + x2_double;

fprintf('Reading input file: %s\n', args{7});
file_data = readfile(args{7});
numbers_from_file = strsplit(file_data,',');

for pos = 1:length(numbers_from_file)
    num = str2double(numbers_from_file{pos});
    fprintf('Found number in file: %f, adding to sum \n', num);
    result = result + num;
end

fprintf('Performing calculation...\n');
fprintf('%f + %f + [sum of above numbers in file] = %f \n', x1_double, x2_double, result);
fprintf('Writing result to file...\n');

fileID = fopen('result.txt','w');
fprintf(fileID,'%f\n',result);
fclose(fileID);

fprintf('Result written to result.txt, press "Save Results" above to download.\n');

% return code
out = 0;

end


function terms = strsplit(s, delimiter)
% based on https://se.mathworks.com/matlabcentral/fileexchange/21710-string-toolkits
assert(ischar(s) && ndims(s) == 2 && size(s,1) <= 1, ...
    'strsplit:invalidarg', ...
    'The first input argument should be a char string.');
d = delimiter;
assert(ischar(d) && ndims(d) == 2 && size(d,1) == 1 && ~isempty(d), ...
    'strsplit:invalidarg', ...
    'The delimiter should be a non-empty char string.');

d = strtrim(d);
by_space = isempty(d);

s = strtrim(s);
if by_space
    w = isspace(s);            
    if any(w)
        % decide the positions of terms        
        dw = diff(w);
        sp = [1, find(dw == -1) + 1];     % start positions of terms
        ep = [find(dw == 1), length(s)];  % end positions of terms
        
        % extract the terms        
        nt = numel(sp);
        terms = cell(1, nt);
        for i = 1 : nt
            terms{i} = s(sp(i):ep(i));
        end                
    else
        terms = {s};
    end
    
else
    p = strfind(s, delimiter);
    if ~isempty(p)   
        nt = numel(p) + 1;
        terms = cell(1, nt);
        sp = 1;
        dl = length(delimiter);
        for i = 1 : nt
            if i == nt
                terms{i} = strtrim(s(sp:end));
            else
                terms{i} = strtrim(s(sp:p(i)-1));
                sp = p(i) + dl;
            end

        end         
    else
        terms = {s};
    end

end
end


% https://se.mathworks.com/help/coder/ug/read-a-text-file.html
% Read file 'filename' and return a MATLAB string with the contents
% of the file.
function y = readfile(filename) %#codegen

% Put class and size constraints on function input.
assert(isa(filename, 'char'));
assert(size(filename, 1) == 1);
assert(size(filename, 2) <= 1024);

% Call fopen(filename 'r'), but we need to convert the MATLAB
% string into a C type string (which is the same string with the
% NUL (\0) string terminator).
f = fopen(filename, 'r');

% Call fseek(f, 0, SEEK_END) to set file position to the end of
% the file.
fseek(f, 0, 'eof');

% Call ftell(f) which will return the length of the file in bytes
% (as current file position is at the end of the file).
filelen = int32(ftell(f));

% Reset current file position
fseek(f,0,'bof');

% Initialize a buffer
maxBufferSize = int32(2^16);
buffer = zeros(1, maxBufferSize,'uint8');

% Remaining is the number of bytes to read (from the file)
remaining = filelen;

% Index is the current position to read into the buffer
index = int32(1);

while remaining > 0
    % Buffer overflow?
    if remaining + index > size(buffer,2)
        fprintf('Attempt to read file which is bigger than internal buffer.\n');
        fprintf('Current buffer size is %d bytes and file size is %d bytes.\n', maxBufferSize, filelen);
        break
    end
    % Read as much as possible from the file into internal buffer

    [dataRead, nread] = fread(f,remaining, 'char');
    buffer(index:index+nread-1) = dataRead;
    n = int32(nread);
    if n == 0
        % Nothing more to read
        break;
    end
    % Did something went wrong when reading?
    if n < 0
        fprintf('Could not read from file: %d.\n', n);
        break;
    end
    % Update state variables
    remaining = remaining - n;
    index = index + n;
end

% Close file
fclose(f);

y = char(buffer(1:index));
end