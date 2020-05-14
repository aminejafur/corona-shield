import {container, exit_selector} from './selectors.js';

export default function exit(){
	exit_selector.addEventListener('click', () => {
		// show tab
		container.innerHTML = '';
		container.innerHTML = `<div class="comming_soon">
			<span>
			<h3> Coming soon <i class="fas fa-door-open" aria-hidden="true"></i></h3> 
			<div class="loader"></div>
			</span>
		</div>`;
	});
}
