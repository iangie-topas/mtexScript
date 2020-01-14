function [Newpf] = IntenMerge(pf1,pf2)
%IntenMerge is used to combine 2 overlapping PoleFigures measured at 
%different Chi tilt. 
%Linear weighting of the overlapping area is considered for combination. 
%Created by Dr. Tony Wang on 13th Jan 2020. Email:tony.wang@qut.edu.au

size_matrix = size(pf1.r.x);
pf1inten=reshape(pf1.intensities,size_matrix(1),size_matrix(2));
pf2inten=reshape(pf2.intensities,size_matrix(1),size_matrix(2));

Non0col1=find(sum(abs(pf1inten),1));
Non0col2=find(sum(abs(pf2inten),1));

if Non0col1(end)<Non0col2(1) ||  Non0col2(end)<Non0col1(1) % No overlap
   Newpf = pf1;
   Newpf.intensities = pf1.intensities+pf2.intensities;
else if Non0col1(1)<=Non0col2(1) && Non0col1(end)>=Non0col2(end) %
     Newpf = pf1;
    else if Non0col1(1)>=Non0col2(1) && Non0col1(end)<=Non0col2(end)
          Newpf = pf2;
        else Newpf = pf1;                
             Overlay1 = pf1inten(:,Non0col1(1):Non0col2(end));
             Overlay2 = pf2inten(:,Non0col1(1):Non0col2(end));
             Newpfinten = pf1inten + pf2inten;
            
            if Non0col1(1)>Non0col2(1)
               Newpfinten(:,Non0col1(1):Non0col2(end)) = Overlay1.*WeightMatrix(Non0col2(end)-Non0col1(1)+1,size_matrix(1),1) + Overlay2.*WeightMatrix(Non0col2(end)-Non0col1(1)+1,size_matrix(1),0);
            else 
               Newpfinten(:,Non0col1(1):Non0col2(end)) = Overlay1.*WeightMatrix(Non0col2(end)-Non0col1(1)+1,size_matrix(1),0) + Overlay2.*WeightMatrix(Non0col2(end)-Non0col1(1)+1,size_matrix(1),1);
            end
            
            Newpf.intensities = reshape(Newpfinten,[],1);

         end
    end
end

end

