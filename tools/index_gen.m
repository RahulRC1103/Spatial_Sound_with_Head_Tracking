function [index] = index_gen(res, h_ang)
    h_ang = res*floor(h_ang/res);
    if h_ang == 0
        index = 1;
    else
        index = round(h_ang / res);
    end
end