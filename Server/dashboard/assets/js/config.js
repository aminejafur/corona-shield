export const apiUrl = 'http://YOUR-IP-HERE:8088';

export function status(infection){
	if(infection == 0){
		return "not_infected";
	}else if(infection == 1){
		return "infected";
	}else{
		return "recovred";
	}

}