function y=shape_env1(x_length)
    y(1:floor(x_length*0.16))=linspace(0,1,floor(x_length*0.16));
    y(floor(x_length*0.16)+1:floor(x_length*0.28))=linspace(1,0.5,floor(x_length*0.28)-floor(x_length*0.16));
    y(floor(x_length*0.28)+1:floor(x_length*0.64))=0.5;
    y(floor(x_length*0.64)+1:x_length)=linspace(0.5,0,x_length-floor(x_length*0.64));
end