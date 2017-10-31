% Date:29/10/2017
% This code refers to the code written by Changkai Zhao
% Email:changkaizhao1006@gmail.com
% completed and corrected in 20/06/2013 and in 23/06/2013
%
% This algorithm is described in details in
%
% "Single Image Haze Removal Using Dark Channel Prior",
% by Kaiming He Jian Sun Xiaoou Tang,
% In: CVPR 2009

% details about guilded image filter in
% "Guilded image filtering"
% by Kaiming He Jian Sun Xiaoou Tang

% OUTPUT:
% J is the obtained clear image after visibility restoration.
% tmap is the raw transmission map.
% tmap_ref is the refined transmission map.

function [J, t_map, tmap_ref] = darkChannel(I, px, w)

    % calculate running time
    tic;

    % by default, constant parameter w is set to 0.95.
    if (nargin < 3)
       w = 0.95;
    end

    % by default, the Ω(x) size is set to 15.
    if (nargin < 2)
       px = 15;
    end

    % error, no argument.
    if (nargin < 1)
    	msg1 = sprintf('%s: Not input.', upper(mfilename));
        eid = sprintf('%s:NoInputArgument',mfilename);
        error(eid,'%s %s',msg1);
    end

    % error, parameter out of bound.
    if ((w >= 1.0) || (w<=0.0))
    	msg1 = sprintf('%s: w is out of bound.', upper(mfilename));
        msg2 = 'It must be an float between 0.0 and 1.0';
        eid = sprintf('%s:outOfRangeP',mfilename);
        error(eid,'%s %s',msg1,msg2);
    end

    % error, px out of bound.
    if (px < 1)
    	msg1 = sprintf('%s: px is out of bound.', upper(mfilename));
        msg2 = 'It must be an integer higher or equal to 1.';
        eid = sprintf('%s:outOfRangeSV',mfilename);
        error(eid,'%s %s',msg1,msg2);
    end

    % Pick the top 0.1% brightest pixels in the dark channel.
    inputImage = im2double(I);
    [dimr, dimc, col] = size(I);
    dx = floor(px / 2);

    % L0Smoothing
    Image = L0Smoothing(inputImage, 0.015);

    if(col == 3)
    	% find darkChannel
        J_darkchannel = findDarkChannel(Image, dimr, dimc, dx);

        % get the Airlight
        Airlight = getAirlight(J_darkchannel, Image);

        % Estimating the raw transmission map(color)
        t_map = getRawTransmissionMap(Airlight, Image, dimr, dimc, dx, w);
        
        % Refine the raw transmission map(color)
        % using softmatting
        tmap_ref = softmatting(Image, t_map);

        % using guidedfilter_color
        % tmap_ref = guidedfilter_color(Image, t_map, 40, 0.001);

        % Getting the clear image(color)
        J = getClearImage(dimr, dimc, col, tmap_ref, Airlight, inputImage);

        % show the result
        figure,imshow(Image),title('Input Image');
        figure,imshow(t_map),title('Raw t map');
        figure,imshow(tmap_ref),title('Refined t map');
        figure,imshow(J),title('Output Image');
        
        imwrite(Image, 'Input_Image.jpg');
        imwrite(t_map, 'Raw_t_map.jpg');
        imwrite(tmap_ref, 'Refined_t_map.jpg');
        imwrite(J, 'Output_Image.jpg');
    end

    % stop calculate running time
    toc;
end