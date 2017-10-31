function J = getClearImage(dimr, dimc, col, tmap_ref, Airlight, Image)
	J = zeros(dimr, dimc, col);

	% set the lowest t0
    [lightRow, lightCol] = find(tmap_ref < 0.1);
    [enum, ~] = size(lightRow);
    for i = (1 : enum)
        tmap_ref(lightRow(i), lightCol(i)) = 0.1;
    end

    J(:, :, 1) = (Image(:, :, 1) - Airlight(1)) ./ tmap_ref + Airlight(1);
    J(:, :, 2) = (Image(:, :, 2) - Airlight(2)) ./ tmap_ref + Airlight(2);
    J(:, :, 3) = (Image(:, :, 3) - Airlight(3)) ./ tmap_ref + Airlight(3);
end