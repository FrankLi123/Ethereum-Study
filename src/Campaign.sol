pragma solidity ^0.4.17;

contract Campaign{

    //struct Request

    struct Request{
        string description;
        uint value;
        address recipient;
        bool complete;
        uint approvalCount;
        mapping(address=> bool) voted;
    }

    // variable
    address public manager;
    uint public minimum;

    // record all Requests from the project manager.
    Request[] public requests;

    // record addresses of all contributors.
    mapping(address=> bool) public contributor_List;

    modifier restricted(){
        require(msg.sender == manager);
        _;
    }

    //constructor
    function Campaign(uint min) public{

            manager = msg.sender;
            minimum = min;
    }


    // function : Project Manager to create a Vendor Request
    function createRequest(string description, uint value, address recipient) public restricted{

        Request memory newRequest = Request({ 

            description: description,
            value : value,
            recipient: recipient,
            complete : false,
            approvalCount: 0
        });

        
        requests.push(newRequest);
    }

    // function: Contributor(investors) to vote for one specific request of funding among all.
    function approveRequest(uint index) public{


        Request storage request = requests[index];

        require(contributor_List[msg.sender]); // check the sender is a contributor(has invested fund) or no.
        require(!request.voted[msg.sender]);// check the sender has voted or not.

        request.voted[msg.sender] = true; // Mark the sender as voted in the inner hashmap.
        request.approvalCount++;

    }

    function contribute() public payable{
        require(msg.value > minimum);
        contributor_List[msg.sender] = true;
    }

}
