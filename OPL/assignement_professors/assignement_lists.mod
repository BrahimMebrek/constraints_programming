/*
	Assignment problem: n professors P1, ..., Pn have to teach m classes C1, ..., Cm. 
	
	Considering the teaching needs, only some associations (professor, class) must be realized. 

	It will be assumed that a professor does not teach more than one class during the same time slot 
		and that a class cannot have more than one professor during the same time slot. 

	Knowing that the classes are all of the same length and that there is no limit to the number of classrooms, 
		determine the minimum number of time slots needed to conduct all the classes.

	To determine which class should be conducted by which professor, we can use 
	- an array of tuples [<c, p>] => class c should be conducted by professor p
	- an array of list [c:{p1, p2}] => class c should be conducted by professors p1 and p2
	
	This file contains the modeling in binary variables using an array of lists.
*/

using CP;

// Define the number of classes and the classes as a range
int nb_classes = ...;
range classes = 1..nb_classes;

// Define the number of professors and the professors as a range
int nb_professors = ...;
range professors = 1..nb_professors ;

// Define the maximum possible number of time slots and the time slots as a range
int max_nb_timeslots = nb_professors * nb_classes;
range timeslots= 1..max_nb_timeslots;

// Define the possible associations as lists
//  associations[p] = {c1, c2} => professor p should conduct classes c1 and c2
{int} associations[professors] = ...;

// Define the decision variables as integers:
//	x[p][c] = t => professor p conduct class c in time slot t
dvar int x[professors][classes] in timeslots;

// Define the number of time slots to minimize
dvar int nb_timeslots;
minimize nb_timeslots;

subject to {
  	// A professor does not teach more than one class during the same time slot constraints
	forall(p in professors) allDifferent(all(c in associations[p]) x[p][c]);
	
	// A class cannot have more than one professor during the same time slot constraints
	forall(c in classes) allDifferent(all(p in professors) x[p][c]);
	
	// The number of time slots
	nb_timeslots== max(p in professors, c in associations[p]) x[p][c];
}


execute {
	writeln("The minimum number of time slots required: ", nb_timeslots);
	
	writeln("\nAssignements :");
	for(var p in professors) {
		for(var c in associations[p]){
			  writeln("Professor ", p," conduct the Class ", c,  " during the Time slot ", x[p][c]);
	  	}
    }
}
