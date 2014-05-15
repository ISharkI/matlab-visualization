visualizeSignal
====================

Visualization of different input signals in Matlab with filters.

This program was created at the University of Stuttgart (Germany) during our studies. Therefore besides the Authors the University of Stuttgart is also part of the copyright holders.

Authors:
* Michael Mueller (michael.mueller@sharkarea.net)
* Jón Schlipf
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

 visualizeSignal(inputFileLocation, [loaderModuleNumber], [ModuleArray])

Therefore the module numberis are defined below.
The module array is array with an finite number of modules which should be executed consecutively. Therefore the array has N rows for N filters or Outputs.
Each row consist out of two parts
* first element contains the module number (filter or output)
* the following elements contain the parameters for each module

To match dimensions of the array unneded positions need to be filled up (e.g. with zeroes).
This way we can display the output at a certain point in the module chain. 
If no input file type is given a "1" for Matlab files will be assumed.
If no Array is given a "[1 1]" will be assumed (so the input is just displayed as a time plot).

Loader Modules
=====================
Currently supported loader modules (and their associated loader module numbers) are:
* 1 - Matlab file loader (.mat)

Module Numbers
=====================
Currently supported filter modules (and their associated filter module numbers) are:


* 0 - No Output [No Parameters]
* 1 - Delay module (returns the input unchanged) [No Parameters]
* 2 - Display time/frequency plot [1. Parameter 0=timeplot, 1=frequencyplot]

Module Interface
=====================
The Module interface is an double line array like the scheme
 ([#P],[P1...N],[TimeSignal];0,0...0,[ValueSignal])
Where
* [#P] - describes the amount of arguments passed to the module
* [P1...N] - are the arguments 
* [TimeSignal] - is the time axis (times where value was recorded)
* [ValueSignal] - is the signal with its values
