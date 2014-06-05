visualizeSignal
====================

Visualization of different input signals in Matlab with filters.

This program was created at the University of Stuttgart (Germany) during our studies. Therefore besides the Authors the University of Stuttgart is also part of the copyright holders.

Authors:
* Michael Mueller (michael.mueller@sharkarea.net)
* Jon Schlipf (schlipf.jon@gmx.net)

Furthermore as supervising tutor:
* Marc Gauger (Marc.Gauger@inue.uni-stuttgart.de)

This program is distributed under the GPLv2 License which can be found at LICENSE.md.

The git repository for this code can furthermore be accessed at https://github.com/ISharkI/matlab-visualization.git

Version
=====================
Current Version of this program is 0.04. So far only one single channel Signal is supported.
A complete documentation can be found at documentation.tex

Macro Structure
=====================
The software consists of three parts 
* The "Supervisor" is the supervising engine and controls the combination
of the modules. It is the only part of this program which can be directly
accessed by the user.
* The "Loader" are modules which convert the input to a usable format. 
* The "Modules" are different modules (e.g. lowpass filter, simple
output) which can be consecutively added and walked through by the
supervisor. They are used to manipulate the signal or display it. 


The Supervisor
=====================
Currently the supervisor is accessed by the following schema

 visualizeSignal(inputFileLocation, [loaderModuleNumber, ModuleArray])

The module array is an array with an finite number of modules the
supervisor will execute consecutiveley in a chain. Therefore the array
has N rows for N Modules. Each row consists out of two parts

* The first element contains the module number (modifier or output,
mapping can be found below)
* The following elements contain the parameters for each module. If
no arguments are needed it can be filled up with anything (e.g. zeroes).
Parameters that are not needed by the respective module will just
be ignored.

By using the same interface for both module types (output modules
and filters modules), the user can display the output at any point
in the module chain.

If no input file type is given Matlab files will be assumed as input.
Furthermore if no module array is given a ``{[}2 0 1{]}'' will be
assumed. This means the input is just displayed as a time plot in
figure 1.

Loader
=====================
"Loader" are modules used to import raw data for processing within
the supervisor. Each Loader is designed to import data from a specific
file type. They access the file through its file name or a directory
path. (Currently there is only one type of loader


Modules
=====================
The following modules are designed to perform different tasks but
are sharing a common interface. The Module Interface is an single
row array 
[[P][P1...PN][SampleRate][ValueSignal]]

Where
* P - describes the amount of arguments passed to the module (second row is filled with zero) 
* P1...PN - are the arguments (While N is given in the beginning of the array as P) 
* SampleRate is the signal sample rate (time domain) or sample frequency (frequency domain)
* ValueSignal - are the signal values 

This interface is used by the supervisor to call the modules and can
also be accessed manually for debug purposes. 

Available Loader
=====================
* 1 - loadMatlab - loads Matlab file

For more information about the loader read documentation.tex

Available Modules
=====================
You can save the latest plot and signal if you add a row containing zeroes.

*  1 - delayFilter - Does nothing
*  2 - simplePlot - Plots the signal
*  3 - fourier - applies a (inverse) fast fourier transform
*  4 - fourierBlocks - applies a (inverse) fast fourier transform while the signal is cut into blocks of a specific length
*  5 - cutout - cuts a specific area out of a signal
*  6 - passFilter - applies a low/high/bandpass
*  7 - powerSpectrum - displayes/saves the power spectrum of the signal
*  8 - audioOutput - outputs the signal using the PC-Speaker (if possible)
*  9 - resampling - resamples the signal
* 10 - digitalMixing - mixes the signal
* 11 - correlation - correlates two signals
* 12 - plotIQ - Plots an IQ presentation of the signal

For more information about the modules read documentation.tex
