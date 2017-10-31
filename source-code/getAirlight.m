function Airlight = getAirlight(J_darkchannel, Image)
	A_r = 0; A_g = 0; A_b = 0;

	% get the 0.1% most brightest pixels in the dark channel
    lightLimit = quantile(J_darkchannel(:), .999);
    [lightRow, lightCol] = find(J_darkchannel >= lightLimit);
    [enum, ~] = size(lightRow);
    for i = (1 : enum)
        A_r = Image(lightRow(i), lightCol(i), 1) + A_r;
        A_g = Image(lightRow(i), lightCol(i), 2) + A_g;
        A_b = Image(lightRow(i), lightCol(i), 3) + A_b;
    end

    % get the Airlight
    Airlight = [A_r / enum, A_g / enum, A_b / enum];
end