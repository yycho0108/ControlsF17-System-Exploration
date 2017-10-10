function spring_numeric()
global m k x0 g;
global ctrl;

% Plant Params
k = 88.0;
m = 1.0;
x0 = 0.5;
g = 9.8;

% Controller Params
k_p = 11.79;
k_i = 46.48;
k_d = 0.748;
ctrl = PIDCtrl(k_p, k_i, k_d);

s0 = [0.0 0.0 0.0]'; % x, v, e_i
tspan = [0 1.0];
opts = odeset('Stats','on');
[t,s] = ode45(@acc, tspan, s0, opts);

x = s(:,1);
v = s(:,2);
e_i = s(:,3);
x_eq = x - (m*g/k + x0);

e_p = x_ref(t) - x;
e_d = diff(e_p) ./ diff(t);
e_d = [0; e_d];
y = k_p * e_p + k_i * e_i + k_d * e_d;
a = (m*g - k*(x-y-x0))/m;

figure;
hold on;

n = numel(t);
plot(t, x);
plot(t, y);
plot(t, x_ref(t), '--', 'LineWidth', 2);
plot(t, zeros(n,1), 'LineWidth', 2, 'Color', [0,0,0]);

hold off;
legend('x', 'y', 'x_{ref}');
title('Setpoint Control');
xlabel('Time (s)');
ylabel('Position (m)');
end

function x = x_ref(t)
f = 4.0;
x = 3.0 + 2.0*sin(2*pi*f*t);
%x = 2.0 * ones(numel(t), 1);
end

function d = acc(t,s)
global m k x0 g;
global ctrl
x = s(1);
v = s(2);
%x_eq = x - (m*g/k + x0);
e_p = x_ref(t) - x; % current error
y = ctrl.control(t, e_p);
%y = k_p*e_p + k_i*e_i;
a = (m*g - k*(x-y-x0))/m;

d(1) = v; % x(t+dt) = x(t) + v(t)*dt
d(2) = a; % v(t+dt) = v(t) + a*dt
d(3) = e_p; %e_i(t+dt) = e_i(t) + e_p*dt
d=d';
end