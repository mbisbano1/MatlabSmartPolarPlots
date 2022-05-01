clear all
close all
clc

%% Winter Break Work: Michael Bisbano
%   Polar Plot Generation Tools:

%% First Stage: Declare Vars 
% Global Variable Declarations (Default):
    %x_axis_range = -1:0.01:1;                                               % predefined to start
    %y_axis_range = -1:0.01:1;                                               % predefined to start
    %theta_deg = 0:0.5:359.5;                                                % predefined to start
    %theta_rad = deg2rad(theta_deg);                                         % predefined to start
    %ThetaMaxDirectivity_deg = 90;                                           % predefined to start
    %ThetaMaxDirectivity_rad = deg2rad(ThetaMaxDirectivity_deg);             % predefined to start
    
    %ScaleType = 'Linear';                                                      % User Defineable
    ScaleType = 'dB';                                                           % User Defineable
    dBscaleFactor = 10;                                                         % User Defineable
    dB_minimumValue = -40;
    dB_maximumValue = 0;
    PlotRadius.YMin = 0.8;                                                      % User Defineable
    PlotRadius.ThetaStep = 30;                                                  % User Defineable
    PlotRadius.MaxTheta = 180;                                                  % User Defineable
    PlotRadius.Labels = [1, 0.8, 0.6, 0.4, 0.2];                                % User Defineable
    PlotRadius.Labels_dB = [0, -10, -20, -30, -40];                                % User Defineable
    if ScaleType == 'dB'
        PlotRadius.Labels = dB2LinScaling4Plots(PlotRadius.Labels_dB);
    end
    PlotRadius.OneSidedBWs = [150, 180, 180, 180, 180];                           % User Defineable
    ThetaSweep = -PlotRadius.MaxTheta:PlotRadius.ThetaStep:PlotRadius.MaxTheta; % User Defineable
        % note to self, make GUI to aid user in defining these variables!

        
%% Second Stage: Create Figure based on inputs    
% Make the Figure and Plot the axes:
    close all;
    figure;
    plot(0, 0);
    hold on;
    ylim([-(PlotRadius.YMin+0.1),1.1])
    %ylim([-(PlotRadius.Labels(end-1)+0.1),1.1])
    xlim([-1.1,1.1])
    pbaspect([2.2/(1.1+0.1+PlotRadius.YMin) 1 1])
    ax = gca;
    ax.YAxisLocation = 'origin';
    ax.YAxis.Color = 'k';
    ax.YAxis.FontWeight = 'bold';
    ax.YAxis.FontSize = 14;
    ax.Layer = 'top';
    ax.XAxis.Visible = 'off';
    ax.YAxis.Visible = 'off';
    ax.YTickMode = 'manual';
    ax.YTick = [flip(PlotRadius.Labels)];
    title('dB Directivity');
    
    %plot the fixed radius arches
    for k = 1:length(PlotRadius.Labels)
        degreeRange = -PlotRadius.OneSidedBWs(k):1:PlotRadius.OneSidedBWs(k);
        [xRange, yRange] = pol2cart(deg2rad(90+degreeRange), PlotRadius.Labels(k));
        plot(xRange, yRange, 'Color','#848482');
        if strcmp('origin',ax.YAxisLocation)
            dB_labelsText = text(0.01, 0.005 + dB2LinScaling4Plots(PlotRadius.Labels_dB(k)), 0.1, num2str(PlotRadius.Labels_dB(k)));
        end                
        if strcmp('right',ax.YAxisLocation)
            dB_labelsText = text(1, 0.002 + dB2LinScaling4Plots(PlotRadius.Labels_dB(k)), 0.1, num2str(PlotRadius.Labels_dB(k)));    
        end
        if strcmp('left',ax.YAxisLocation)
            dB_labelsText = text(-1.1, 0.002 + dB2LinScaling4Plots(PlotRadius.Labels_dB(k)), 0.1, num2str(PlotRadius.Labels_dB(k)));    
        end
        dB_labelsText.Color = 'k';
        dB_labelsText.FontSize = 16;
        dB_labelsText.FontWeight = 'bold';
        
        for thetaSweep = ThetaSweep
            if length(degreeRange(degreeRange==thetaSweep)) % detect if the current thetaSweep value falls within the degreeRange of the current k index.
                
                % remove current thetaSweep from ThetaSweep so it doesn't
                % get repeated later!
                idx = ismember(ThetaSweep, [thetaSweep]);
                ThetaSweep(idx) = [];
                
                % plot the theta line:
                radiusRange = linspace(0, PlotRadius.Labels(k), 100);
                [xRange2, yRange2] = pol2cart(deg2rad(90+thetaSweep), radiusRange);
                plot(xRange2, yRange2, 'Color', '#848482');
                txt = num2str(thetaSweep)+"°";
                if thetaSweep == -180
                    
                elseif thetaSweep == 180
                    t = text(xRange2(end)-0.03, yRange2(end)-0.02, txt);                
                elseif thetaSweep == 0
                    t = text(xRange2(end)-0.01, yRange2(end)+0.03, txt);                    
                elseif thetaSweep < 0                   
                    t = text(xRange2(end)+0.02, yRange2(end)+0.01, txt);                    
                else                  
                    t = text(xRange2(end)-0.065, yRange2(end)+0.01, txt);                    
                end
                t.Color = 'k';
                t.FontSize = 11;
                t.FontWeight = 'bold';
            end
        end
        
        
    end
    
    %plot the standard theta lines (@ PlotRadius.ThetaStep increments)
