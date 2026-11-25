%%***************************************************************************************
%% file         librarySetup.m
%% brief        Forwards to the librarySetup of the GOcontroll Simulink blockset in the
%%              subfolder GOcontroll-Simulink. A model made from a GOcontroll template
%%              calls librarySetup when it is opened; this file makes that work for a
%%              model that is kept in this folder.
%%
%%              Do not edit: the blockset is updated through its git submodule.
%%***************************************************************************************

goBlocksetSetup = fullfile(fileparts(mfilename('fullpath')), 'GOcontroll-Simulink', 'librarySetup.m');
goCodeBase      = fullfile(fileparts(mfilename('fullpath')), 'GOcontroll-Simulink', 'blockset', ...
                           'GOcontroll-CodeBase', 'code');
if ~isfile(goBlocksetSetup) || ~isfolder(goCodeBase)
    clear goBlocksetSetup goCodeBase
    error('GOcontroll:blocksetMissing', ...
          ['The GOcontroll Simulink blockset is not in the folder GOcontroll-Simulink yet, or its ' ...
           'code base is missing. Fetch it with this command in the project folder:\n\n' ...
           '    git submodule update --init --recursive\n']);
end
run(goBlocksetSetup);
clear goBlocksetSetup goCodeBase
