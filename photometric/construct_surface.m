function [ height_map ] = construct_surface( p, q, path_type )
    %CONSTRUCT_SURFACE construct the surface function represented as height_map
    %   p : measures value of df / dx
    %   q : measures value of df / dy
    %   path_type: type of path to construct height_map, either 'column',
    %   'row', or 'average'
    %   height_map: the reconstructed surface

    if nargin == 2
        path_type = 'column';
    end

    [h, w] = size(p);
    height_map = zeros(h, w);

    switch path_type
        case 'column'
            height_map = column_wise(p, q);

        case 'row'
            height_map = row_wise(p, q);

        case 'average'
            height_map_row = row_wise(p, q);
            height_map_column = column_wise(p, q);
            % use absolute value when taking the average to prevent
            % canceling out heights in coloured images
            height_map = (abs(height_map_row) + abs(height_map_column)) / 2;
    end
end

% top left corner of height_map is zero
% for each pixel in the left column of height_map
%   height_value = previous_height_value + corresponding_q_value

% for each row
%   for each element of the row except for leftmost
%       height_value = previous_height_value + corresponding_p_value
function [height_map] = column_wise(p, q)
    [h, w] = size(p);
    height_map = zeros(h, w);
    
    height_map(1,1) = 0;
    for row = 2:h
       height_map(row,1) =  height_map(row-1,1) + q(row, 1);
    end

    for row = 1:h
        for column = 2:w
            height_map(row, column) = height_map(row, column-1) + p(row, column);
        end
    end
end

function [height_map] = row_wise(p, q)
    [h, w] = size(p);
    height_map = zeros(h, w);
    
    height_map(1,1) = 0;
    for column = 2:w
       height_map(1, column) =  height_map(1, column-1) + p(1, column);
    end

    for row = 2:h
        for column = 1:w
            height_map(row, column) = height_map(row-1, column) + q(row, column);
        end
    end
end


