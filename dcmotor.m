J = 0.01;
b = 0.1;
K = 0.01;
R = 1;
L = 0.5;
s = tf('s');
P_motor = K/((J*s+b)*(L*s+R)+K^2);
Kp = 100;
Ki = 200;
Kd = 10;
C = pid(Kp,Ki,Kd);
sys_ol = C*P_motor;
sys_cl = feedback(sys_ol,1);
%% Step
figure;
step(sys_cl, 0:0.01:4)
grid
title('PID Step Response')
%% Nyquist
figure;
subplot('121');
nyquist(sys_ol);
subplot('122');
nyquist(sys_cl);
%% Pole-Zero
figure;
pzplot(sys_ol,sys_cl);
%pzplot(sys_cl);