function [new_image] = ConvertColorSpace(input_image, colorspace)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Converts an RGB image into a specified color space, visualizes the 
% color channels and returns the image in its new color space.                     
%                                                        
% Colorspace options:                                    
%   opponent                                            
%   rgb -> for normalized RGB
%   hsv
%   ycbcr
%   gray
%
% P.S: Do not forget the visualization part!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% convert image into double precision for conversions
input_image = im2double(input_image);

if strcmp(colorspace, 'opponent')
    new_image = rgb2opponent(input_image);
    titles = ["Opponent color space", "Opponent1", "Opponent2", "Opponent3"];
elseif strcmp(colorspace, 'rgb')  
    new_image = rgb2normedrgb(input_image);
    titles = ["Normalized RGB", "Normalized Red", "Normalized Green", "Normalized Blue"];
elseif strcmp(colorspace, 'hsv')
    new_image = rgb2hsv(input_image);
    titles = ["HSV color space", "Hue", "Saturation", "Value"];
elseif strcmp(colorspace, 'ycbcr')
    new_image = rgb2ycbcr(input_image);
    titles = ["YCbCr color space", "Luminance", "Blue chroma", "Red chroma"];
elseif strcmp(colorspace, 'gray')
    new_image = rgb2grays(input_image);
    titles = ["MatLab-Builtin", "Lightness", "Average", "Luminosity"];
else
% if user inputs an unknow colorspace just notify and do not plot anything
    fprintf('Error: Unknown colorspace type [%s]...\n',colorspace);
    new_image = input_image;
    return;
end

visualize(new_image, titles); % fill in this function

end