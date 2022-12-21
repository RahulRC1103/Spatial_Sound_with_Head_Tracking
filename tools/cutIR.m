function [IR_cut] = cutIR(IR, IRlength)

    [~, index] = max(IR);

    IR_cut = IR(index - 20: index -20 + IRlength);

end
