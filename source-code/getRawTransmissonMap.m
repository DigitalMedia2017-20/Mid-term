function t_map = getRawTransmissionMap(Airlight, Image, dimr, dimc, dx, w)

	Im_n(:, :, 1) = Image(:, :, 1) ./ Airlight(1);
    Im_n(:, :, 2) = Image(:, :, 2) ./ Airlight(2);
    Im_n(:, :, 3) = Image(:, :, 3) ./ Airlight(3);
    tmap = min(Im_n, [], 3);

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
                winDown = dimc;
            end

            % find the minimum value in the Ω windows
            % get the image transmittance
            t_map(i, j) = 1 - w * min(min(tmap(winLeft : winRight, winUp : winDown)));
        end
    end
end