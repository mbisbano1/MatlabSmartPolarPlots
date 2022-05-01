clear all
close all
clc

%% Collect User Inputs:

ScaleType = menu('Linear or dB scale?', 'Linear', 'dB');
% ScaleType menu returns a 1 or 2 for Lin or dB.

% gather dB scale factor (10 or 20) for pressure or power etc...
if ScaleType == 2
    dBscaleFactorPrompt = menu('Choose dB scale Factor','10', '20');
    if dBscaleFactorPrompt == 1
        dBscaleFactor = 10;
    elseif dBscaleFactorPrompt == 2
        dBscaleFactor = 20;
    end
end
UseDefaultSettings = menu('Use default settings or specify?', 'Default', 'Specify');
% useDefaultSettings menu returns a 1 for default and 2 for specifying new
% settings..

if UseDefaultSettings == 1
    if ScaleType == 1 % Linear Scale Default Settings
        YMin = 0.5;
        ThetaStep = 30;  
        MaxTheta = 180;
        Labels = [1, 0.8, 0.6, 0.4, 0.2]; 
        OneSidedBWs = [60, 90, 120, 150, 180];
        YAxisLocation = 'origin';
    else    % dB Scale Default Settings
        dB_minimumValue = -40;
        dB_maximumValue = 0;
        YMin = 0.8;
        ThetaStep = 30;  
        MaxTheta = 180;       
        Labels_dB = [0, -10, -20, -30, -40];
        Labels = dB2LinScaling4Plots(Labels_dB);
        OneSidedBWs = [60, 90, 120, 150, 180];
        YAxisLocation = 'origin';
    end           
else                                                                        % User Specifies their own parameters
    if ScaleType == 1 % Linear Scale Settings Specified
        prompt = {'Enter YMin:', 'Enter ThetaStep:', 'Enter MaxTheta:',...
            'Enter Label Values in decreasing order, matlab array format:', ...
            'Enter One Sided BW corresponding to each Label Value, matlab array format:',...
            'Enter Radius Label location( left, origin, or right):'};
        dlgtitle = 'Specify Your Settings';
        dims = [2 60];
        defaultInput = {'0.5', '30', '180', '[1 0.8 0.6 0.4 0.2]', '[60 90 120 150 180]', 'origin'}; 
        answer = inputdlg(prompt, dlgtitle, dims, defaultInput);
        YMin = str2num(char(answer(1)));
        ThetaStep = str2num(char(answer(2)));
        MaxTheta = str2num(char(answer(3)));
        Labels = str2num(char(answer(4)));
        OneSidedBWs = str2num(char(answer(5)));
        YAxisLocation = char(answer(6));
        
    else                % dB Scale Settings Specified
        prompt = {'Enter YMin:', 'Enter ThetaStep:', 'Enter MaxTheta:',...
            'Enter Label Values in decreasing order, matlab array format:', ...
            'Enter One Sided BW corresponding to each Label Value, matlab array format:',...
            'Enter Radius Label location( left, origin, or right):',...
            'Enter dB Minimum Value:', 'Enter dB Maximum Value:'};
        dlgtitle = 'Specify Your Settings';
        dims = [2 60];
        defaultInput = {'0.8', '30', '180', '[0 -10 -20 -30 -40]', '[60 90 120 150 180]', 'origin', '-40', '0'}; 
        answer = inputdlg(prompt, dlgtitle, dims, defaultInput);
        YMin = str2num(char(answer(1)));
        ThetaStep = str2num(char(answer(2)));
        MaxTheta = str2num(char(answer(3)));
        Labels_dB = str2num(char(answer(4)));
        Labels = dB2LinScaling4Plots(Labels_dB);
        OneSidedBWs = str2num(char(answer(5)));     
        YAxisLocation = char(answer(6));
    end
    
end
ThetaSweep = -MaxTheta:ThetaStep:MaxTheta; % User Defineable

