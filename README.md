# Quantum Dot Blinking Analysis Toolbox

This repository contains a collection of MATLAB scripts for simulating and analyzing the blinking behavior of quantum dots (QDs). 

Quantum dots are fascinating nanomaterials with unique optical properties. One of their intriguing characteristics is their tendency to randomly switch between bright "on" states and dimmer "off" states, a phenomenon known as blinking. This blinking behavior holds tremendous potential for applications in bioimaging and single-molecule spectroscopy.

This toolbox offers various functionalities to explore and analyze QD blinking:

* **Simulating Blinking Time Traces:**  The `SimulatedSignal.m` script lets you generate a simulated discrete random signal mimicking a real QD blinking time trace.

* **Visualizing Blinking Dynamics:**  The `animatedSignalPlot.m` script enables you to visualize a blinking time trace loaded from an XLSX file. 

* **Creating Blinking Animations:**  For a more dynamic visualization, the `guiAnimation.m` script allows you to create a video simulation of QD blinking by providing two signal time traces of the same length. You can utilize the included "for simulated video.xlsx" file for this purpose.

* **Batch Processing of XLSX Files:**  The `multipleFilesAccess.m` script helps you efficiently analyze multiple blinking time traces stored in separate XLSX files within a directory. You can use this script to plot and compare the blinking patterns of several QDs.

* **Simulating Drifting Blinking:**  The `DriftingGUI.m` script generates a GUI simulation of two blinking QD time traces extracted from the "for simulated video.xlsx" file. This simulation incorporates a random drifting effect to facilitate preliminary testing of drift correction algorithms.

* **Drift Correction Implementation:**  The core functionality of the toolbox lies in the `DriftCorrection4.m` script. This script takes in real QD video traces and attempts to correct for any drift that might have occurred during the measurement.  Before running the script, you'll need to specify the boundary coordinates of the region of interest (ROI) in the video.

* **Intensity Analysis:**  The `IntensityVsCount.m` script provides insights into the relationship between signal intensity and the number of occurrences (count) within the blinking time trace data stored in the "for simulated video.xlsx" file.

* **Time Step Analysis:**  The `TimeStepCalc.m` script delves into the time step size associated with different signal intensities. It visualizes how time step size relates to intensity, providing separate plots for high, low, and medium intensity signals.

This toolbox equips you with valuable tools to simulate, visualize, and analyze QD blinking behavior, ultimately aiding in a deeper understanding of these fascinating nanomaterials.
