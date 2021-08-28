clc
clear all
close all


  
set(0, 'DefaultFigureColor', 'default'); 
set(0, 'DefaultTextFontSize', 16); 
set(0, 'DefaultTextInterpreter', 'latex');
set(0, 'DefaultLineLineWidth', 2);
set(0, 'DefaultAxesFontSize', 16);

co = [0 0 1;
    1 0 0;
    0 1 0;
    0    0.4470    0.7410
    0.8500    0.3250    0.0980
    0.9290    0.6940    0.1250
    0.4940    0.1840    0.5560
    0.4660    0.6740    0.1880
    0.3010    0.7450    0.9330
    0.6350    0.0780    0.1840];

set(0,'defaultAxesColorOrder',co)

x_1 = 0.7;
x_2 = 1;


h = 0.2;
a = 0.2;
a = h/x_1;

for idea = 1:3
    % idea = 2;
    
    if idea == 1
        f_x1    = 0;
        fp_x1   = 0;
    elseif idea == 2
        a       = h/x_1;
        f_x1    = a*x_1;
        fp_x1   = a;
    elseif idea == 3
        a       = h/x_1^3;
        f_x1    = a*x_1^3;
        fp_x1   = 3*a*x_1^2;
    end
    
    
    A = [1 x_2 x_2^2 x_2^3;
        1 x_1 x_1^2 x_1^3;
        0 1 2*x_2 3*x_2^2;
        0 1 2*x_1 3*x_1^2]
    
    b = [x_2 f_x1 1 fp_x1]';
    
    % b = [x_2 0 1 0]';
    
    
    c = inv(A)*b
    cond(A)
    
    dx  = 0.001;
    
    x1 = 0:dx:x_1;
    x2 = x_1+dx:dx:x_2;
    x3 = x_2+dx:dx:1.25*x_2;
    
    y1 = a*x1.^3;
    y1 = 0*x1.^3;
    
    if idea == 1
        y1 = 0*x1;
    elseif idea == 2
        y1 = a*x1;
    elseif idea == 3
        y1 = a*x1.^3;
    end
    
    y2 = c(1) + c(2)*x2 + c(3)*x2.^2 + c(4)*x2.^3;
    y3 = x3;
    
    x = [x1 x2 x3];
    y = [y1 y2 y3];
    
    x = [-fliplr(x) x];
    y = [-fliplr(y) y];
    
    plot(x,y)
    axis square; axis tight
    grid on; hold on
end
plot(x,x,'k--')
xlabel('$x$')
ylabel('$y$')