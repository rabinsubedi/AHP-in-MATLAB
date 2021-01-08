%% Input Criterions
heading = {'Enter First Criteria:','Enter Second Criteria:','Enter Third Criteria:', 'Enter Fourth Criteria:'};
dlgtitle = 'Pavement Index Criterions';
dims = [1 80];
definput = {'Asset Preservation (PCR)','Economic Development (AADT' , 'Safety (Rutting)','Congestion Mitigation (Pvt. Width)'};
criteria = inputdlg(heading,dlgtitle,dims,definput);


%% Input priorities of user
imp = (inputdlg({'Enter the importance of Criteria 1 over Criteria 2 on a scale of 1 to 10; 5 being equal importance ',...
    'Enter the importance of Criteria 1 over Criteria 3 on a scale of 0 to 10; 5 being equal importance '...
    'Enter the importance of Criteria 1 over Criteria 4 on a scale of 0 to 10; 5 being equal importance '...
    'Enter the importance of Criteria 2 over Criteria 3 on a scale of 0 to 10; 5 being equal importance '...
    'Enter the importance of Criteria 2 over Criteria 4 on a scale of 0 to 10; 5 being equal importance '...
    'Enter the importance of Criteria 3 over Criteria 4 on a scale of 0 to 10; 5 being equal importance '},...
    'Specify Importance of Criteria for AHP Matrix',[1 80]));
imp = str2double(imp);
%% Conversition of scale from (1-10) to (1/9 to 9)
for i=1:length(imp)
    if(imp(i)>5)
        imp(i)=(imp(i)-6)*2+1;
    elseif (imp(i)<5)
        imp(i)=1/((4-imp(i))*2+1);
    else
        imp(i)=1;
    end
end
%% Formation of upper triangular criteria comparison matrix
ccmatrix=zeros(4,4);
ccmatrix(1,2)=imp(1);
ccmatrix(1,3)=imp(2);
ccmatrix(1,4)=imp(3);
ccmatrix(2,3)=imp(4);
ccmatrix(2,4)=imp(5);
ccmatrix(3,4)=imp(6);

 %% Assigning values to each element of lower triangle of criteria comparison matrix
 for i=1:4
     for j=1:4
         if (i==j)
             ccmatrix(i,j)=1;
         elseif(j<i)
             ccmatrix(i,j)=1/ ccmatrix(j,i);
         end
     end
 end
 %% Calculation of eigenvector
 mmult=ccmatrix*ccmatrix;
 rowsum=sum(mmult,2);
 total=sum(rowsum);
 eigenvector=zeros(4,1);
 for i=1:4
     eigenvector(i)=rowsum(i)/total;
 end
 criteriaWeightage=eigenvector;
%% Inform the completion of calculation
uiwait(msgbox('Calculation of Weightage of Criteria Completed Using AHP Method','Success','modal'));
 %% Plot barchart of weightage of criteria
 cat=categorical(criteria);
 barchart=bar(cat,eigenvector);
title('AHP Calculation Result');
xlabel('Criteria');
ylabel('Weightage');
%% Input the weightage for each class of criteria:
cr1 = inputdlg({'Enter the weightage for  PCR>=85  (Total Sum of Weightage MUST be 1)',...
    'Enter the weightage for 85>PCR>=75',...
    'Enter the weightage for  75>PCR>=65',...
    'Enter the weightage for  65>PCR>=55',...
    'Enter the weightage for  55>PCR'},...
    'Specify weightage for different PCR class',[1 80],{'0.05', '0.1', '0.2', '0.3','0.35'});
cr1 = str2double(cr1);
cr1=cr1*criteriaWeightage(1); %%converting weightage of each class to overall weightage
cr2 = inputdlg({'Enter the weightage for AADT >=5000  (Total Sum of Weightage MUST be 1)',...
    'Enter the weightage for 5000>AADT>1000',...
    'Enter the weightage for 1000>AADT'},...
    'Specify weightage for different AADT class',[1 80],{'0.5', '0.3', '0.2'});
