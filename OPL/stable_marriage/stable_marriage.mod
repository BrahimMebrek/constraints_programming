/* In the problem, each member of one set (men) has a preference list 
	ranking the members of the other set (women), and vice versa. 
	
	The goal is to find a matching between men and women that is stable, meaning 
		there is no pair of a man and a woman who would both prefer each other over their current partners.

	Formally, a matching is considered stable if and only if there is no pair (m, w) and (m', w') such that 
		m prefers w' to his current partner w and w' prefers m to her current partner m', 
		and in such a case, m and w' would "elope" and leave their partners behind.
*/

using CP;

// Define the number of women and men
int nb_women = ...;
int nb_men = ...;

// Define the women and men as ranges
range women = 1..nb_women;
range men = 1..nb_men;

// Define the name of women and men as strings
string name_women[women] = ...;
string name_men[men] = ...;

// Define the ranking of men by the women and the ranking of women by the men
int rank_women[women][men] = ...;
int rank_men[men][women] = ...;

// Define the binary decision variables as booleans , 
//	x[w][m] = 1 if the woman w is married to the man m, 0 otherwise
dvar boolean x[women][men];

subject to {
	// Each woman is married to 1 man
	forall (w in women) sum(m in men) x[w][m] == 1;
	// Each man is married to 1 woman
	forall (m in men) sum(w in women) x[w][m] == 1;
	
	forall(w in women, m in men) {
	  	// If a woman w prefers a man m, then m should prefer his wife to w
		(rank_women[w][m] > sum(j in men) (x[w][j] * rank_women[w][j])) => (rank_men[m][w] <= sum(i in women) (x[i][m] * rank_men[m][i]));
	  	// If a man m prefers a woman w, then w should prefer her husband to m
		(rank_men[m][w] > sum(i in women) (x[i][m] * rank_men[i][m])) => (rank_women[w][m] <= sum(j in men) (x[w][j] * rank_women[w][j]));
	}				
}

execute {
  for(var w in women) {
    for(var m in men) {
    	if(x[w][m] == 1)
    		writeln(name_women[w], " (", w, ") is married to ", name_men[m], " (", m, ")");
   		}    	
    }

}

