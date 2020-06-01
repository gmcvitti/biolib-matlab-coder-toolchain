function out = main_biolib(argc, arg1, arg2, arg3, arg4)

fprintf('Performing calculation...\n');

x1_double = str2double(arg2);
x2_double = str2double(arg4);

res = x1_double + x2_double;

fprintf('%s + %s = %f \n', arg2, arg4, res);

% return code
out = 0;

end
