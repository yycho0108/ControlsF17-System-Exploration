function spring()
global H kp ki kd;

k=88.0;
m=1.0;
s = tf('s');
H = (k/m)/(s^2+k/m);
%pidTuner(H);

%H = 1.0/(m*s^2+k);
%kp=100.0;
%ki=20.0;
%kd=10.0;
%figure;
% 
% uicontrol('units','normalized', ...
%     'position',[0.25,0.1,0.5,0.03], ...
%     'style','slider','callback',@kpcb ...
% );
% uicontrol('units','normalized', ...
%     'position',[0.25,0.07,0.5,0.03], ...
%     'style','slider','callback',@kicb ...
% );
% uicontrol('units','normalized', ...
%     'position',[0.25,0.04,0.5,0.03], ...
%     'style','slider','callback',@kdcb ...
% );

kp = 11.79;
ki = 46.48;
kd = 0.748;

fprintf('k_p:%.2g, k_i:%.2g, k_d:%.2g\n', kp, ki, kd);
%C = pid(kp,ki,kd);
C = (kp + ki/s + kd*s);
sys_ol = C*H;
sys_cl = feedback(sys_ol,1);
%sys_cl

f_val = evalfr(sys_cl, 0.0);
fprintf('Final Value : %.2f', f_val);
figure;
stepplot(sys_cl, 1.0);
%subplot(2,1,1);
%stepplot(sys_cl, 2.5);
% subplot(2,1,1);
% nyquist(sys_ol);
% subplot(2,1,2);
% nyquist(sys_cl);

figure;

h = pzplot(sys_ol,sys_cl);
a = findobj(gca,'type','line');
for i = 1:length(a)
    set(a(i),'markersize',12) %change marker size
    set(a(i), 'linewidth',2)  %change linewidth
end
legend('open loop','closed loop');
% subplot(3,1,1);
% pzplot(H);
% xlabel('');
% ylabel('');
% 
% subplot(3,1,2);
% h = pzplot(sys_ol);
% p = getoptions(h);
% p.InputLabels
% %p.TickLabel
% %p.TickLabel = '';
% %setoptions(h,p);
% title('');
% xlabel('');
% 
% subplot(3,1,3);
% pzplot(sys_cl);
% ylabel('');
% title('');
sys_ol
sys_cl

figure;
bode(sys_ol);
nyquist(sys_ol);
hold on;
rectangle('Position', [-1 -1 2 2], 'Curvature', [1 1]);
xlim([-5 5]);
ylim([-5 5]);
hold off;
%w0 = sqrt(k/m);
% [mag,phase,wout] = bode(sys_cl);
% 
% mag = squeeze(mag);
% phase = squeeze(phase);
% wout = squeeze(wout);
% bode_plot(mag,phase,wout,w0);
end

function step_pid(H,kp,ki,kd)
C = pid(kp,ki,kd);
sys_ol = C*H;
sys_cl = feedback(sys_ol,1);
step(sys_cl, 10);
f_val = evalfr(sys_cl, 0.0);
ts = sprintf('final value : %.2f' ,f_val);
title(ts);
grid
end

function kpcb(h, ~)
global H kp ki kd;
kp = 10000*get(h,'value');
step_pid(H, kp, ki, kd);
end

function kicb(h, ~)
global H kp ki kd;
ki = 10000*get(h,'value');
step_pid(H, kp, ki, kd);
end

function kdcb(h, ~)
global H kp ki kd;
kd = 10000*get(h,'value');
step_pid(H, kp, ki, kd);
end