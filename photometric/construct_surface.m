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
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        

       
        % =================================================================
        height_map = column_wise(p, q);
            
               
    case 'row'
        
        % =================================================================
        % YOUR CODE GOES HERE
        
        height_map = row_wise(p, q);
        % =================================================================
          
    case 'average'
        
        % =================================================================
        % YOUR CODE GOES HERE
        height_map_row = row_wise(p, q);
        height_map_column = column_wise(p, q);
        height_map = (height_map_row + height_map_column) / 2;

        
        % =================================================================
end


end

function [height_map] = column_wise(p, q)
    [h, w] = size(p);
    height_map = zeros(h, w);
    
    height_map(1,1) = 0;
    for column = 2:h
       height_map(column,1) =  height_map(column-1,1) + q(column, 1);
    end

    for row = 1:w
        for column = 2:h
            height_map(column, row) = height_map(column-1, row) + p(column, row);
        end
    end
end

function [height_map] = row_wise(p, q)
    [h, w] = size(p);
    height_map = zeros(h, w);
    
    height_map(1,1) = 0;
    for row = 2:w
       height_map(1, row) =  height_map(1, row-1) + p(1, row);
    end

    for row = 2:w
        for column = 1:h
            height_map(column, row) = height_map(column, row-1) + q(column, row);
        end
    end
end


