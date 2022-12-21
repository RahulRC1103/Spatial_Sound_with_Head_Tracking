function [index] = angle_index(v_ang, h_ang) % vertical angle, horizontal angle
    
    switch v_ang
        case 1          %-10

            res = 5;
            index = index_gen(res, h_ang);            

        case 2          %-20

            res = 5;
            index = index_gen(res, h_ang);

        case 3          %-30

            res = 6;
            index = index_gen(res, h_ang);

        case 4          %-40
    
            res = 6.32;
            index = index_gen(res, h_ang);
    
        case 5       %0
            
            res = 5;
            index = index_gen(res, h_ang);

        case 6      %10

            res = 5;
            index = index_gen(res, h_ang);

        case 7      %20

            res = 5;
            index = index_gen(res, h_ang);

        case 8      %30
            
            res = 6;
            index = index_gen(res, h_ang);

        case 9      %40
            
            res = 6.32;
            index = index_gen(res, h_ang);

        case 10     %50

            res = 8;
            index = index_gen(res, h_ang);

        case 11     %60
            
            res = 10;
            index = index_gen(res, h_ang);

        case 12     %70

            res = 15;
            index = index_gen(res, h_ang);

        case 13     %80
            
            res = 30;
            index = index_gen(res, h_ang);

        case 14     %90

            index = 1;
            


    end

end
