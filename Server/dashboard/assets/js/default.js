import {container} from './selectors.js';

export default function ShowDefault(){
		// show tab
		container.innerHTML = '';
		container.innerHTML = `<div class="comming_soon">
			<span>
			<h3> Welcome, </h3> 
			<h3 style="font-size:15px;padding:5px" >
			<p style="font-weight: 100;" >Morocco Corona Shield is an app that ..., consectetur adipiscing elit. Fusce non turpis pretium, finibus nibh eget, dictum nisl. Aliquam bibendum vitae nunc ac consequat. Cras aliquam volutpat eros, vel faucibus nibh bibendum nec.</p> </h3> 
			</span>
		</div>`;
}