%     for k = 1:length(PlotRadius.Labels)
%        radiusRange =  linspace(0,PlotRadius.Labels(k), 100);
%        
%     end
    
%% Add actual data to plot:
% I wrote this code to follow example shown in 
% 
% <<img2.jpg>>
% 
sweepStep_deg = 0.5;
theta_deg = -PlotRadius.MaxTheta : sweepStep_deg : PlotRadius.MaxTheta-sweepStep_deg;
theta_deg_neg90_to_90 = -90:sweepStep_deg:90;
%directivityExample = abs(cos(deg2rad(theta_deg)).^15);
%[xDir, yDir] = pol2cart(deg2rad(90+theta_deg), directivityExample);
%p1 = plot(xDir, yDir, 'DisplayName', 'cos(theta)^n', 'LineWidth', 2);

%legend([p1], {'cos(theta)^n'})    
plots = [];
%functionStrings = {};
sumTot = [];
lenTot = [];
for k = 1:6
    if k == 5
        d = abs(((1+cos(deg2rad(theta_deg)))/2));
        fs = "$\frac{1+cos(\theta)}{2}$";
    else
        d = abs(cos(deg2rad(theta_deg)).^k);
        fs = "$cos(\theta)^" + num2str(k)+"$";
    end
    symmetryTest = [];
    offsetVal = 180/sweepStep_deg;
    for m = 1:offsetVal
        symmetryTest = [symmetryTest abs(d(m)-d(m+offsetVal))<0.000000000000001];
    end
    sumTot = [sumTot sum(symmetryTest)];
    lenTot = [lenTot length(symmetryTest)];
    %fprintf(
    if sum(symmetryTest) == length(symmetryTest)
        %only plot -90 to 90 deg..
        d = abs(cos(deg2rad(theta_deg_neg90_to_90)).^k);
        if strcmp(ScaleType, 'dB')
            d_dB = dBscaleFactor.*log10(d);
            d_dB(d_dB < dB_minimumValue) = dB_minimumValue;
            d_dB(d_dB > dB_maximumValue) = dB_maximumValue;
            d_LinRepresentation = dB2LinScaling4Plots(d_dB);
            [xDir, yDir] = pol2cart(deg2rad(90+theta_deg_neg90_to_90), d_LinRepresentation);
        else
            [xDir, yDir] = pol2cart(deg2rad(90+theta_deg_neg90_to_90), d_LinRepresentation);
        end
        
    else 
        if strcmp(ScaleType, 'dB')
            d_dB = dBscaleFactor.*log10(d);
            d_dB(d_dB < dB_minimumValue) = dB_minimumValue;
            d_dB(d_dB > dB_maximumValue) = dB_maximumValue;
            d_LinRepresentation = dB2LinScaling4Plots(d_dB);
            [xDir, yDir] = pol2cart(deg2rad(90+theta_deg), d_LinRepresentation);
        else
            [xDir, yDir] = pol2cart(deg2rad(90+theta_deg), d);
        end
    end
    plt = plot(xDir, yDir, 'LineWidth', 2, 'DisplayName', fs);
    plots = [plots plt];
    %functionStrings = {functionStrings fs};
end

legend(plots, 'Interpreter', 'latex', 'FontSize', 16)