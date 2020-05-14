import {filter_selector, result_selector, listItems, container, liste_selector} from './selectors.js';
import {listen_to_filter, listen_to_card_click} from './listeners.js';
import {status, apiUrl} from './config.js';

// // avoid module scope with passing function to window object
// window.showCollisions = showCollisions

// result selector global var
let result = null;

export default function listAll(){
	liste_selector.addEventListener('click', () => {
		// show tab
		container.innerHTML = '';
		container.innerHTML = `<div class="header">
			<h4 class="title">All Users</h4>
			<small class="subtitle">Search by CIN, Phone or Mac adresse</small>
			<input type="text" id="filter" placeholder="Search"/>
		</div>
		<ul id="result" class="users-list">
			<div class="loader"></div>
		</ul>`;
		// get the result selector
		result = result_selector();
		// getData
		getData();
		// start listning for filter
		listen_to_filter();
	});
}


function getData() {
	fetch(`${apiUrl}/users`).then(res => res.json()).then(data => { build(data) });
}

function build(data){
	// console.log(data);
		// clear
		result.innerHTML = '';
		
		[...data].forEach(user => {
			const li = document.createElement('li');
				
			// store for filter
			listItems.push(li);
			li.setAttribute(`data-mac`,`${user.mac_adresse}`);
			li.classList.add('pointer');
			li.classList.add('user_card');
			li.innerHTML = `
				<div class="img"></div>
				<div class="user-info">
					<h4>${user.cin} </h4> <div class="${status(user.infected)}"></div>
					<p>Phone : <b>${user.phone}</b></p>
					<p>Mac adresse : <b>${user.mac_adresse}</b></p>
				</div>
			`;
			
			result.appendChild(li);
		});
		// listen to click on card
		listen_to_card_click();
}

