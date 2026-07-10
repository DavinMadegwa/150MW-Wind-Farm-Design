% WindFarmSimulation.m
% Simulation of 150 MW Wind Farm Power Output vs Wind Speed

% Constants
rho = 1.225;          % Air density (kg/m^3)
Cp = 0.4;             % Power coefficient (Betz limit ~0.59, realistic ~0.4)
A = 5281;             % Swept area of turbine (m^2) from design
P_rated = 6.6e5;      % Rated power of each turbine (W)
n_turbines = 228;     % Number of turbines

% Wind speeds from cut-in to cut-out (m/s)
V = linspace(3, 30, 100);

% Power calculation (limited to rated power)
P_turbine = 0.5 * rho * A * V.^3 * Cp;
P_turbine = min(P_turbine, P_rated);  % cap at rated power

% Apply cut-out speed at 22 m/s (turbine stops beyond this)
P_turbine(V > 22) = 0;

% Total wind farm output (MW)
P_farm = (P_turbine * n_turbines) / 1e6;

% Display sample outputs
fprintf(' Wind Speed (m/s)    Total Farm Output (MW)\n');
fprintf('---------------------------------------------\n');
for i = 1:length(V)
    fprintf('     %5.2f               %7.2f\n', V(i), P_farm(i));
end

% Plotting
figure;
plot(V, P_farm, 'g', 'LineWidth', 2);
hold on;
yline(150, 'r--', '150 MW                                               ');
xline(22, 'b--', 'Cut-Out Speed (22 m/s)');
xline(3, 'b--', 'Cut-In Speed (3 m/s)');
xlabel('Wind Speed (m/s)');
ylabel('Total Power Output (MW)');
title('150 MW Wind Farm Output vs Wind Speed');
grid on;
legend('Power Output', 'Rated Capacity', 'Cut-Out Speed');
