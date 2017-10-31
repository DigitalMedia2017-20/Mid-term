function J_darkchannel = findDarkChannel(Image, dimr, dimc, dx)
	J_darktemp = zeros(dimr, dimc);

    % Estimate the atmospheric light
    J_darkchannel = min(Image, [], 3);  % find the minimum value in RGB channel
    for i = (1 : dimr)
        for j = (1 : dimc)
            winLeft = i - dx; winRight = i + dx;
            winUp   = j - dx; winDown  = j + dx;

            % check the windows range
            if(i - dx < 1)
                winLeft = 1;
            end
            if(i + dx > dimr)
                winRight = dimr;
            end
            if(j - dx < 1)
                winUp = 1;
            end
            if(j + dx > dimc)
                  winDown=dimc;
            end

            % find the minimum value in the Ω windows
            J_darktemp(i,j) = min(min(J_darkchannel(winLeft : winRight, winUp : winDown)));
        end
    end
    J_darkchannel = J_darktemp;
end