%% Start Setting up the Figure and Plot:

    figure;
    plot(0, 0);
    hold on;
    ylim([-(YMin+0.1),1.1])
    xlim([-1.1,1.1])
    pbaspect([2.2/(1.1+0.1+YMin) 1 1])
    ax = gca;
    ax.YAxisLocation = YAxisLocation;
    ax.YAxis.Color = 'k';
    ax.YAxis.FontWeight = 'bold';
    ax.YAxis.FontSize = 14;
    ax.Layer = 'top';
    ax.XAxis.Visible = 'off';
    ax.YAxis.Visible = 'off';
    ax.YTickMode = 'manual';
    if ScaleType == 1
        ax.YTick = [0 flip(Labels)];
        title('Linear Directivity');
    else
        ax.YTick = [flip(Labels)];
    title('dB Directivity');
    end

       %plot the fixed radius arches
    for k = 1:length(Labels)
        degreeRange = -OneSidedBWs(k):1:OneSidedBWs(k);
        [xRange, yRange] = pol2cart(deg2rad(90+degreeRange), Labels(k));
        plot(xRange, yRange, 'Color','#848482');
        if ScaleType == 2
            if strcmp('origin',ax.YAxisLocation)
                dB_labelsText = text(0.01, 0.005 + dB2LinScaling4Plots(Labels_dB(k)), 0.1, num2str(Labels_dB(k)));
            end                
            if strcmp('right',ax.YAxisLocation)
                dB_labelsText = text(1, 0.002 + dB2LinScaling4Plots(Labels_dB(k)), 0.1, num2str(Labels_dB(k)));    
            end
            if strcmp('left',ax.YAxisLocation)
                dB_labelsText = text(-1.1, 0.002 + dB2LinScaling4Plots(Labels_dB(k)), 0.1, num2str(Labels_dB(k)));    
            end
            dB_labelsText.Color = 'k';
            dB_labelsText.FontSize = 16;
            dB_labelsText.FontWeight = 'bold';
        else 
            if strcmp('origin',ax.YAxisLocation)
                labelsText = text(0.01, 0.005 + (Labels(k)), 0.1, num2str(Labels(k)));
            end                
            if strcmp('right',ax.YAxisLocation)
                labelsText = text(1, 0.002 + (Labels(k)), 0.1, num2str(Labels(k)));    
            end
            if strcmp('left',ax.YAxisLocation)
                labelsText = text(-1.1, 0.002 + (Labels(k)), 0.1, num2str(Labels(k)));    
            end
            labelsText.Color = 'k';
            labelsText.FontSize = 16;
            labelsText.FontWeight = 'bold';
        end

        for thetaSweep = ThetaSweep
            if length(degreeRange(degreeRange==thetaSweep)) % detect if the current thetaSweep value falls within the degreeRange of the current k index.

                % remove current thetaSweep from ThetaSweep so it doesn't
                % get repeated later!
                idx = ismember(ThetaSweep, [thetaSweep]);
                ThetaSweep(idx) = [];

                % plot the theta line:
                radiusRange = linspace(0, Labels(k), 100);
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

%%  Add actual data to plot:
    % I wrote this code to follow example shown in 
    % 
    % <<img2.jpg>>
    % 
    sweepStep_deg = 0.25;
    theta_deg = -MaxTheta : sweepStep_deg : MaxTheta-sweepStep_deg;
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
            if ScaleType == 2
                d_dB = dBscaleFactor.*log10(d);
                d_dB(d_dB < dB_minimumValue) = dB_minimumValue;
                d_dB(d_dB > dB_maximumValue) = dB_maximumValue;
                d_LinRepresentation = dB2LinScaling4Plots(d_dB);
                [xDir, yDir] = pol2cart(deg2rad(90+theta_deg_neg90_to_90), d_LinRepresentation);
            else
                [xDir, yDir] = pol2cart(deg2rad(90+theta_deg_neg90_to_90), d);
            end
            
        else
            if ScaleType == 2
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
