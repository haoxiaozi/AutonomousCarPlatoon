%% 
%  Autonomous Car Platoon
%  Fuzzy logic system to control the UI
%  simulation. Backend code for Platoon_UI_With_Time.m (Front End for this project).
%                 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = CarPlatoon ( handles, buttonObject)

%Vd = input('Please enter the desired velocity value')
%V_ini = input('Please enter the initial velocity of the cars')
%Dd = input('Please enter the desired distance between cars.')

%Dini_12 = input('Please enter the desired initial distance between Car 1 and 2 (No more than 2*Desired Distance)')
%Dini_23 = input('Please enter the desired initial distance between Car 2 and 3 (No more than 4*Desired Distance)')

Vd = str2num(get(handles.Vd_tag, 'String'));
V_ini = str2num(get(handles.Vini_tag, 'String'));
Dd = str2num(get(handles.Dd_tag, 'String'));

Dini_12 = str2num(get(handles.D12_tag, 'String'));
Dini_23 = str2num(get(handles.D23_tag, 'String'));

%Array to hold current velocities of the cars.
% Initially all cars start with some uniform initial velocities.
Vn = [V_ini V_ini V_ini];

%Since at start of system, velocities are uniform, Initialize current
%acceleration to be 0
An = [0 0 0];

%Distances maintained between the cars under this vector
Dn = [Dini_12 Dini_23];

% Travelled distances for every car.
% Underlying assumption here is that cars are placed such that:
%    Starting Point | Car3 ---Dini_23-- Car2---Dini_12---Car1-->>
% Car 3 Has travelled zero distance
% Car 2 has travelled Dini_23 distance because it is that distance ahead
% than car 3
% Car 1 has then travelled Dini_12 + Dini_23
% Note that this is travelled distance and is different from Desired
% distances.
Dt = [Dini_12+Dini_23 Dini_23 0];

instances = 10;

cM_x = [0 10 20 30 40 50 60 70 80 90 100];
lB_x = [0 10 20 30 40 50 60 70 80 90 100];
rB_x = [0 10 20 30 40 50 60 70 80 90 100];

cM_y = [ 2 2 2 2 2 2 2 2 2 2 2 ];
lB_y = [ 1 1 1 1 1 1 1 1 1 1 1 ];
rB_y = [ 3 3 3 3 3 3 3 3 3 3 3 ];
i = 1;
Vuni = [V_ini V_ini V_ini];

Vn_m = [V_ini V_ini V_ini];
An_m = [0 0 0];
Dn_m = [Dini_12 Dini_23];
Vd_m = Vd;

axes(handles.velocties_tag);
car1_plot = line(nan, nan, 'color', 'red','LineWidth', 2);
car2_plot = line(nan, nan, 'color', 'blue','LineWidth', 2);
car3_plot = line(nan, nan, 'color', 'green','LineWidth', 2);

axes(handles.distances_tag);
distance_c1_c2 = line(nan, nan, 'color', 'red','LineWidth', 2);
distance_c2_c3 = line(nan, nan, 'color', 'blue','LineWidth', 2);

axes(handles.acceleration_tag);
a1_plot = line(nan, nan, 'color', 'red','LineWidth', 2);
a2_plot = line(nan, nan, 'color', 'blue','LineWidth', 2);
a3_plot = line(nan, nan, 'color', 'green','LineWidth', 2);

axes(handles.animation_tag);
centreMarking = line(nan, nan, 'LineStyle', '--' , 'LineWidth', 5);
leftBound = line(nan, nan, 'LineWidth', 3);
rightBound = line(nan, nan, 'LineWidth', 3);
axis off;

t1_dis = 0;
t2_dis = [0 0];

t1_vel = 0;
t2_vel = [0 0 0];

t_Dis = [0 0];
t_Vel = [0 0 0];

v_stable = [0 0 0; 0 0 0; 0 0 0];
d_stable = [0 0 0; 0 0 0];
Vdp = 0;
Ddp = 0;

t_taken_dis1 = -1;
t_taken_dis2 = -1;
t_taken_vel1 = -1;
t_taken_vel2 = -1;
t_taken_vel3 = -1;