cr2 = str2double(cr2);
cr2=cr2*criteriaWeightage(2); %%converting weightage of each class to overall weightage
cr3 = inputdlg({'Enter the weightage for Rutting >5  (Total Sum of Weightage MUST be 1)',...
    'Enter the weightage for 5>=Rutting'},...
    'Specify weightage for different Rutting Class',[1 80],{'0.7', '0.3'});
cr3 = str2double(cr3);
cr3=cr3*criteriaWeightage(3); %%converting weightage of each class to overall weightage
cr4 = inputdlg({'Enter the weightage for  Pavement Width>=50  (Total Sum of Weightage MUST be 1)',...
    'Enter the weightage for 50>Pavement Width>=20',...
    'Enter the weightage for  20>Pavement Width'},...
    'Specify weightage for different Pavement Width',[1 80],{'0.5', '0.3', '0.2'});
cr4 = str2double(cr4); 
cr4=cr4*criteriaWeightage(4); %%converting weightage of each class to overall weightage
%% Input Excel Sheet
data = readtable('RoadwayData.xlsx');
%% Add columns for calculation of individual and total score
rownum=size(data,1);
data.pcr_score=zeros(rownum,1);
data.aadt_score=zeros(rownum,1);
data.rutting_score=zeros(rownum,1);
data.pvtwidth_score=zeros(rownum,1);
data.total_score=zeros(rownum,1);
%% Calculate weightage of each roads in Table
for i=1:length(data{:,1})
    if(data{i,{'PCR_NBR'}}>=85)
        data{i,{'pcr_score'}}=cr1(1);
    elseif(data{i,{'PCR_NBR'}}<85 && data{i,{'PCR_NBR'}}>=75)
        data{i,{'pcr_score'}}=cr1(2);
    elseif(data{i,{'PCR_NBR'}}<75 && data{i,{'PCR_NBR'}}>=65)
        data{i,{'pcr_score'}}=cr1(3);
    elseif(data{i,{'PCR_NBR'}}<65 && data{i,{'PCR_NBR'}}>=55)
        data{i,{'pcr_score'}}=cr1(4);
    elseif(data{i,{'PCR_NBR'}}<55)
        data{i,{'pcr_score'}}=cr1(5);
    end
end
for i=1:length(data{:,1})
    if(data{i,{'AADT_TOTAL'}}>=5000)
        data{i,{'aadt_score'}}=cr2(1);
    elseif(data{i,{'AADT_TOTAL'}}<5000 && data{i,{'AADT_TOTAL'}}>=1000)
        data{i,{'aadt_score'}}=cr2(2);
    elseif(data{i,{'AADT_TOTAL'}}<1000)
        data{i,{'aadt_score'}}=cr2(3);
    end
end
for i=1:length(data{:,1})
    if(data{i,{'RUTTING_VA'}}>=5)
        data{i,{'rutting_score'}}=cr3(1);
    elseif(data{i,{'RUTTING_VA'}}<5)
        data{i,{'rutting_score'}}=cr3(2);
    end
end
for i=1:length(data{:,1})
    if(data{i,{'SURFACE_WI'}}>=50)
        data{i,{'pvtwidth_score'}}=cr4(1);
    elseif(data{i,{'SURFACE_WI'}}<50 && data{i,{'SURFACE_WI'}}>=20)
        data{i,{'pvtwidth_score'}}=cr4(2);
    elseif(data{i,{'SURFACE_WI'}}<20)
        data{i,{'pvtwidth_score'}}=cr4(3);
    end
end
%% Calculate total score of roads
data.total_score=sum(data{:,{'pcr_score','aadt_score','rutting_score','pvtwidth_score'}},2);
Sort_Table = sortrows(data,'total_score',{'descend'}); %%sort table based on total score
writetable(Sort_Table,'Prioritized_Roads.xlsx','Sheet','Prioritized Roads'); %Export the final table



