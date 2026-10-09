// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract NewBTC {
    string public name = "New Bitcoin";
    string public symbol = "nBTC";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    uint256 public constant MAX_SUPPLY = 21000000 * 10**18;
    uint256 public reward = 50 * 10**18;
    bytes32 public challenge;
    mapping(address=>uint256) public balanceOf;
    constructor(){challenge=keccak256(abi.encodePacked(block.timestamp));}
    function mine(uint256 nonce) public {
        bytes32 hash = keccak256(abi.encodePacked(challenge, msg.sender, nonce));
        require(uint256(hash) % 10000 == 0, "Invalid nonce");
        balanceOf[msg.sender]+=reward;
        totalSupply+=reward;
        challenge=hash;
    }
    function transfer(address to, uint256 amount) public returns(bool){
        require(balanceOf[msg.sender]>=amount);
        balanceOf[msg.sender]-=amount;
        balanceOf[to]+=amount;
        return true;
    }
}
