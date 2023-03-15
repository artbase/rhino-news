<script>
    export let number;
    export let numberOfBlocks;

    import { onMount } from 'svelte';
    import Web3 from 'web3';
    import detectEthereumProvider from '@metamask/detect-provider';
    import SimpleLogger from '../../../logs-smartcontract/build/contracts/SimpleLogger.json'

    let web3 = null;
    let logContract = null;
    let currentAccount = null;
    const contractAddress = '0x28B1DB32D5FdF5624Ec5c44eA945C1b6978E830E';

    async function loadWeb3() {
		// this returns the provider, or null if it wasn't detected
		const provider = await detectEthereumProvider();

		if (provider) {
			// If the provider returned by detectEthereumProvider is not the same as
            // window.ethereum, something is overwriting it, perhaps another wallet.
            if (provider !== window.ethereum) {
                console.error('Do you have multiple wallets installed?');
            }
            // Access the decentralized web!
            web3 = new Web3(ethereum);
	        logContract = new web3.eth.Contract(SimpleLogger.abi, contractAddress);
		} else {
			console.log('Please install MetaMask!');
		}
	}

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
        ethereum.on('accountsChanged', handleAccountsChanged);
	}
	
    async function GetInfoFromContract() {	
		let result = await logContract.methods.retrieve().call();
		number = result;
	}

    async function SetNewNumber() {
        await logContract.methods.store(++number).send({ from: currentAccount });
        await GetInfoFromContract();
    }

    onMount(async () => {
        await loadWeb3();
        // ==================================
        var subscription = web3.eth.subscribe('logs', {
                address: '0x28B1DB32D5FdF5624Ec5c44eA945C1b6978E830E',
                topics: [web3.utils.sha3('storedNumber(uint256,uint256,address)')]
            }, function(error, result){
                if (!error)
                    console.log('Log from subscription: ');
                    console.log(result);
            });
        // ==================================
        let latest = await web3.eth.getBlock("latest");
        numberOfBlocks = latest.number;
        // ==================================
        let logs = await web3.eth.getPastLogs({
                address: '0x28B1DB32D5FdF5624Ec5c44eA945C1b6978E830E',
                topics: [web3.utils.sha3('storedNumber(uint256,uint256,address)')],
                fromBlock: '1'
            });
        console.log('Logs from history: ');
        console.log(logs);
        // ==================================
        let result = await logContract.getPastEvents('storedNumber', {
            fromBlock: 1
        });
        console.log('Logs from history of contract: ');
        console.log(result);
        // ==================================
        console.log('decoded: ' + result[5].raw.data);
        let encoded = await web3.eth.abi.decodeLog(SimpleLogger.abi[0].inputs, result[5].raw.data, result[5].raw.topics);
        console.log(SimpleLogger.abi[0].inputs);
        console.log('encoded: ');
        console.log(encoded);
        // ==================================
        var provider = 'https://bsc-testnet.nodereal.io/v1/e9a36765eb8a40b9bd12e680a1fd2bc5'; // Add your nodereal HTTP provider link here
        var web3Provider = new Web3.providers.HttpProvider(provider);
        var web3 = new Web3(web3Provider);
        

        connect();
        await GetInfoFromContract();
	});
   
</script>


<h1>Welcome to ArtBase Web3App</h1>
<h2>Hello {number}!</h2>
<h2>Number of blocks: {numberOfBlocks}!</h2>
<button on:click={SetNewNumber}>Get Hero!</button>