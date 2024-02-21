// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract Chatapp{
    //user struct
    struct user {
        string name;
        friend[] frindList;
    }
    struct friend {
        address pubkey;
        string name;
    }
    struct message {
        address sender;
        uint256 timestamp;
        string msg;
    }
    struct AllUserAtruct{
        string name;
        address accountAddress;
    }
    AllUserAtruct[] getALLusers;

    mapping(address => user) userList;
    mapping(bytes32 => message[]) allMessage;

    //check user exit
    function checkUserExit(address publickey) public view returns (bool) {
        return bytes(userList[publickey].name).length > 0;
    }

    //create account
    function createAccount(string calldata name) external {
        require(checkUserExit(msg.sender) == false, "alredy exist");
        require(bytes(name).length > 0, "username cant empty string");

        userList[msg.sender].name = name;

        getALLusers.push(AllUserAtruct(name,msg.sender));
    }

    //get user name
    function getUsername(address pubkey) external view returns (string memory) {
        require(checkUserExit(pubkey), "user not registered");
        return userList[pubkey].name;
    }

    //add friends
    function addFriend(address friend_key, string calldata name) external {
        require(checkUserExit(msg.sender), "create an account");
        require(checkUserExit(friend_key), "user is not registerd");
        require(msg.sender != friend_key, "cant add them self as a friend");
        require(
            checkAlerdyFriend(msg.sender, friend_key) == false,
            "this user is alredy friend"
        );
        _addFriend(msg.sender, friend_key, name);
        _addFriend(friend_key, msg.sender, userList[msg.sender].name);
    }

    //check alreday frined
    function checkAlerdyFriend(
        address pubkey1,
        address pubkey2
    ) internal view returns (bool) {
        if (
            userList[pubkey1].frindList.length >
            userList[pubkey2].frindList.length
        ) {
            address tmp = pubkey1;
            pubkey1 = pubkey2;
            pubkey2 = tmp;
        }
        for (uint256 i = 0; i < userList[pubkey1].frindList.length; i++) {
            if(userList[pubkey1].frindList[i].pubkey == pubkey2) return true;
        }
        return false;
    }

    function _addFriend(
        address me,
        address frined_key,
        string memory name
    ) internal {
        friend memory newFrined = friend(frined_key, name);
        userList[me].frindList.push(newFrined);
    }

    //getmy frineds
    function getMyFriends() external view returns (friend[] memory) {
        return userList[msg.sender].frindList;
    }

    //get chat code
    function _getChatcode(
        address pubkey1,
        address pubkey2
    ) internal pure returns (bytes32) {
        if (pubkey1 < pubkey2) {
            return keccak256(abi.encodePacked(pubkey1, pubkey2));
        } else {
            return keccak256(abi.encodePacked(pubkey2, pubkey1));
        }
    }
    //send message
    function sendMessage(address friend_key,string calldata _msg)external{
        require(checkUserExit(msg.sender),"Create a account First");
        require(checkUserExit(friend_key),"usetr is not register");
        require(checkAlerdyFriend(msg.sender,friend_key),"Your mnot frined with address");
        bytes32 chatCode = _getChatcode(msg.sender,friend_key);
        message memory newMsg = message(msg.sender,block.timestamp,_msg);
        allMessage[chatCode].push(newMsg);
    }
    //Read messgae
    function readMessage(address friend_key) external view  returns (message[] memory) {
        bytes32 ChatCode = _getChatcode(msg.sender,friend_key);
        return allMessage[ChatCode];
    }
    function getAllUsersInApp() public view returns(AllUserAtruct[] memory){
        return getALLusers;
    }
}
