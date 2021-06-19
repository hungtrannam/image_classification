function overlap = Dist_Overlap(a,b)
C_a = (a(1,2)+a(1,1)) / 2;
r_a = (max(a)-min(a)) ./ 2;
C_b = (b(1,2)+b(1,1)) / 2;
r_b = (max(b)-min(b)) ./ 2;
if abs(C_a - C_b) <= (r_b - r_a)
    overlap = 0;
elseif abs(C_a - C_b) <= (r_a - r_b)
    overlap = abs((abs(C_a-C_b) + (r_a-r_b)) * (1 - (2 * r_b/(2*r_a+1))));
else
    if r_a == 0 && r_b == 0
        overlap = abs(C_a - C_b);
    elseif abs(C_a - C_b) >= (r_a + r_b) 
        overlap = abs((abs(C_a-C_b) + (r_a-r_b)) * (1 + ((abs(C_a-C_b) - (r_a+r_b))/(2*r_a+1))));
    else %4
        overlap = abs((abs(C_a-C_b) + (r_a-r_b)) * (1 - (((r_a+r_b) - abs(C_a-C_b))/(2*r_a+1))));
    end
end






