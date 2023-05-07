clc 
clear all
close all
randn('state',1)
rand('state',1)

Ts = 0.01;
a_max = 1;

v_max   = 2;
Rc      = [0;0;0];
Rd      = 10*rand(3,1);

Acc_data = Calculate_Acceleration_instants(Rc,Rd,v_max,a_max)
simout = sim('trajectory_generator_sim.slx',Acc_data.Tf+.1);
r = simout.q.Data;
time = simout.q.Time;

for ii = 1:length(time)
    [q(ii), v(ii)] = integrated_state(time(ii), 0, Acc_data);
end
plot(q)
hold on
plot(v)

%%
d = norm(Rc-Rd);

traj = Rc + (Rd-Rc).*q/d;
traj = traj';

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




%%
clc
[t,x] = ode45(@(t,x) double_integrator(t,x,Acc_data),[0 20],[0; 0]);

%%
function xdot = double_integrator(t,x,Acc_data)
keyboard
u = acceleration(t, Acc_data);
xdot = [0 1;0 0]*x + [0;1]*u;
end

function acc = acceleration(t,Acc_data)

a_max = Acc_data(1);
T1 = Acc_data(2);
T2 = Acc_data(3);
Tf = T1+T2;
acc = a_max;
if t>=T1 && t < T2
    acc = 0;
elseif t >= T2 && t < Tf
    acc = -a_max;
elseif t >= Tf 
    acc = 0;
end
end