using CP;

// Define the number of queens
int nb_queens = 6;

// Define the range of queens
range domain = 1..nb_queens;

// Define Decision variables as integers :
//	x[i] = j => There is a queen in the intersection of row i and column j, for all i, j in domain
dvar int x[domain] in domain;

subject to {
  	// There is only 1 queen per column
	allDifferent(all(i in domain) x[i]);
	
	// There is only 1 queen per diagonal axis
	forall(ordered i, j in domain){
	  x[i] - x[j] != j - i;
	  x[j] - x[i] != i - j;
	}
}

execute {
	for(var i in domain){
		for(var j in domain){
			if(x[i] == j) write(" |X| ");
			else write(" | | ");
  		}
  		writeln();	    
	    
	}	
	//for(var i in domain) {
	//  writeln("row : ", i, " => column : ", x[i])
	//}  
}