function [Traj,Time] = Stitch_trajectory(H,a_max, v_max,wait_time,time_step)

Traj = [];
Time = [];
T = 0;
% wait_time = 0.1;
for ii = 1:size(H,1)-1
    Acc_data = Calculate_Acceleration_instants(H(ii,:),H(ii+1,:),v_max,a_max);
    time = T + (0 : time_step: Acc_data.Tf+wait_time);
    q = [];
    for jj = 1:length(time)
        [q(jj), v(jj)] = integrated_state(time(jj), T, Acc_data);
    end
    T = T+Acc_data.Tf+wait_time;

    Rc = H(ii,:)';
    Rd = H(ii+1,:)';
    d = norm(Rc-Rd);
    traj = Rc + (Rd-Rc).*q/d;
    Traj = [Traj traj];
    Time = [Time time];
    
end


end