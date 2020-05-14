import {container} from './selectors.js';

export default function ShowDefault(){
		// show tab
		container.innerHTML = '';
		container.innerHTML = `<div class="comming_soon">
			<span>
			<h3> Welcome, </h3> 
			<h3 style="font-size:15px;padding:5px" >
			<p style="font-weight: 100;" >Corona Shield is an open sourced Corona Tracking Mobile Application with Back-end made by Amine Jafur using Flutter, PHP, JS, <br><a style="color:#7a90fd" href="https://github.com/aminejafur/corona-shield" target="_blank">Read More</a></p> </h3> 
			</span>
		</div>`;
}
