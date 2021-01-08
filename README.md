# AHP-in-MATLAB

The AHP is generally used in a selection of optimum alternative, prioritization of projects, and resource allocation. In this process, a hierarchy is formed starting from overall goal, alternatives or projects and criteria or factors based on which alternatives are evaluated to reach the goal. The criteria are sometimes broken into several sub-criteria when they are not enough to evaluate alternatives. The critical part of this process is to determine the relative weight of each criteria. This involves a pairwise comparison of each criterion against all other criteria to form a criteria comparison matrix. The criteria are compared on a scale of 1 to 9 based on its importance over another, as shown in Table 1. Any score between 1 and 9 can be provided during the comparison.

Score	--  Definition

1:  	Both are equally important

3:  	One is moderately important than another

5:  	One is strongly important than another

7:  	One is very strongly important than another

9:  	One is extremely important than another


The criteria comparison matrix obtained from the pairwise comparison is an upper triangular matrix. The elements in the lower triangle are later fixed as reciprocal of elements in the upper triangle. The eigenvector of this matrix gives the relative weight of criteria ( by multiplying the matrix by itself and normalizing the sum of rows by sum of all the elements). In the selection of alternatives, each alternative is compared with others based on each criterion using a similar method. This gives the relative weightage of each alternative under each criterion, which is later multiplied by relative weightage of criteria to obtain the final score of alternatives. 

In this study, 1475 federal funded roads of the city of Columbus are prioritized using the AHP method. Four criteria are used for this evaluation: asset preservation, economic development, safety, and congestion mitigation. The present condition of roads under these criteria is determined by Pavement Condition Rating (PCR), Annual Average Daily Traffic (AADT), Rutting, and Pavement Width of road, respectively. The range of these four data is different from one another. Therefore, they are classified into different groups, as shown in Table 2. The user determines the relative importance of each group based on his/her judgment. 

PCR	  _____________  AADT	_____________ Rutting	_____________ Pavement Width

>=85	_____________  AADT >=5000	_____________  >=5	_____________ >=50 

85>PCR>=75	_____________ 5000>AADT>1000	_____________ <5	_____________  50>P.W.>=20

75>PCR>=65	_____________ 1000>AADT	_____________  20>

65>PCR>=55	 	 	 

55>PCR	 	 	 

MATLAB Computation:
In MATLAB, the criteria for evaluation are presented to the user using a dialog box. For now, the criteria are fixed, which can be made dynamic based on the requirement of the project. After that, the user is asked to make a pairwise comparison of criteria from an input dialog box on a scale of 1 to 10, 5 being equal importance. This input value is later converted into the AHP scale (1/9 to 9). The upper triangle of the criteria comparison matrix is directly obtained from user input (and conversion), and the lower triangle is formed by reciprocal of upper triangular elements. The eigenvector of this matrix is obtained by matrix multiplication and subsequent computations. This eigenvector acts as a weightage of criteria, which is displayed in a bar chart. Next, the weightage for classes of four data types from Table 2 is asked from the user. The sum of the weightage of all classes of one data type must be 1. This weightage is converted into overall weightage by multiplying with the weightage of respective criteria. 
The roadway data is imported as a table using the readtable function. Five columns are added to this table, four for computing score of each criterion and one for the total score. Weightage of each road is calculated under each criterion using for loop, if-else statement, and table operations. The overall score is computed by adding a score of all four criteria and placed in one column of the table. The table is sorted in descending order based on the total score, which gives the rank of roads. The road section with the highest score gets priority during maintenance and rehabilitation works. The final table with ranking of road sections is exported as an excel sheet.



