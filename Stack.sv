module Stack(
    input bit clk, push_top, push_pen, pop_top, pop_pen,
    input [7:0] push_top_val,
    input [7:0] push_pen_val,
    output logic [7:0] top_val,
    output logic [7:0] pen_val
    );

logic [7:0] stacks[2**3]; // 8 bits wide, 8 values deep
int ptr_top = -1;
int ptr_pen = -2;
logic [7:0] temp_top_val;
logic [7:0] temp_pen_val;

always_ff @ (posedge clk) begin
    
    // case: push both
    if(push_top && push_pen) begin
        ptr_pen <= ptr_pen + 2;
        ptr_top <= ptr_top + 2;

        stacks[ptr_pen] = push_pen_val;
        stacks[ptr_top] = push_top_val;

        temp_top_val = stacks[ptr_top];
        temp_pen_val = stacks[ptr_pen];
/*
        stacks[0] <= push_pen;
        //penVal <= push_pen;
        penVal <= stacks[0];
        stack_ptr <= stack_ptr + 1;
        stacks[1] <= push_top;
        topVal <= stacks[1];
        stack_ptr <= stack_ptr + 1;

*/
    end

    // case: push top only
    if(push_top && !push_pen) begin
        ptr_pen <= ptr_pen + 1;
        ptr_top <= ptr_top + 1;

        stacks[ptr_pen] = push_pen_val;
        stacks[ptr_top] = push_top_val;

        temp_top_val = stacks[ptr_top];
        temp_pen_val = stacks[ptr_pen];        
/*
        stacks[stack_ptr] <= push_top;
        topVal <= push_top;
        stack_ptr <= stack_ptr + 1;
        //topVal <= stack_ptr;
*/
    end

    // case: pop both
    if(pop_top && pop_pen) begin
        temp_top_val <= stacks[ptr_top];
        temp_pen_val <= stacks[ptr_pen];

        ptr_pen = ptr_pen - 2;
        ptr_top = ptr_top - 2;
/*
        stack_ptr <= stack_ptr - 2;
        topVal <= stacks[1];
        stack_ptr <= stack_ptr - 1;
        penVal <= stacks[0];
*/
    end

    // case: pop top only
    if(pop_top && !pop_pen) begin
        temp_top_val <= stacks[ptr_top];
        temp_pen_val <= stacks[ptr_pen];

        ptr_pen = ptr_pen - 2;
        ptr_top = ptr_top - 2;
/*
        stack_ptr <= stack_ptr - 2;
        topVal <= stacks[stack_ptr];
*/
    end

end

assign top_val = temp_top_val;
assign pen_val = temp_pen_val;

endmodule
