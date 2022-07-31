clc 
clear all
close all


Ts = 0.01;
a_max = 1;

v_max   = 2;
Rc      = 0;
Rd      = 8;

Acc_data = Calculate_Acceleration_instants(Rc,Rd,v_max,a_max)
sim('trajectory_generator_sim.slx',10)

