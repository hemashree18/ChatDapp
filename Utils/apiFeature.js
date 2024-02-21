import { ethers } from 'ethers';
import Web3Model from "web3modal";

import { ChatAppAddress, ChatAppAbi } from "../Context/constents";

export const CheckIfWalletConnected = async () => {
    try {
        if (!window.ethereum) return console.log("Install Metamask");

        const accounts = await window.ethereum.request({
            method: "eth_accounts",
        });
        const firstAccount = accounts[0];
        return firstAccount;
    } catch (error) {
        console.log(error);
    }
};

export const connectWallet = async () => {
    try {
        if (!window.ethereum) return console.log("Install Metamask");

        const accounts = await window.ethereum.request({
            method: "eth_requestAccounts",
        });
        const firstAccount = accounts[0];
        return firstAccount;
    } catch (error) {
        console.log(error);
    }
};

const fetchContract = (signerOrProvider) =>
    new ethers.Contract(ChatAppAbi, ChatAppAddress, signerOrProvider);

export const connectingWithContract = async () => {
    try {
        const web3modal = new Web3Model();
        const connection = await web3modal.connect();
        const provider = new ethers.providers.Web3Model(connection);
        const signer = provider.getSigner();
        const contract = fetchContract(signer);
        return contract;
    } catch (error) {
        console.log(error);
    }
};

export const converTime = (time) => {
    const newTime = new Date(time.toNumber());
    const realTime = newTime.getHours() + ':' + newTime.getMinutes() + ':' + newTime.getSeconds() + ':' + newTime.getDate() + ':' + newTime.getMonth() + ':' + (newTime.getMonth() + 1) + ':' + newTime.getFullYear() ;
    return realTime;
}
