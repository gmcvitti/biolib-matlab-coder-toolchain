function out = foo(in)
%FOO Summary of this function goes here
%   Detailed explanation goes here

coder.updateBuildInfo('addCompileFlags','-s EXPORTED_FUNCTIONS="[''_foo'']"');
coder.updateBuildInfo('addLinkFlags','-s EXPORTED_FUNCTIONS="[''_foo'']"');

out = sqrt(in);

end

