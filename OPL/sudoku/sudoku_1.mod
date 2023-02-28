using CP;

// Define the number of digits
int nb_digits = 9;

// Define the range of rows and columns
range domain = 1..nb_digits;

// Define subsets that will be used later for the boxes constraints
{int} subset_1 = {1,2,3};
{int} subset_2 = {4,5,6};
{int} subset_3 = {7,8,9};

// Define the initial sudoku to fill as a matrix :
//	matrix[row][colonne] = value between 0 and 9, with 0 => no value on the grid
int data[domain][domain]=...;

// Define decision variables as integers :
//  x[row][colonne] = value between 1 and 9
dvar int x[domain, domain] in domain ;

subject to {
  	
  	// Constraints to initially fill the sudoku
	forall(i, j in domain) if(data[i, j] != 0) x[i, j] == data[i, j];

	// Rows constraints
	forall(i in domain) allDifferent(all(j in domain) x[i,j]);
	
	// Columns constraints
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

execute {
	for(var i in domain) {
	  for(var j in domain){
		write(" ", x[i][j]); 	
	  }
	  writeln();
	}  
}