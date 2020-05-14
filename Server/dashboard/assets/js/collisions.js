import {filter_selector, result_selector, listItems, container, collisions_selector} from './selectors.js';
import {listen_to_filter} from './listeners.js';
import {status, apiUrl} from './config.js';

let result = null;

export default function showCollisions(mac_adresse = null){
	// console.log(mac_adresse);
	if(mac_adresse == null){
	collisions_selector.addEventListener('click', () => {
		buildHeader();
		// getData
		getData();
		// start listning for filter
		listen_to_filter();
	});
	}else{
		buildHeader(mac_adresse);
		// getData
		getData(mac_adresse);
		// start listning for filter
		listen_to_filter();
	}
}

function buildHeader(mac_adresse = null){
		// show tab
		container.innerHTML = '';
		container.innerHTML = `<div class="header">
			${ (mac_adresse) ? '<div class="img"></div>' : ''}
			<br>
			<h4 class="title">${ (!mac_adresse) ? 'Collisions' : 'Collisions with : '+ mac_adresse} </h4>
			<br>
			<small class="subtitle">Search by Cin, Phone, Mac adresse </small>
			<input type="text" id="filter" placeholder="Search" value="${mac_adresse ?? ''}" />
		</div>
		<ul id="result" class="users-list">
			<div class="loader"></div>
		</ul>`;
		// get the result selector
		result = result_selector();
}

function getData(mac_adresse = null) {
	// console.log(`${apiUrl}/collisions/${ (mac_adresse == null) ? '' : mac_adresse }`);
	fetch(`${apiUrl}/collisions/${ (mac_adresse == null) ? '' : mac_adresse }`).then(res => res.json()).then(data => { build(data) });
}

function build(data){
	// console.log(data);

		if(data.error){
			result.innerHTML = `<h3> 404, No collisions found </h3><i style="display: block;text-align: center;margin: 20px auto;font-size: 50px;color: #FFF" class="fas fa-car-crash" aria-hidden="true"></i>`;
		}else{
			// clear
			result.innerHTML = '';

			[...data].forEach(user => {
				const li = document.createElement('li');
				
				// store for filter
				listItems.push(li);
				
				li.innerHTML = `
					<div class="img"></div>
					<div class="user-info">
						<h4>${user.mac_adresse} </h4> <div class="${status(user.infected)}"></div>
						<p>Cin : <b>${user.cin ?? '--'}</b></p>
						<p>Name : <b>${user.name}</b></p>
						<p>Phone : <b>${user.phone ?? '--'}</b></p>
						<p>Date : <b>${user.date}</b></p>
					</div>
				`;
				
				result.appendChild(li);
			});
		}
}