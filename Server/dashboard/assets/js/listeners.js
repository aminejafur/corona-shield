import {user_card, filter_selector, listItems} from './selectors.js';
import showCollisions from './collisions.js';

export default function listen(){

	menu.addEventListener('click', () => {
		wrapper.classList.toggle("expand");
	});	

	window.onload = function (){
		wrapper.classList.toggle("expand");
	}

}

function filterData(searchTerm) {
	listItems.forEach(item => {
		item.innerText.toLowerCase().includes(searchTerm.toLowerCase()) 
		? item.classList.remove('hide') 
		: item.classList.add('hide');
	});
}

export function listen_to_filter(){
	filter_selector().addEventListener('input', (e) => {
		filterData(e.target.value);
	});
}

export function listen_to_card_click(){
	const cards = user_card();
	
	cards.forEach((card) => {
	   card.addEventListener("click",(e) => {
	   		// console.log(card.getAttribute('data-cin'));
	   		showCollisions(card.getAttribute('data-mac'));
	   });
	  }
	);
}