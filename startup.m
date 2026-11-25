%%***************************************************************************************
%% file         startup.m
%% brief        Runs when MATLAB starts in this folder: puts the GOcontroll Simulink
%%              blockset, which lives in the subfolder GOcontroll-Simulink, on the MATLAB
%%              path and loads its libraries.
%%
%%              Start MATLAB in this folder (or make it the current folder and type
%%              "startup") before you open or create a model.
%%***************************************************************************************

try
    librarySetup;
catch goStartupError
    warning('GOcontroll:startupFailed', '%s', goStartupError.message);
end
clear goStartupError
