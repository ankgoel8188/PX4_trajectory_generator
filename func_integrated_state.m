function [q,v] = func_integrated_state(t, T0, Acc_data)

% t = t-T0;
if t < T0
    q = 0;
    v = 0;
else
    t = t-T0;
    if t<Acc_data.T1
        q = 0.5*Acc_data.a_max*t^2;
        v = Acc_data.a_max*t;
    elseif t < Acc_data.T2
        q = 0.5*Acc_data.a_max*Acc_data.T1^2 + ...
            Acc_data.a_max*Acc_data.T1*(t-Acc_data.T1);
        v = Acc_data.a_max*Acc_data.T1;
    elseif t < Acc_data.Tf
        q = 0.5*Acc_data.a_max*Acc_data.T1^2 + ...
            Acc_data.a_max*Acc_data.T1*(Acc_data.T2-Acc_data.T1) + ...
            Acc_data.a_max*Acc_data.T1*(t-Acc_data.T2) - ...
            0.5*Acc_data.a_max*(t-Acc_data.T2)^2;
        v = Acc_data.a_max*Acc_data.T1 - Acc_data.a_max*(t-Acc_data.T2);
    else
        q = 0.5*Acc_data.a_max*Acc_data.T1^2 + ...
            Acc_data.a_max*Acc_data.T1*(Acc_data.T2-Acc_data.T1) + ...
            Acc_data.a_max*Acc_data.T1*(Acc_data.Tf-Acc_data.T2) - ...
            0.5*Acc_data.a_max*(Acc_data.Tf-Acc_data.T2)^2;
        v = 0;
    end
end