function y = sat(x)

% enfache saturation function
    for i=1:length(x)
        if x(i)>=1
            y(i)=1;    
        elseif x(i)<=-1 
            y(i)=-1;
        else
            y(i)=x(i);
    end
end

