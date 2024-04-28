x1 = [0 0 1 1];
x2 = [0 1 0 1];
z =  [0 1 1 0];

disp('Enter Weights:');
w11= input('Weight w11:');
w12= input('Weight w12:');
w21= input('Weight w21:');
w22= input('Weight w22:');
v1= input('Weight v1:');
v2= input('Weight v2:');
theta=input('Enter threshold value, theta: ');

y=[0 0 0 0];
y1=[0 0 0 0];
y2=[0 0 0 0];

con=1;
while con
    zin1=x1*w11+x2*w12;
    zin2=x1*w21+x2*w22;
    for i=1:4
        if zin1(i) >=theta
            y1(i)=1;
        else
            y1(i)=0;
        end
        if zin2(i) >=theta
            y2(i)=1;
        else
            y2(i)=0;
        end
    end
    yin=y1*v1+y2*v2;
    for i=1:4
        if yin(i) >=theta
            y(i)=1;
        else
            y(i)=0;
        end
    end
    fprintf('\nOutput of Net:');
    disp(y);

    if isequal(y, z)
        con=0;
    else
        disp('Net is not learing. Enter another set of weight and threshold value.');
        w11= input('Weight w11:');
        w12= input('Weight w12:');
        w21= input('Weight w21:');
        w22= input('Weight w22:');
        v1= input('Weight v1:');
        v2= input('Weight v2:');
        theta=input('Enter threshold value, theta: ');
    end
end

disp('McCulloch Pitts net for XOR function: ');
fprintf('\nWeight of Neuron Z1:');
disp([w11,w12]);
fprintf('Weight of Neuron Z2:');
disp([w21,w22]);
fprintf('Weight of Neuron Y:');
disp([v1,v2]);
fprintf('Threshold value:');
disp(theta);