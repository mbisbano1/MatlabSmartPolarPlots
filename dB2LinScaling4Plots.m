function lin_val = dB2LinScaling4Plots(dB_val, dB_min, dB_max, lin_min, lin_max)

    if nargin < 5
        lin_max = 1;
    end
    if nargin < 4
        lin_min = 0;
    end
    if nargin < 3
        dB_max = 0;
    end
    if nargin < 2
        dB_min = -40;
    end
    
    scale_factor_0to1 = abs(dB_max-dB_min);
    val_0to1 = (dB_val - dB_min)/scale_factor_0to1;
    scale_factor_lin_output = abs(lin_max-lin_min);
    
    lin_val = scale_factor_lin_output*val_0to1 + lin_min;
end