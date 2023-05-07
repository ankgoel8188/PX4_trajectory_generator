function [Acc_data] = func_Calculate_Acceleration_instants(Rc,Rd,v_max,a_max)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

d   = norm(Rc-Rd);
T1  = v_max/a_max;

x_T1 = 1/2*a_max*T1^2;

if d < 2*x_T1
    T1 = sqrt(d/a_max);
    T2 = T1;
    Tf = T1+T2;
else
    T2 = d/v_max;
    Tf = T1+T2;
end

Acc_data.T1 = T1;
Acc_data.T2 = T2;
Acc_data.Tf = Tf;
Acc_data.a_max = a_max;

end