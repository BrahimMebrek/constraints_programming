using CP;

// Declare the number of digits
int nb_digits = 9;

// Declare the range of rows and columns
range domain = 1..nb_digits;

// Declare subsets that will be used later on constraints
{int} subset_1 = {1,2,3};
{int} subset_2 = {4,5,6};
{int} subset_3 = {7,8,9};

// Declare the initial sudoku to fill as a tuple :
//	tuple{row; colonne; value} with row, column and value between 1 and 9
tuple values {int row; int col; int val;} 
{values} data = ...;

// Decision variables as integers :
//  x[row][colonne] = value between 1 and 9
dvar int x[domain][domain] in domain ;

subject to {
	// Constraints to initially fill the sudoku
	forall(d in data) x[d.row][d.col] == d.val;
  
	// Row constraints
	forall(i in domain) allDifferent(all(j in domain) x[i,j]);
	
	// Column constraints
	forall(j in domain) allDifferent(all(i in domain) x[i,j]);
	
	// Boxes constraints
	allDifferent(all(i in subset_1, j in subset_1) x[i,j]);
	allDifferent(all(i in subset_2, j in subset_1) x[i,j]);
	allDifferent(all(i in subset_3, j in subset_1) x[i,j]);
	
	allDifferent(all(i in subset_1, j in subset_2) x[i,j]);
	allDifferent(all(i in subset_2, j in subset_2) x[i,j]);
	allDifferent(all(i in subset_3, j in subset_2) x[i,j]);
	
	allDifferent(all(i in subset_1, j in subset_3) x[i,j]);
	allDifferent(all(i in subset_2, j in subset_3) x[i,j]);
	allDifferent(all(i in subset_3, j in subset_3) x[i,j]);
}