pragma solidity ^0.4.17;

contract Lottery{

    address public manager; // ** public
    address[] public players;

    //**: constrcutor
    function Lottery() public{
        manager = msg.sender; //**:  msg
    }


    function enter() public payable {

        require(msg.value > .01 ether); //**: 

        players.push(msg.sender);

       
    }

    function random() private view returns(uint){
          return uint( keccak256(block.difficulty, now, players) );
    }

    function pickWinner() public {
      
            require(manager == msg.sender);     
            uint index = random() % players.length; 
            players[index].transfer(this.balance);

            players = new address[](0); // dynamic array
     
    }

    function getPlayers() public view returns(address[]){
        return players;
    }




}
