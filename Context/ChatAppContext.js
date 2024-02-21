import React, { useState, useEffect } from 'react';
import { useRouter } from 'next/router';

//INTERNAL IMPORT

import { CheckIfWalletConnected, connectWallet, connectingWithContract } from '../Utils/apiFeature';

export const ChatAppContext = React.createContext();

export const ChatAppProvider = ({ children }) => {
    //USE-STATE
    const [account, setAccount] = useState("");
    const [Name, setName] = useState("");
    const [friendList, setFriendList] = useState([]);
    const [friendMsg, setFriendMsg] = useState([]);
    const [loading, setLoading] = useState(false);
    const [userList, setUserList] = useState([]);
    const [error, setError] = useState("");

    //CAHT USER DATA
    const [currentUserName, setCurrentUserName] = useState("");
    const [currentUserAddress, setCurrentUserAddress] = useState("");

    const router = useRouter();

    //Feath all data time of page
    const fetchData = async() => {
        try{
            //GET CONTRACT
            const contract = await connectingWithContract();
            //GET ACCOUNT
            const connectAccount = await connectWallet();
            setAccount(connectAccount);
            //GET USER NAME
            const userName = await contract.getUsername(connectAccount);
            setUserName(userName);
        }catch(error){
            setError("Please Install Metamask then connect ");
        }
    }
    return (
        <ChatAppContext.Provider value={{}}>
            {children}
        </ChatAppContext.Provider>
    );
};