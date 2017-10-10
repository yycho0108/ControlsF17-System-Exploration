function bode_plot(mag, phase, wout, w0)
subplot(2,1,1);
semilogx(wout, mag),grid;
hold on;
plot([w0 w0],[min(mag), max(mag)]);  %w0 
%legend('theoretical','experimental','Location','SouthEast');
title('Bode Plot');
ylabel('Magnitude (dB)');
hold off;

subplot(2,1,2);
semilogx(wout, rad2deg(phase)),grid;
hold on;
plot([w0 w0],rad2deg([min(phase), max(phase)]));  %w0 
%legend('theoretical','experimental','Location','NorthEast');
ylabel('Phase (deg)');  
xlabel('Frequency (rad/s)');
hold off;
end