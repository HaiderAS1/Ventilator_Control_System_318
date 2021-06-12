# Ventilator_Control_System_318

This is Control System 318 ongoing project of Building variable gain Controller for Ventilator . 
Read the associated PDF to know more .

Paper Link - https://ieeexplore.ieee.org/document/8488683

Linear Controller(Only integral control as suggested in paper) is exploited in linear_controller_code.m (Matlab Code) and linear_controller.slx (Simulink) .

Linear Controller (PID) that meets the specifications are exploited in linear_controller_PID.m(Matlab Code) and linear_controller_PID.slx(Simulink) and linear_controller_PID_Feedforward.slx(Simulink) . The two simulink files differ in the addition of Unity feedforward path or not . This will give a vivid idea of why Unity Feedforward path is necessary and how it helps .

Nonlinear controller is exploitted in non_linear_gain_control.slx (Simulink) .
Nonlinear Control's Paper Graph (Fig 14) is Recreated in Non_Linear_Control_Paper_Graph_Recreation.slx(Simulink)

** Before running the simulink files please run the matlab file pset_build.m , It is mandatory  **

Project redistributable only under Apache License . 

©SM Haider Ali Shuvo

EEE , BUET
