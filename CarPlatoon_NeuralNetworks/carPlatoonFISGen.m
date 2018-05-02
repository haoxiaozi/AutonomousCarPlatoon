% Autonomous Car Platoon
% Generic function to implement Fuzzy Logic
% Inference System. 
% Options: Fuzzification and
% Defuzzification methods can be changed 
% as explained in the documentation.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ c1 ] = carPlatoonFISGen( fisFName, car_number, Vd, Dd, gauss)

connection = 1;
velocity_range = [0 2*Vd];
Amin = -50;
Amax = 50;
accelaration_range = [Amin Amax];
distance_range = [0 2*Dd];

sharpness_v = Vd/6;
sharpness_d = Dd/6;
sharpness_a = Amax/6;
%   Detailed explanation goes here
c1 = newfis(fisFName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if gauss == 1
    c1.output(1).name = ['A_C_' num2str(car_number)];
    c1.output(1).range = accelaration_range;
    
    c1.output(1).mf(1).name = 'BH';
    c1.output(1).mf(1).type = 'gaussmf';
    c1.output(1).mf(1).params = [sharpness_a Amin];
    
    c1.output(1).mf(2).name = 'BR';
    c1.output(1).mf(2).type = 'gaussmf';
    c1.output(1).mf(2).params = [sharpness_a Amin/2];
    
    c1.output(1).mf(3).name = 'NB';
    c1.output(1).mf(3).type = 'gaussmf';
    c1.output(1).mf(3).params = [sharpness_a 0];
    
    c1.output(1).mf(4).name = 'AC';
    c1.output(1).mf(4).type = 'gaussmf';
    c1.output(1).mf(4).params = [sharpness_a Amax/2];
    
    c1.output(1).mf(5).name = 'AH';
    c1.output(1).mf(5).type = 'gaussmf';
    c1.output(1).mf(5).params = [sharpness_a Amax];
    
else
    
    c1.output(1).name = ['A_C_' num2str(car_number)];
    c1.output(1).range = accelaration_range;
    
    c1.output(1).mf(1).name = 'BH';
    c1.output(1).mf(1).type = 'trimf';
    c1.output(1).mf(1).params = [Amin Amin Amin/2];
    
    c1.output(1).mf(2).name = 'BR';
    c1.output(1).mf(2).type = 'trimf';
    c1.output(1).mf(2).params = [Amin Amin/2 0];
    
    c1.output(1).mf(3).name = 'NB';
    c1.output(1).mf(3).type = 'trimf';
    c1.output(1).mf(3).params = [Amin/2 0 Amax/2];
    
    c1.output(1).mf(4).name = 'AC';
    c1.output(1).mf(4).type = 'trimf';
    c1.output(1).mf(4).params = [0 Amax/2 Amax];
    
    c1.output(1).mf(5).name = 'AH';
    c1.output(1).mf(5).type = 'trimf';
    c1.output(1).mf(5).params = [Amax/2 Amax Amax];
end

if Dd == -1
    % Fuzzy Inferencing System for Master/Pilot Car.
    % For convenience we call it Car1
    
    if gauss == 1
        c1.input(1).name = ['V_C_' num2str(car_number)];
        c1.input(1).range = velocity_range;
        
        c1.input(1).mf(1).name = 'VS';
        c1.input(1).mf(1).type = 'gaussmf';
        c1.input(1).mf(1).params = [sharpness_v 0];
        
        c1.input(1).mf(2).name = 'SL';
        c1.input(1).mf(2).type = 'gaussmf';
        c1.input(1).mf(2).params = [sharpness_v Vd/2];
        
        c1.input(1).mf(3).name = 'JR';
        c1.input(1).mf(3).type = 'gaussmf';
        c1.input(1).mf(3).params = [sharpness_v Vd];
        
        c1.input(1).mf(4).name = 'FS';
        c1.input(1).mf(4).type = 'gaussmf';
        c1.input(1).mf(4).params = [sharpness_v Vd/2+Vd];
        
        c1.input(1).mf(5).name = 'VF';
        c1.input(1).mf(5).type = 'gaussmf';
        c1.input(1).mf(5).params = [sharpness_v 2*Vd];
        
        c1.rule(1).antecedent = [1];
        c1.rule(1).consequent = [5];
        c1.rule(1).weight = 1;
        c1.rule(1).connection = connection;
        
        c1.rule(2).antecedent = [2];
        c1.rule(2).consequent = [4];
        c1.rule(2).weight = 1;
        c1.rule(2).connection = connection;
        
        c1.rule(3).antecedent = [3];
        c1.rule(3).consequent = [3];
        c1.rule(3).weight = 1;
        c1.rule(3).connection = connection;
        
        c1.rule(4).antecedent = [4];
        c1.rule(4).consequent = [2];
        c1.rule(4).weight = 1;
        c1.rule(4).connection = connection;
        
        c1.rule(5).antecedent = [5];
        c1.rule(5).consequent = [1];
        c1.rule(5).weight = 1;
        c1.rule(5).connection = connection;
        
    else
        c1.input(1).name = ['V_C_' num2str(car_number)];
        c1.input(1).range = velocity_range;
        
        c1.input(1).mf(1).name = 'VS';
        c1.input(1).mf(1).type = 'trimf';
        c1.input(1).mf(1).params = [0 0 Vd/2];
        
        c1.input(1).mf(2).name = 'SL';
        c1.input(1).mf(2).type = 'trimf';
        c1.input(1).mf(2).params = [0 Vd/2 Vd];
        
        c1.input(1).mf(3).name = 'JR';
        c1.input(1).mf(3).type = 'trimf';
        c1.input(1).mf(3).params = [Vd/2 Vd Vd+Vd/2];
        
        c1.input(1).mf(4).name = 'FS';
        c1.input(1).mf(4).type = 'trimf';
        c1.input(1).mf(4).params = [Vd Vd+Vd/2 2*Vd];
        
        c1.input(1).mf(5).name = 'VF';
        c1.input(1).mf(5).type = 'trimf';
        c1.input(1).mf(5).params = [Vd+Vd/2 2*Vd 2*Vd];
        
        c1.rule(1).antecedent = [1];
        c1.rule(1).consequent = [5];
        c1.rule(1).weight = 1;
        c1.rule(1).connection = connection;
        
        c1.rule(2).antecedent = [2];
        c1.rule(2).consequent = [4];
        c1.rule(2).weight = 1;
        c1.rule(2).connection = connection;
        
        c1.rule(3).antecedent = [3];
        c1.rule(3).consequent = [3];
        c1.rule(3).weight = 1;
        c1.rule(3).connection = connection;
        
        c1.rule(4).antecedent = [4];
        c1.rule(4).consequent = [2];
        c1.rule(4).weight = 1;
        c1.rule(4).connection = connection;
        
        c1.rule(5).antecedent = [5];
        c1.rule(5).consequent = [1];
        c1.rule(5).weight = 1;
        c1.rule(5).connection = connection;
    end
end

if Dd > -1
    
    if gauss == 1
        %Distance MF
        c1.input(1).name = ['D_C_' num2str(car_number)];
        c1.input(1).range = distance_range;
        
        c1.inpur(1).mf(1).name = 'VC';
        c1.input(1).mf(1).type = 'gaussmf';
        c1.input(1).mf(1).params = [sharpness_d 0];
        
        c1.input(1).mf(2).name = 'CL';
        c1.input(1).mf(2).type = 'gaussmf';
        c1.input(1).mf(2).params = [sharpness_d Dd/2];
        
        c1.input(1).mf(3).name = 'JR';
        c1.input(1).mf(3).type = 'gaussmf';
        c1.input(1).mf(3).params = [sharpness_d Dd];
        
        c1.input(1).mf(4).name = 'FR';
        c1.input(1).mf(4).type = 'gaussmf';
        c1.input(1).mf(4).params = [sharpness_d Dd+Dd/2];
        
        c1.input(1).mf(5).name = 'VF';
        c1.input(1).mf(5).type = 'gaussmf';
        c1.input(1).mf(5).params = [sharpness_d 2*Dd];
        
        % Velocity Membership function
        c1.input(2).name = ['V_C_' num2str(car_number)];
        c1.input(2).range = velocity_range;
        
        c1.input(2).mf(1).name = 'VS';
        c1.input(2).mf(1).type = 'gaussmf';
        c1.input(2).mf(1).params = [sharpness_v 0];
        
        c1.input(2).mf(2).name = 'SL';
        c1.input(2).mf(2).type = 'gaussmf';
        c1.input(2).mf(2).params = [sharpness_v Vd/2];
        
        c1.input(2).mf(3).name = 'JR';
        c1.input(2).mf(3).type = 'gaussmf';
        c1.input(2).mf(3).params = [sharpness_v Vd];
        
        c1.input(2).mf(4).name = 'FS';
        c1.input(2).mf(4).type = 'gaussmf';
        c1.input(2).mf(4).params = [sharpness_v Vd+Vd/2];
        
        c1.input(2).mf(5).name = 'VF';
        c1.input(2).mf(5).type = 'gaussmf';
        c1.input(2).mf(5).params = [sharpness_v 2*Vd];
        
    else
        c1.input(1).name = ['D_C_' num2str(car_number)];
        c1.input(1).range = distance_range;
        
        c1.inpur(1).mf(1).name = 'VC';
        c1.input(1).mf(1).type = 'trimf';
        c1.input(1).mf(1).params = [0 0 Dd/2];
        
        c1.input(1).mf(2).name = 'CL';
        c1.input(1).mf(2).type = 'trimf';
        c1.input(1).mf(2).params = [0 Dd/2 Dd];
        
        c1.input(1).mf(3).name = 'JR';
        c1.input(1).mf(3).type = 'trimf';
        c1.input(1).mf(3).params = [Dd/2 Dd Dd+Dd/2];
        
        c1.input(1).mf(4).name = 'FR';
        c1.input(1).mf(4).type = 'trimf';
        c1.input(1).mf(4).params = [Dd Dd+Dd/2 2*Dd];
        
        c1.input(1).mf(5).name = 'VF';
        c1.input(1).mf(5).type = 'trimf';
        c1.input(1).mf(5).params = [Dd+Dd/2 2*Dd 2*Dd];
        
        % Velocity Membership function
        c1.input(2).name = ['V_C_' num2str(car_number)];
        c1.input(2).range = velocity_range;
        
        c1.input(2).mf(1).name = 'VS';
        c1.input(2).mf(1).type = 'trimf';
        c1.input(2).mf(1).params = [0 0 Vd/2];
        
        c1.input(2).mf(2).name = 'SL';
        c1.input(2).mf(2).type = 'trimf';
        c1.input(2).mf(2).params = [0 Vd/2 Vd];
        
        c1.input(2).mf(3).name = 'JR';
        c1.input(2).mf(3).type = 'trimf';
        c1.input(2).mf(3).params = [Vd/2 Vd Vd+Vd/2];
        
        c1.input(2).mf(4).name = 'FS';
        c1.input(2).mf(4).type = 'trimf';
        c1.input(2).mf(4).params = [Vd Vd+Vd/2 2*Vd];
        
        c1.input(2).mf(5).name = 'VF';
        c1.input(2).mf(5).type = 'trimf';
        c1.input(2).mf(5).params = [Vd+Vd/2 2*Vd 2*Vd];
        
    end
    % Programming Fuzzy Associative Memory for Current Car
    % There are 25 rules
    
    c1.rule(1).antecedent = [1 1];
    c1.rule(1).consequent = [2];
    c1.rule(1).weight = 1;
    c1.rule(1).connection = connection;
    
    c1.rule(2).antecedent = [1 2];
    c1.rule(2).consequent = [2];
    c1.rule(2).weight = 1;
    c1.rule(2).connection = connection;
    
    c1.rule(3).antecedent = [1 3];
    c1.rule(3).consequent = [1];
    c1.rule(3).weight = 1;
    c1.rule(3).connection = connection;
    
    c1.rule(4).antecedent = [1 4];
    c1.rule(4).consequent = [1];
    c1.rule(4).weight = 1;
    c1.rule(4).connection = connection;
    
    c1.rule(5).antecedent = [1 5];
    c1.rule(5).consequent = [1];
    c1.rule(5).weight = 1;
    c1.rule(5).connection = connection;
    
    c1.rule(6).antecedent = [2 1];
    c1.rule(6).consequent = [2];
    c1.rule(6).weight = 1;
    c1.rule(6).connection = connection;
    
    c1.rule(7).antecedent = [2 2];
    c1.rule(7).consequent = [2];
    c1.rule(7).weight = 1;
    c1.rule(7).connection = connection;
    
    c1.rule(8).antecedent = [2 3];
    c1.rule(8).consequent = [2];
    c1.rule(8).weight = 1;
    c1.rule(8).connection = connection;
    
    c1.rule(9).antecedent = [2 4];
    c1.rule(9).consequent = [2];
    c1.rule(9).weight = 1;
    c1.rule(9).connection = connection;
    
    c1.rule(10).antecedent = [2 5];
    c1.rule(10).consequent = [1];
    c1.rule(10).weight = 1;
    c1.rule(10).connection = connection;
    
    c1.rule(11).antecedent = [3 1];
    c1.rule(11).consequent = [5];
    c1.rule(11).weight = 1;
    c1.rule(11).connection = connection;
    
    c1.rule(12).antecedent = [3 2];
    c1.rule(12).consequent = [4];
    c1.rule(12).weight = 1;
    c1.rule(12).connection = connection;
    
    c1.rule(13).antecedent = [3 3];
    c1.rule(13).consequent = [3];
    c1.rule(13).weight = 1;
    c1.rule(13).connection = connection;
    
    c1.rule(14).antecedent = [3 4];
    c1.rule(14).consequent = [2];
    c1.rule(14).weight = 1;
    c1.rule(14).connection = connection;
    
    c1.rule(15).antecedent = [3 5];
    c1.rule(15).consequent = [1];
    c1.rule(15).weight = 1;
    c1.rule(15).connection = connection;
    
    c1.rule(16).antecedent = [4 1];
    c1.rule(16).consequent = [5];
    c1.rule(16).weight = 1;
    c1.rule(16).connection = connection;
    
    c1.rule(17).antecedent = [4 2];
    c1.rule(17).consequent = [4];
    c1.rule(17).weight = 1;
    c1.rule(17).connection = connection;
    
    c1.rule(18).antecedent = [4 3];
    c1.rule(18).consequent = [4];
    c1.rule(18).weight = 1;
    c1.rule(18).connection = connection;
    
    c1.rule(19).antecedent = [4 4];
    c1.rule(19).consequent = [4];
    c1.rule(19).weight = 1;
    c1.rule(19).connection = connection;
    
    c1.rule(20).antecedent = [4 5];
    c1.rule(20).consequent = [4];
    c1.rule(20).weight = 1;
    c1.rule(20).connection = connection;
    
    c1.rule(21).antecedent = [5 1];
    c1.rule(21).consequent = [5];
    c1.rule(21).weight = 1;
    c1.rule(21).connection = connection;
    
    c1.rule(22).antecedent = [5 2];
    c1.rule(22).consequent = [5];
    c1.rule(22).weight = 1;
    c1.rule(22).connection = connection;
    
    c1.rule(23).antecedent = [5 3];
    c1.rule(23).consequent = [5];
    c1.rule(23).weight = 1;
    c1.rule(23).connection = connection;
    
    c1.rule(24).antecedent = [5 4];
    c1.rule(24).consequent = [4];
    c1.rule(24).weight = 1;
    c1.rule(24).connection = connection;
    
    c1.rule(25).antecedent = [5 5];
    c1.rule(25).consequent = [4];
    c1.rule(25).weight = 1;
    c1.rule(25).connection = connection;
end
end