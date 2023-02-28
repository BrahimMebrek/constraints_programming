/*
	At a conference, speakers must attend a dinner at two different restaurants.
		
	Some speakers are friends, others do not know each other. 
	
	The problem is to distribute the group of speakers in the 2 restaurants 
		in such a way that each one has at least the majority of his friends in the same restaurant 
		(at least as many friends in his restaurant as in the other).
		
	The previous problem does not always have a solution, 
		for example if all the speakers are friends.
*/

using CP;

// Define the number of speakers and the speakers as a range
int nb_speakers = ...;
range speakers = 1..nb_speakers;


// Define the number of restaurants and the restaurants as a range
int nb_restaurants = 2;
range restaurants = 1..nb_restaurants;

// Define the friends of each speaker as a subset of int :
//	friends[i] = {j, k} => the friends of speaker i are j and k, for all i in speakers
{int} friends[speakers] = ...;

// Define the decision variable as integers :
//	restaurant[i] = r => the speaker i is assigned to the restaurant r
dvar int restaurant[speakers] in restaurants ;

subject to {
  	// Each speaker has a least as many friends in his restaurant as in the other
	forall(speaker in speakers) {
		sum(friend in friends[speaker]) (restaurant[speaker] == restaurant[friend]) >= ceil(card(friends[speaker])/2);
	  }
};

execute {
	for(var speaker in speakers) {
		writeln("Speaker ", speaker, " assigned to restaurant ", restaurant[speaker]);  
	}  
}