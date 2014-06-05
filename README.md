visualizeSignal
====================

Visualization of different input signals in Matlab with filters.

This program was created at the University of Stuttgart (Germany) during our studies. Therefore besides the Authors the University of Stuttgart is also part of the copyright holders.

Authors:
* Michael Mueller (michael.mueller@sharkarea.net)
* Jon Schlipf
* Xudong Gao

Furthermore as supervising tutor:
* Marc Gauger (Marc.Gauger@inue.uni-stuttgart.de)

This program is distributed under the GPLv2 License which can be found at LICENSE.md.

Version
=====================
Current Version of this program is 0.02. So far only single channel Signals are supported.

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

 visualizeSignal(inputFileLocation, [loaderModuleNumber], [ModuleArray])

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
are sharing a common interface. The Module Interface is an double
row array 
[[P; 0][P1...PN; 0...0][OrientationSignal;ValueSignal]]

Where
* P - describes the amount of arguments passed to the module (second row is filled with zero) 
* P1...PN - are the arguments (While N is given in the beginning of the array as P) 
* OrientationSignal - is the time axis (times where value was recorded) or the frequency axis for transformed signals 
* ValueSignal - is the signal value corresponding to the respective
Orientation 

This interface is used by the supervisor to call the modules and can
also be accessed manually for debug purposes. 

Available Loader
=====================
* 1 - loadMatlab - loads Matlab file

For more information about the loader read documentation.tex

Available Modules
=====================

* 1 - delayFilter - Does nothing
* 2 - simplePlot - Plots the signal
* 3 - fourier - applies a (inverse) fast fourier transform
* 4 - fourierBlocks - applies a (inverse) fast fourier transform while the signal is cut into blocks of a specific length
* 5 - cutout - cuts a specific area out of a signal

For more information about the modules read documentation.tex
