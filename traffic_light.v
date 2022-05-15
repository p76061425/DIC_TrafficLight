module traffic_light(clk,rst,pass,R,G,Y);
input clk,rst,pass;
output R,G,Y;

//write your code here
reg R,G,Y;
reg [1:0]currentstate,nextstate;

parameter [1:0] Red_Light = 2'b00,Green_Light = 2'b01,Yellow_Light = 2'b10;
reg[4:0]cnt;
wire chanegG;


always@(posedge clk or posedge rst or posedge chanegG  )begin

    if(rst)begin
        cnt <= 0;
    end
    else if(chanegG)begin
        cnt<=1;
    end 
    else if(pass && currentstate!= Green_Light)
        cnt<=1;
    else if((currentstate == Red_Light) && cnt == 10)
        cnt<= 1;
    else if((currentstate == Green_Light) && cnt == 12)
        cnt<= 1;        
    else if((currentstate == Yellow_Light) && cnt == 5)
        cnt<= 1;
    else begin
        cnt <= cnt+1;
    end

end

always@(posedge clk or posedge rst or posedge chanegG )begin
    if(rst)begin
        currentstate = Red_Light;
    end
    else if(chanegG)begin
        currentstate = Green_Light;
    end 
    else begin
        currentstate = nextstate;
    end
end


assign chanegG = pass & (currentstate != Green_Light);


always@(*)begin

    case(currentstate)
    
        Red_Light:begin
            if(cnt == 10 || pass == 1)
                nextstate = Green_Light;
            else
                nextstate = Red_Light;
        end
        Green_Light:begin
            if(cnt == 12)
                nextstate = Yellow_Light;
            else if(pass)
                nextstate = Green_Light;                
            else
                nextstate = Green_Light; 
        end
        Yellow_Light:begin
            if(cnt == 5)
                nextstate = Red_Light;
            else if(pass)
                nextstate = Green_Light;
            else
                nextstate = Yellow_Light; 
        end
        default: nextstate = Red_Light;
        
    endcase
    
end

always@(*)begin

    case(currentstate)
        Red_Light:begin
            R = 1;
            G = 0;
            Y = 0;
        end
        Green_Light:begin
            R = 0;
            G = 1;
            Y = 0;
        end
        Yellow_Light:begin
            R = 0;
            G = 0;
            Y = 1;
        end
        default:begin
            R = 0;
            G = 0;
            Y = 0;            
        end
    endcase
    
end


endmodule

