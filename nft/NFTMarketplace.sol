// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
 
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
 
contract NFTMarketplace is ReentrancyGuard {
  using Counters for Counters.Counter;
  Counters.Counter private _nftsSold;
  Counters.Counter private _nftCount;
  uint256 public LISTING_FEE = 0.0001 ether;
  address payable private _marketOwner;
  mapping(uint256 => Token) private _idToToken;
 
  struct Token {
       address nftContract;
       uint256 tokenId;
       address payable seller;
       address payable owner;
       string tokenURI;
       string name;
       uint256 price;
       bool isListed;
   }

  event NFTListed(
    address nftContract,
    uint256 tokenId,
    address seller,
    address owner,
    uint256 price
  );

  event NFTSold(
    address nftContract,
    uint256 tokenId,
    address seller,
    address owner,
    uint256 price
  );
 
  constructor() {
    _marketOwner = payable(msg.sender);
  }
 
 
  // List the NFT on the marketplace
  function listNft(address _nftContract, uint256 _tokenId, string memory _name, string memory _tokenURI) public payable nonReentrant {
    // code
    require(msg.value > 0, "Price must be at least 1 0.0001 ether");
    require(msg.value == LISTING_FEE, "Not enough ether for the listing fee");

    IERC721(_nftContract).transferFrom(msg.sender, address(this), _tokenId);
    
    _nftCount.increment();

    _idToToken[_tokenId] = Token(
        _nftContract,
        _tokenId,
        payable(msg.sender),
        payable(address(this)),
        _tokenURI,
        _name,
        LISTING_FEE,
        true
    );

    emit NFTListed(_nftContract, _tokenId, msg.sender, address(this), LISTING_FEE);
  }


    //      address nftContract;
    //    uint256 tokenId;
    //    address payable seller;
    //    address payable owner;
    //    string tokenURI;
    //    string name;
    //    uint256 price;
    //    bool isListed;

 
  // Buy an NFT
  function buyNFT(address _nftContract, uint256 _tokenId) public payable nonReentrant  {
    // code
  }
 
  // Resell an NFT purchased from the marketplace
  function resellNft(address _nftContract, uint256 _tokenId) public payable nonReentrant {
    // code
  }
 
}
