function outmatrix = WeightMatrix(NumCol,NumRow,flag)
%WeightMatrix defines a weighting matrix for the overlaping section of two 
%PoleFigure.intensities reshaped to PoleFigure.r.x dimension, based on the
%provided Number of Col & Number of Row & a flag indicating increasing 
%(flag = 1) or decreasing (flag = 0) weighting factors between 0 to 1.
% Created by Dr. Tony Wang on 13th Jan 2020. Email:tony.wang@qut.edu.au

a = linspace(0,1,NumCol+2);
if flag == 0
    a = fliplr(a);
end
outmatrix = reshape(repelem(a(2:end-1),NumRow),NumRow,NumCol);
end

