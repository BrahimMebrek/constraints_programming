/*
	Consider n objects and a similarity matrix A of size n x n 
		where aij are an integer between 0 and 100 representing the similarity between objects i and j. 
	
	The problem is to partition the set of objects into k classes such that 
		we minimize the maximum inter-class similarity
*/

using CP;

// Define the number of objects and the objects as a range
int n = ...;
range object = 1..n;

// Define the number of classes and the classes as a range
int k = ...;
range class = 1..k;

// Define the similarity between objects as a matrix
int similarity[object, object] = ...;

// Define the decision variables as a integer
//	x[i] = j => object i is assigned to class j
dvar int x[object] in class;

// Define the minimal intra-class similarity to maximize
dvar int similarity_max in 0..100;
minimize similarity_max;

subject to {
  	// For each two objects we take 
  	//	the similarity if they are not in same class
  	// The maximum inter-class similarity is the max between all the previous results
	similarity_max == max(ordered i, j in object) ((x[i] != x[j]) * similarity[i, j]);
	
	// Each class should contain at least 1 object
	forall(j in class) sum(i in object) (x[i]==j) >= 1;
}