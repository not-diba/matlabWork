% Machines Assigment
% Madiba Elvis - F17/102284/2017
% Capability Curve

%Variables
rated_Power = 35; %kVA
p_f = .85; %power factor
pf_angle = -acosd(p_f);
Pmax_in = 37.5; %kW
Copper_losses = 2.1; %kW
Mechanical_losses = 3.2; %kW
Xs = 1; %Ohm
Rs = 0; %Ohm
V = 415; %V
f = 50; %Hz

%Calculations

Vt = V/(3^(1/2)); %V
fprintf('Vt = %d V\n',Vt);

Ia_max = (rated_Power)*1000/(3*Vt); %A
fprintf('Ia_max = %d A\n',Ia_max);


%for Capability curve 

Q = -3*(Vt^2)/(Xs * 1000); %KVA
fprintf('Q = %d kVA\n',Q);


Ea_max = abs(Vt + (j*Xs*Ia_max.*exp(j*pf_angle * pi/180)));
fprintf('Ea_max = %d V\n',Ea_max);

De = (3*Ea_max*Vt)/(Xs * 1000); %KVA
fprintf('De = %d kVA\n',De);

Pmax_out = Pmax_in - Mechanical_losses - Copper_losses;
fprintf('Pmax_out = %d kW\n',Pmax_out);

%field current limit
t = linspace(2/3*pi,1/3*pi);

x1 = De*cos(t) + 0;
y1 = De*sin(t) + Q;

%stator current limit
t = linspace(0,2*pi);

x2 = rated_Power*cos(t) + 0;
y2 = rated_Power*sin(t) + 0;

%prime mover limit
x3 = [Pmax_out Pmax_out];
y3 = [-200 75];

%plotting
y = [-200:25:75];
plot(x1,y1,x2,y2,x3,y3),xlabel('P'),ylabel('Q'),title('Capability Curve'),axis([-75 75 -50 50]),grid on , axis tight, legend('field current limit', 'stator current limit','prime mover limit');


%Axis at origin
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin');
