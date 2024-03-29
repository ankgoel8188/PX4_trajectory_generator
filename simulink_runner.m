clc 
clear all
close all


Ts = 0.01;
a_max = 1;

v_max   = 2;
Rc      = [0;0;0];
Rd      = 10*rand(3,1);

Acc_data = Calculate_Acceleration_instants(Rc,Rd,v_max,a_max)
simout = sim('trajectory_generator_sim.slx',10);
traj = simout.traj.Data;
time = simout.traj.Time;

%% plot(time, traj')
close all
plot3(traj(:,1), traj(:,2), traj(:,3))
hold on
for ii = 1:100:length(time)
    plot3(traj(:,1), traj(:,2), traj(:,3))
    hold on
    plot3(traj(ii,1), traj(ii,2), traj(ii,3), 'b*')
    pause(.01)
    hold off
end


