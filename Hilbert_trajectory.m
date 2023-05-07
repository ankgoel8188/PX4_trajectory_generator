clc 
clear all
close all
randn('state',1)
rand('state',1)

a_max = 1;
v_max   = 2;

z1 = 10;
y1 = 12;
x1 = 15;

H = [0 0 0;
     0 0 z1; 
     0 y1 z1;
     x1 y1 z1;
     x1 -y1 z1;
     2*x1 -y1 z1]

% plot3(H(:,1), H(:,2), H(:,3), 'b-')
%% Generate trajectory
[Traj,time] = Stitch_trajectory(H,a_max, v_max,1,0.01);


plot3(Traj(1,:), Traj(2,:), Traj(3,:))
hold on
for ii = 1:50:size(Traj,2)
    plot3(Traj(1,:), Traj(2,:), Traj(3,:))
    hold on
    plot3(Traj(1,ii), Traj(2,ii), Traj(3,ii),'b*')
    pause(.01)
    hold off
end

%%
figure
plot(time, Traj(1,:))
hold on
plot(time, Traj(2,:))
plot(time, Traj(3,:))