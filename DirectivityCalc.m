function Directivity = DirectivityCalc(H, dtheta, minTheta, maxTheta)
    disp(['dtheta = ', num2str(dtheta)]);
    disp(['minTheta = ', num2str(minTheta)]);
    disp(['maxTheta = ', num2str(maxTheta)]);
    %clear theta thetaDeg frow0deg frow90deg frowN90deg frow180deg frowN180deg
    clearvars -except H dtheta minTheta maxTheta
    theta = deg2rad(minTheta:dtheta:maxTheta-dtheta);
    thetaDeg = (minTheta:dtheta:maxTheta-dtheta);
    
    if iscolumn(H)
        H = H.';
    end
    
    
    
    Q = nan;
    
    if minTheta == -180 && maxTheta == 180
        disp('-180 to 180 Directivity Calc:')
        [frow0deg, fcol] = find(thetaDeg(:) == 0.00, 1);
        [frow90deg, fcol] = find(thetaDeg(:) == 90, 1);
        [frowN90deg, fcol] = find(thetaDeg(:) == -90, 1);
        [frow180deg, fcol] = find(thetaDeg(:) == 180-dtheta, 1);
        [frowN180deg, fcol] = find(thetaDeg(:) == -180, 1);
        H1 = H(frow0deg:frow90deg);
        t1 = theta(frow0deg:frow90deg);
        H2 = H(frow90deg:frow180deg);
        t2 = theta(frow90deg:frow180deg);
        H3 = H(frowN180deg:frowN90deg);
        t3 = theta(frowN180deg:frowN90deg);
        H4 = H(frowN90deg:frow0deg);
        t4 = theta(frowN90deg:frow0deg);
        disp(['0Idx: ', num2str(frow0deg), ' 90Idx: ', num2str(frow90deg)]);
        disp(['180Idx: ', num2str(frow180deg), ' -180Idx: ', num2str(frowN180deg)]);
        disp(['-90Idx: ', num2str(frowN90deg)]);
        %Q = trapz(t1, H1.^2) + (trapz(t2, H2.^2)) + (trapz(t3, H3.^2)) + (trapz(t4, H4.^2));
        %Q = trapz(t1, sin(t1).*(H1.^2)) + (trapz(t2, sin(t2).*(H2.^2))) + (trapz(t3, sin(t3).*(H3.^2))) + (trapz(t4, sin(t4).*(H4.^2)));
        Q = abs(trapz(t1, sin(t1).*(H1.^2))) + abs(trapz(t2, sin(t2).*(H2.^2))) + abs(trapz(t3, sin(t3).*(H3.^2))) + abs(trapz(t4, sin(t4).*(H4.^2)));
    %elseif minTheta == -90 && maxTheta == 90
        %H = H;
        %theta = theta;
    
    elseif minTheta == -90 && maxTheta == 90
        disp('-90 to 90 Directivity Calc:');
        [frow0deg, fcol] = find(thetaDeg(:) == 0.00, 1);
        [frow90deg, fcol] = find(thetaDeg(:) == 90-dtheta, 1);
        [frowN90deg, fcol] = find(thetaDeg(:) == -90, 1);
        %[frow180deg, fcol] = find(thetaDeg(:) == 180-dtheta, 1);
        %[frowN180deg, fcol] = find(thetaDeg(:) == -180, 1);
        H1 = H(frow0deg:frow90deg);
        t1 = theta(frow0deg:frow90deg);
        %H2 = H(frow90deg:frow180deg);
        %t2 = theta(frow90deg:frow180deg);
        %H3 = H(frowN180deg:frowN90deg);
        %t3 = theta(frowN180deg:frowN90deg);
        H4 = H(frowN90deg:frow0deg);
        t4 = theta(frowN90deg:frow0deg);
        disp(['0Idx: ', num2str(frow0deg), ' 90Idx: ', num2str(frow90deg)]);
        %disp(['180Idx: ', num2str(frow180deg), ' -180Idx: ', num2str(frowN180deg)]);
        disp(['-90Idx: ', num2str(frowN90deg)]);
        %Q = trapz(t1, H1.^2) + (trapz(t2, H2.^2)) + (trapz(t3, H3.^2)) + (trapz(t4, H4.^2));
        %Q = trapz(t1, sin(t1).*(H1.^2)) + (trapz(t2, sin(t2).*(H2.^2))) + (trapz(t3, sin(t3).*(H3.^2))) + (trapz(t4, sin(t4).*(H4.^2)));
        Q = 2*(abs(trapz(t1, sin(t1).*(H1.^2))) + abs(trapz(t4, sin(t4).*(H4.^2))));
    %elseif minTheta == -90 && maxTheta == 90
        %H = H;
        %theta = theta;
                
    elseif minTheta == 0 && maxTheta == 360      % 0 to 360 for Austin
        disp('0 to 360 Directivity Calc:');
        [frow0deg, fcol] = find(thetaDeg(:) == 0.00, 1);
        [frow90deg, fcol] = find(thetaDeg(:) == 90-dtheta, 1);
        [frow180deg, fcol] = find(thetaDeg(:) == 180-dtheta, 1);
        [frow270deg, fcol] = find(thetaDeg(:) == 270-dtheta, 1);
        [frow360deg, fcol] = find(thetaDeg(:) == 360-dtheta, 1);
        H1 = H(frow0deg:frow90deg);
        t1 = theta(frow0deg:frow90deg);
        H2 = H(frow90deg+1:frow180deg);
        t2 = theta(frow90deg+1:frow180deg);
        H3 = H(frow180deg+1:frow270deg);
        t3 = theta(frow180deg+1:frow270deg);
        %H4 = H(frow270deg+1:end);
        %t4 = theta(frow270deg+1:end);
        H4 = H(frow270deg+1:frow360deg);
        t4 = theta(frow270deg+1:frow360deg);
        
        disp(['0Idx: ', num2str(frow0deg), ' 90Idx: ', num2str(frow90deg)]);
        disp(['180Idx: ', num2str(frow180deg), ' 270Idx: ', num2str(frow270deg)]);
        disp(['360Idx: ', num2str(frow360deg)]);
        
        Q = abs(trapz(t1, sin(t1).*(H1.^2))) + abs(trapz(t2, sin(t2).*(H2.^2))) + abs(trapz(t3, sin(t3).*(H3.^2))) + abs(trapz(t4, sin(t4).*(H4.^2)));
    end
    %theta = -pi/2:deg2rad(dtheta):pi/2;
    %Q = trapz(theta, sin(theta).*H.^2);
    phi = 0:pi/100000:pi/2;
    H2 = ones(1, length(phi));
    Q2 = 2*trapz(phi, (H2.^2));
    if ~isnan(Q)
        Directivity = 4*pi/(Q*Q2);
    else
        Directivity = -1;
    end
end