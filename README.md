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
Current Version of this program is 0.01a.
So far only single channel Signals are supported.

Macro Structure
=====================
The Program contains four Parts
* The "Supervisor" is the supervising engine and controls the combination of the other modules. It is the only part of this program which can be directly accessed by the user.
* The "Loader Modules" are modules which convert the input to a usable format.
* The "Filter Modules" are modules (e.g. lowpass filter) which can be consecutively added and walked through by the supervisor.
* The "Output Modules" convert the output at the end and in between of the filter modules either to a visualization (main part of this program) or to a output file.

Supervisor
=====================
Currently the supervisor is accessed by the following schema

 visualizeSignal(loader module number, input file location, [Filter Module Array, Output Module Array])

Therefore the module number is defined below.
The Filter module array should be an single line array with an finite number of modules which should be executed after each other. 
The Output module array needs to macht the dimension of the filter module array because it generates the output after this module was executed. So you can display the output at a certain point in the module chain. 
For Module numbers see the documentation below.
If no Arrays are given a "1" for the filter module and the output mudle will be assumed (so the input is just displayed as a time plot)

Loader Modules
=====================
Currently supported loader modules (and their associated loader module numbers) are:
* 1 - Matlab file loader (.m)

Filter Modules
=====================
Currently supported filter modules (and their associated filter module numbers) are:
* 1 - Delay module (returns the input unchanged)

Output Modules
=====================
* 0 - No Output
* 1 - Display time plot (returns picture with time plot)
* 2 - Display frequency plot (returns picture with frequency plot)

Module Interface
=====================
The Module interface is an single line array like the scheme
 ([#P],[P1...N],[Signal])
Where
* [#P] - describes the amount of arguments passed to the module
* [P1...N] - are the arguments 
* [Signal] - is the signal itself
