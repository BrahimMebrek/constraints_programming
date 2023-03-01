/*
	The problem of assigning n tasks t1, ..., tn to m persons p1, ..., pm with n >= m. 
	
	All the tasks must be assigned. 
	
	Some tasks can only be performed by some persons.
	
	The problem is to determine an assignment minimizing the maximum number of tasks assigned to a person.
	
	To model the problem, two approaches are possible using two types of variables: 
		binary variables or integer variables
	
	To determine which task could be performed by who, we can use 
		- an array of tuples [<t, p>] => task t can be performed by person p
		- an array of list [t:{p1, p2}] => task t can be performed by person p1 and p2
	
	This file contains the modeling in integer variables using an array of lists.
*/

using CP;

// Define the number of tasks and the tasks as a range
int nb_tasks = ...;
range tasks = 1..nb_tasks;

// Define the number of persons and the tasks as a range
int nb_persons = ...;
range persons = 1..nb_persons;

// Define the possible assignement as lists
//  possible_assignement[t] = {p1, p2} => task t could be performed by person p1 and p2
{int} possible_assignement[tasks] = ...;

// Define the decision variables as integers
//	x[t] = p => task t is performed by person p
dvar int x[tasks] in persons;

// Define the maximum number of tasks to be assigned to a person
dvar int max_task;
minimize max_task;

subject to {
    // All tasks must be assigned constraints
	forall(t in tasks) sum(p in possible_assignement[t]) (x[t] == p) == 1;
	
	// The maximum number of tasks assigned to a person
	max_task == max(t1 in tasks) sum(t2 in tasks) (x[t1] == x[t2]);
}

execute {
  writeln("The maximum number of tasks assigned to a person: ", max_task);
  
  writeln("\nAssignement:");
  for(var t in tasks) {
    	writeln("Task ", t, " assigned to person ", x[t]);
    }

}