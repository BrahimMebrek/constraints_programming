/*
	Same problem as the conferences.mod file 
		with the objective of maximizing the number of speakers 
		who have at least the majority of their friends in the same restaurant as themselves.
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

// Define the number of speakers to maximize
int nb;
maximize nb;

subject to {
  	// maximizing the number of speakers who have at least the majority of their friends in the same restaurant as themselves
	nb == sum(speaker in speakers) (sum(friend in friends[speaker]) (restaurant[speaker] == restaurant[friend]) >= ceil(card(friends[speaker])/2));
}

execute {
	for(var speaker in speakers) {
		writeln("Speaker ", speaker, " assigned to restaurant ", restaurant[speaker]);  
	}  
}