v_stable_decision= [0 0 0];
d_stable_decision= [0 0];
t = 0; 
while 1
    button_state = get(buttonObject,'Value');
    if button_state == get(buttonObject,'Min')
        break;
        
    elseif button_state == get(buttonObject,'Max')
        Vdg = str2double(get(handles.Vd_tag, 'String'));
        Ddg = str2double(get(handles.Dd_tag, 'String'));
        
        if Vdp ~= Vdg
            t1_vel = t;
            t1_dis = t;
            Vdp = Vdg;
            v_stable_decision(1) = 0;
            v_stable_decision(2) = 0;
            v_stable_decision(3) = 0;
            d_stable_decision(1) = 0;
            d_stable_decision(2) = 0;
            set(handles.car1_vs, 'String', ' ');
            set(handles.car2_vs, 'String', ' ');
            set(handles.car3_vs, 'String', ' ');
            set(handles.car2_ds, 'String', ' ');
            set(handles.car3_ds, 'String', ' ');
            
        end
        
        if Ddp ~= Ddg 
            t1_dis = t;
            t1_vel = t;
            Ddp = Ddg;
            d_stable_decision(1) = 0;
            d_stable_decision(2) = 0;
            v_stable_decision(1) = 0;
            v_stable_decision(2) = 0;
            v_stable_decision(3) = 0;
            set(handles.car1_vs, 'String', ' ');
            set(handles.car2_vs, 'String', ' ');
            set(handles.car3_vs, 'String', ' ');
            set(handles.car2_ds, 'String', ' ');
            set(handles.car3_ds, 'String', ' ');
        end
        
        if int16(get(handles.gaussian, 'Value')) == 1
            c1 = carPlatoonFISGen('car1', 1, str2double(get(handles.Vd_tag, 'String')), -1, 1);
            c2 = carPlatoonFISGen('car2', 2, str2double(get(handles.Vd_tag, 'String')), str2double(get(handles.Dd_tag, 'String')), 1);
            c3 = carPlatoonFISGen('car3', 3, str2double(get(handles.Vd_tag, 'String')), str2double(get(handles.Dd_tag, 'String')), 1);
        else
            c1 = carPlatoonFISGen('car1', 1, str2double(get(handles.Vd_tag, 'String')), -1, 2);
            c2 = carPlatoonFISGen('car2', 2, str2double(get(handles.Vd_tag, 'String')), str2double(get(handles.Dd_tag, 'String')), 2);
            c3 = carPlatoonFISGen('car3', 3, str2double(get(handles.Vd_tag, 'String')), str2double(get(handles.Dd_tag, 'String')), 2);
        end
        
        if int16(get(handles.mom, 'Value')) == 1
            c1.defuzzMethod = 'mom';
            c2.defuzzMethod = 'mom';
            c3.defuzzMethod = 'mom';
        end
        
        if int16(get(handles.bisector, 'Value')) == 1
            c1.defuzzMethod = 'bisector';
            c2.defuzzMethod = 'bisector';
            c3.defuzzMethod = 'bisector';
        end
        
        Dn(1) = Dt(1) - Dt(2);
        Dn(2) = Dt(2) - Dt(3);
        
        % Evaluate the value of acceleration based on the current Velocity of
        % Car 1
        % This Acceleration value is direction coming from Fuzzy Inferencing
        % system c1.
        An(1) = evalfis([Vn(1)], c1);
        
        % Evaluate acceleration for Car 2 by feedback of velocity of the Car 2
        % and Distance between Car 2 and 1.
        % This Acceleration value is direction coming from Fuzzy Inferencing
        % system c2.
        An(2) = evalfis([Dn(1) Vn(2)], c2);
        
        % Evaluate acceleration for Car 3 by feedback of velocity of the Car 3
        % and Distance between Car 3 and 3.
        % This Acceleration value is direction coming from Fuzzy Inferencing
        % system c3.
        An(3) = evalfis([Dn(2) Vn(3)], c3);
        
        % Calculating distances travelled by every car with new acceleration.
        Dt(1) = Dt(1) + Vn(1)*0.01 + 0.5*An(1)*0.01^2;
        Dt(2) = Dt(2) + Vn(2)*0.01 + 0.5*An(2)*0.01^2;
        Dt(3) = Dt(3) + Vn(3)*0.01 + 0.5*An(3)*0.01^2;
        
        Vn(1) = Vn(1) + An(1)*0.01;
        Vn(2) = Vn(2) + An(2)*0.01;
        Vn(3) = Vn(3) + An(3)*0.01;
        
        Vn_m = [Vn_m; Vn];
        An_m = [An_m; An];
        Vd_m = [Vd_m; Vd];
        Dn_m = [Dn_m; Dn];
            
        v_stable(1, 1+mod(i, 3)) = int32(Vn(1)*10000);
        v_stable(2, 1+mod(i, 3)) = int32(Vn(2)*10000);
        v_stable(3, 1+mod(i, 3)) = int32(Vn(3)*10000);
        
        d_stable(1, 1+mod(i,3)) = int32(Dn(1)*100);
        d_stable(2, 1+mod(i,3)) = int32(Dn(2)*100);
        
        if v_stable(1,1) == (10000*Vdg) && v_stable(1,2) == (10000*Vdg) && v_stable(1,3) == (10000*Vdg) && v_stable_decision(1) == 0
          %  t_taken_vel1 = [t_taken_vel1 t-t1_vel]
            set(handles.car1_vs, 'String', strcat(num2str(t-t1_vel), ' secs'));
            v_stable_decision(1) = 1;
        end
        
        if v_stable(2,1) == (10000*Vdg) && v_stable(2,2) == (10000*Vdg) && v_stable(2,3) == (10000*Vdg) && v_stable_decision(2) == 0
          %  t_taken_vel2 = [t_taken_vel2 t-t1_vel]
            set(handles.car2_vs, 'String', strcat(num2str(t-t1_vel), ' secs'));
            v_stable_decision(2) = 1;
        end
        
        if v_stable(3,1) == (10000*Vdg) && v_stable(3,2) == (10000*Vdg) && v_stable(3,3) == (10000*Vdg) && v_stable_decision(3) == 0
         %  t_taken_vel3 = [t_taken_vel3 t-t1_vel]
            set(handles.car3_vs, 'String', strcat(num2str(t-t1_vel), ' secs'));
            v_stable_decision(3) = 1;
        end
        
        if d_stable(1,1) == (Ddg*100) && d_stable(1,2) == (Ddg*100) && d_stable(1,3) == (Ddg*100) && d_stable_decision(1) == 0
          %  t_taken_dis1 = [t_taken_dis1 t-t1_dis]
            set(handles.car2_ds, 'String', strcat(num2str(t-t1_dis), ' secs'));
            d_stable_decision(1) = 1;
        end
        
        if d_stable(2,1) == (Ddg*100) && d_stable(2,2) == (Ddg*100) && d_stable(2,3) == (Ddg*100) && d_stable_decision(2) == 0
          %  t_taken_dis2 = [t_taken_dis2 t-t1_dis]
            set(handles.car3_ds, 'String', strcat(num2str(t-t1_dis), ' secs'));
            d_stable_decision(2) = 1;
        end
        
        time_axis_c1 = get(car1_plot, 'xData');
        time_axis_c2 = get(car2_plot, 'xData');
        time_axis_c3 = get(car3_plot, 'xData');
        
        time_axis_a1 = get(a1_plot, 'xData');
        time_axis_a2 = get(a2_plot, 'xData');
        time_axis_a3 = get(a3_plot, 'xData');
        
        time_axis_d12 = get(distance_c1_c2, 'xData');
        time_axis_d23 = get(distance_c2_c3, 'xData');
        
        car1_v = get(car1_plot, 'yData');
        car2_v = get(car2_plot, 'yData');
        car3_v = get(car3_plot, 'yData');
        
        car1_a = get(a1_plot, 'yData');
        car2_a = get(a2_plot, 'yData');
        car3_a = get(a3_plot, 'yData');
        
        distance12 = get(distance_c1_c2, 'yData');
        distance23 = get(distance_c2_c3, 'yData');
        
        time_axis_c1 = [time_axis_c1 t];
        time_axis_c2 = [time_axis_c2 t];
        time_axis_c3 = [time_axis_c3 t];
        
        time_axis_a1 = [time_axis_a1 t];
        time_axis_a2 = [time_axis_a2 t];
        time_axis_a3 = [time_axis_a3 t];
        
        time_axis_d12 = [time_axis_d12 t];
        time_axis_d23 = [time_axis_d23 t];
        
        car1_a = [car1_a An(1)];
        car2_a = [car2_a An(2)];
        car3_a = [car3_a An(3)];
        
        car1_v = [car1_v Vn(1)];
        car2_v = [car2_v Vn(2)];
        car3_v = [car3_v Vn(3)];
        
        distance12 = [distance12 Dn(1)];
        distance23 = [distance23 Dn(2)];
        
        set(car1_plot, 'xData', time_axis_c1, 'yData', car1_v);
        set(car2_plot, 'xData', time_axis_c2, 'yData', car2_v);
        set(car3_plot, 'xData', time_axis_c3, 'yData', car3_v);
        
        set(a1_plot, 'xData', time_axis_a1, 'yData', car1_a);
        set(a2_plot, 'xData', time_axis_a2, 'yData', car2_a);
        set(a3_plot, 'xData', time_axis_a3, 'yData', car3_a);
        
        set(distance_c1_c2, 'xData', time_axis_d12, 'yData', distance12);
        set(distance_c2_c3, 'xData', time_axis_d23, 'yData', distance23);
        
        i = i+1;
        t = t + 0.01;
        
        set(centreMarking, 'xData', cM_x, 'yData', cM_y);
        set(leftBound, 'xData', lB_x, 'yData', lB_y);
        set(rightBound, 'xData', rB_x, 'yData', rB_y);
      
        Dp(1) = mod(Dt(1), 100);
        Dp(2) = mod(Dt(2), 100);
        Dp(3) = mod(Dt(3), 100);
        hold on;
        c1 = plot(Dp, 1.5, 's', 'MarkerFaceColor', 'red' ,'MarkerSize', 20);
        c2 = plot(Dp(2), 1.5, 's', 'MarkerFaceColor', 'blue' ,'MarkerSize', 20);
        c3 = plot(Dp(3), 1.5, 's', 'MarkerFaceColor', 'green' ,'MarkerSize', 20);
        
        pause(0.01)
        delete(c1);
        delete(c2);
        delete(c3);
        hold off;
    end  
end