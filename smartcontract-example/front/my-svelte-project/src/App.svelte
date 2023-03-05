<script>
	export let name;
	/*****************************************/
	/* Detect the MetaMask Ethereum provider */
	/*****************************************/
	import detectEthereumProvider from '@metamask/detect-provider';
	import Web3 from 'web3';

	async function loadWeb3() {
		// this returns the provider, or null if it wasn't detected
		const provider = await detectEthereumProvider();

		if (provider) {
			startApp(provider); // Initialize your app
		} else {
			console.log('Please install MetaMask!');
		}
	}

	function startApp(provider) {
		// If the provider returned by detectEthereumProvider is not the same as
		// window.ethereum, something is overwriting it, perhaps another wallet.
		if (provider !== window.ethereum) {
			console.error('Do you have multiple wallets installed?');
		}
		// Access the decentralized web!
	}
	
	/***********************************************************/
	/* Handle user accounts and accountsChanged (per EIP-1193) */
	/***********************************************************/

	let currentAccount = null;

	async function GetAccount() {
		let accounts = await ethereum.request({ method: 'eth_accounts' });
		handleAccountsChanged(accounts);
		
		const blockNumber = await ethereum.request({ method: 'eth_blockNumber' });
	 	console.log('blockNumber: ' + parseInt(blockNumber));
		
		return accounts[0];
	}
	
	// Note that this event is emitted on page load.
	// If the array of accounts is non-empty, you're already
	// connected.
	ethereum.on('accountsChanged', handleAccountsChanged);

	// For now, 'eth_accounts' will continue to always return an array
	function handleAccountsChanged(accounts) {
		if (accounts.length === 0) {
			// MetaMask is locked or the user has not connected any accounts
			console.log('Please connect to MetaMask.');
		} else if (accounts[0] !== currentAccount) {
			currentAccount = accounts[0];
			console.log(currentAccount);
			// Do any other work!
		}
	}

	/*********************************************/
	/* Access the user's accounts (per EIP-1102) */
	/*********************************************/

	// While you are awaiting the call to eth_requestAccounts, you should disable
	// any buttons the user can click to initiate the request.
	// MetaMask will reject any additional requests while the first is still
	// pending.
	function connect() {
		ethereum
			.request({ method: 'eth_requestAccounts' })
			.then(handleAccountsChanged)
			.catch((err) => {
				if (err.code === 4001) {
					// EIP-1193 userRejectedRequest error
					// If this happens, the user rejected the connection request.
					console.log('Please connect to MetaMask.');
				} else {
					console.error(err);
				}
			});
	}

	import Hero from '../../../build/contracts/Hero.json'
	async function GetInfoFromContract() {
		const web3 = new Web3(ethereum);
		const contract = new web3.eth.Contract(Hero.abi, '0x3881878332032C46754f4A6202eCD0335Ee1CCe9');
		let result = await contract.methods.getHero().call();
		name = result;

		await contract.methods.setHero('Bart').send({ from: currentAccount });
	}

</script>

<main>
	<!-- svelte-ignore empty-block -->
	{#await GetAccount() then value}
		<p>{value}</p>
  	{/await}
	<h1>Hello {name}!</h1>
	
	<button on:click={connect}>Connect wallet!</button>
	
	<button on:click={GetInfoFromContract}>Get Hero!</button>
</main>

<style>
	main {
		text-align: center;
		padding: 1em;
		max-width: 240px;
		margin: 0 auto;
	}

	h1 {
		color: #ff3e00;
		text-transform: uppercase;
		font-size: 4em;
		font-weight: 100;
	}

	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>