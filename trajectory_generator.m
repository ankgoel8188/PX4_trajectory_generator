clc 
clear all
close all


Ts = 0.01;
a_max = 1;

v_max = 2;

x_r = 8;


sigma = sign(x_r);
T1 = v_max/a_max
x_T1 = 0.5*a_max*T1^2;

if abs(x_r) < 2*abs(x_T1)
    
    v_max_bar   = sqrt(abs(x_r) * a_max);
    T1_bar      = sqrt(abs(x_r) / a_max);
    v_max       = v_max_bar;
    t1 = 0:Ts:T1_bar;
    a1 = a_max+t1*0;
    v1 = a_max*t1;
    x1 = 1/2*a_max*t1.^2;
    
    t2 = T1_bar+Ts:Ts:2*T1_bar;
    a2 = -a_max+t2*0;
    v2 = a_max*T1_bar - a_max*(t2-T1_bar);
    x2 = 1/2*a_max*T1_bar^2 + v_max_bar*(t2-T1_bar) - 1/2*a_max*(t2-T1_bar).^2;
    
    t = [t1 t2];
    a = sigma*[a1 a2];
    v = sigma*[v1 v2];
    x = sigma*[x1 x2];
    
else
    
    T1 = v_max / a_max;
    T2 = T1 + abs(x_r)/v_max - v_max/a_max;
    T3 = T2 + T1;
    t1 = 0:Ts:T1;
    a1 = a_max+t1*0;
    v1 = a_max*t1;
    x1 = 1/2*a_max*t1.^2;
    
    t2 = T1+Ts:Ts:T2;
    a2 = t2*0;
    v2 = a_max*T1+t2*0;
    x2 = 1/2*a_max*T1^2 + v_max*(t2-T1) ;
    
    t3 = T2+Ts:Ts:T3;
    a3 = -a_max+t3*0;
    v3 = a_max*T1 - a_max*(t3-T2);
    x3 = 1/2*a_max*T1^2 + v_max*(T2-T1) + v_max*(t3-T2) - 1/2*a_max*(t3-T2).^2;
    
    t = [t1 t2 t3];
    a = sigma*[a1 a2 a3];
    v = sigma*[v1 v2 v3];
    x = sigma*[x1 x2 x3];
    
end

%%
set(0, 'DefaultFigureColor', 'default'); 
set(0, 'DefaultTextFontSize', 16); 
set(0, 'DefaultTextInterpreter', 'latex');
set(0, 'DefaultLineLineWidth', 2);
set(0, 'DefaultAxesFontSize', 16);

subplot(3,1,1); stairs(t,a, 'linewidth',2); ylabel('$a(t)$')
subplot(3,1,2); stairs(t,v, 'linewidth',2); ylabel('$v(t)$')
subplot(3,1,3); stairs(t,x, 'linewidth',2); ylabel('$x(t)$'); xlabel('$t$')

for pp = 1:3
    subplot(3,1,pp)
    axis tight; grid on
end
subplot(3,1,2); hold on; text(t(end)/3,sigma*v_max/2,['$v_{\rm max} = $' num2str(v_max)])
subplot(3,1,3); hold on; stairs(t,x*0+x_r, 'k--','linewidth',2); ylim([0 1.1*x_r])



